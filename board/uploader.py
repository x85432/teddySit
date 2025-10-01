"""
Dual-thread version — cost-saving batch send mode (Cloud Function mode)
Thread 1: dedicated to receiving messages (local port)
Thread 2: dedicated to sending messages (accumulates data, then sends in batches to the Cloud Function)
Security is provided by including an API key in HTTP requests.
Uses only Python standard libraries.
"""

import json
import time
import random
import threading
from datetime import datetime   
from http.server import HTTPServer, BaseHTTPRequestHandler
import urllib.request
import urllib.error
import urllib.parse
from on_off_gatt_server import start_ble_server  # BLE Control

CLOUD_FUNCTION_URL = "https://us-central1-teddysitdb.cloudfunctions.net/process_sensor_data" 
API_KEY = "API_KEY"

class MessageReceiver(BaseHTTPRequestHandler):
    """Thread 1: Receives messages from external sources"""
    
    def do_GET(self):
        """Process GET requests - Status query"""
        status_data = {
            "device_id": "daniel",
            "status": "running",
            "current_time": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "message": "i.MX 93 simulated board is running",
            "buffer_size": getattr(self.server, 'buffer_size', 0),
            "total_sent": getattr(self.server, 'total_sent', 0)
        }
        
        self.send_response(200)
        self.send_header('Content-Type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps(status_data).encode('utf-8'))
        
        print(f"[Thread 1 - Receiver] GET Status")
    
    def do_POST(self):
        """Process POST requests - Receive external messages"""
        try:
            # 讀取 POST 資料
            content_length = int(self.headers.get('Content-Length', 0))
            post_data = self.rfile.read(content_length)
            received_message = json.loads(post_data.decode('utf-8'))
            
            with self.server.data_buffer_lock:
                self.server.data_buffer.append(received_message)

            print(f"\n [Thread 1 - Receiver] Received message:")
            
            if 'command' in received_message:
                if received_message['command'] == 'flush':
                    print("Received immediate send command")
            
            response_data = {
                "status": "success",
                "message": "Message received and cached successfully",
                "received_at": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            }
            
        except json.JSONDecodeError:
            response_data = {
                "status": "error",
                "message": "Invalid JSON format"
            }
        except Exception as e:
            response_data = {
                "status": "error", 
                "message": f"Error processing: {str(e)}"
            }
        
        self.send_response(200)
        self.send_header('Content-Type', 'application/json')
        self.end_headers()
        self.wfile.write(json.dumps(response_data).encode('utf-8'))
    
    def log_message(self, format, *args):
        """Close default HTTP logs"""
        pass

class Board:    
    def __init__(self):
        self.device_id = "daniel"
        self.cloud_function_url = CLOUD_FUNCTION_URL
        self.api_key = API_KEY
        self.local_port = 8080
        
        self.collect_interval = 30
        self.batch_size = 5
        
        self.data_buffer = []
        self.buffer_lock = threading.Lock()
        
        self.stats = {
            'collected': 0,
            'batches_sent': 0,
            'total_sent': 0,
            'failed': 0
        }
        
        self.running = True
        self.server = None
        self.use_unique_id = False
        self.last_flag = False
        
        print(f"🚀 Simulated i.MX 93 board started (Cost-saving batch mode - Cloud Function)")
        print(f"📱 Device ID: {self.device_id}")
        print(f"🔗 Firebase URL: {self.cloud_function_url}")
        print(f"📡 Local receiver port: {self.local_port}")
        
    def generate_sensor_data(self):
        """Generate one sensor data"""
        temperature = round(random.uniform(20.0, 30.0), 2)
        humidity = round(random.uniform(50.0, 70.0), 2)
        
        current_device_id = self.device_id
        if self.use_unique_id:
            current_device_id = f"{self.device_id}_{int(time.time() * 1000)}_{random.randint(0, 999)}"

        return {
            "device_id": current_device_id,
            "timestamp": int(time.time()),
            "temperature": temperature,
            "humidity": humidity,
            "handsomity": 100
        }
    
    def send_batch_data(self):
        """Send accumulated data to Cloud Function in batches"""
        if not self.cloud_function_url or not self.api_key:
            print("❌ Cloud Function URL or API key not provided. Skipping send.")
            return
            
        with self.buffer_lock:
            if not self.data_buffer:
                return
            
            data_to_send = self.data_buffer.copy()
            data_count = len(self.data_buffer)
            self.data_buffer.clear()
        
        print(f"\n💰 [Thread 2 - Batch send] Start sending {data_count} data to Cloud Function")
        print(f"   Batch #{self.stats['batches_sent']+1}")
        
        payload = {
            "device_id": self.device_id,
            "messages": data_to_send
        }
        
        payload_bytes = json.dumps(payload, ensure_ascii=False).encode('utf-8')
        
        try:
            req = urllib.request.Request(
                self.cloud_function_url,
                data=payload_bytes,
                headers={'Content-Type': 'application/json', 'X-API-Key': self.api_key},
                method='POST'
            )
            
            with urllib.request.urlopen(req) as response:
                response_data = json.loads(response.read().decode('utf-8'))
                print(f"   ✅ Successfully sent! Cloud Function response: {response_data}")
                success_count = data_count
                fail_count = 0
                
        except urllib.error.HTTPError as e:
            error_message = e.read().decode('utf-8')
            print(f"   ❌ HTTP error: {e.code} - {e.reason}, Server response: {error_message}")
            print(f"      Server response: {error_message}")
            success_count = 0
            fail_count = data_count
        except urllib.error.URLError as e:
            print(f"   ❌ URL error: {e.reason}")
            success_count = 0
            fail_count = data_count
        except Exception as e:
            print(f"   ❌ Send failed: {e}")
            success_count = 0
            fail_count = data_count

        self.stats['batches_sent'] += 1
        self.stats['total_sent'] += success_count
        self.stats['failed'] += fail_count
        
        print(f"\n   ✅ Success: {success_count}/{data_count} data")
        if fail_count > 0:
            print(f"   ⚠️  Failed: {fail_count} data")
        print(f"   📊 Total sent: {self.stats['total_sent']} data (Failed: {self.stats['failed']} data)")
    
    def receiver_thread(self):
        """Thread 1: Dedicated to receiving messages"""
        print(f"📡 [Thread 1] Start message receiver, listen port {self.local_port}")
        print(f"   Test URL: http://localhost:{self.local_port}")
        
        try:
            self.server = HTTPServer(('localhost', self.local_port), MessageReceiver)
            self.server.data_buffer = self.data_buffer
            self.server.data_buffer_lock = self.buffer_lock
            self.server.buffer_size = 0
            self.server.total_sent = 0
            
            self.server.timeout = 1.0
            
            while self.running:
                self.server.handle_request()
                with self.buffer_lock:
                    self.server.buffer_size = len(self.data_buffer)
                    self.server.total_sent = self.stats['total_sent']
                
        except Exception as e:
            if self.running:
                print(f"❌ [Thread 1] Receiver error: {e}")
    
    def sender_thread(self):
        """Thread 2: 💰 Cost-saving mode - Send accumulated data in batches"""
        print(f"📤 [Thread 2] Start batch sender (only send external received data)")
        print(f"   When the cache is full {self.batch_size} data, pack and send to Firebase Cloud Function")
        
        while self.running:
            from on_off_gatt_server import upload_enabled  
            try:
                # sensor_data = self.generate_sensor_data()
                # with self.buffer_lock:
                #     self.data_buffer.append(sensor_data)
                #     buffer_size = len(self.data_buffer)
                # self.stats['collected'] += 1
                # print(f"[Thread 2 - Collect] ... Cache: {buffer_size}/{self.batch_size}")

                if not upload_enabled:
                    self.last_flag = False
                    print("[Upload Stopped]")
                    time.sleep(1)
                    continue

                if self.last_flag is False and upload_enabled is True:
                    with self.buffer_lock:
                        self.data_buffer.clear()
                self.last_flag = True

                with self.buffer_lock:
                    buffer_size = len(self.data_buffer)

                if buffer_size >= self.batch_size:
                    self.send_batch_data()
                else:
                    # Small sleep to avoid CPU idle
                    time.sleep(0.2)
                
            except KeyboardInterrupt:
                break
            except Exception as e:
                print(f"❌ [Thread 2] Sender error: {e}")
                time.sleep(1)
    
    def cleanup(self):
        """Cleanup function - Send remaining data"""
        with self.buffer_lock:
            if self.data_buffer:
                print(f"\n🔄 Send remaining {len(self.data_buffer)} data before program ends...")
        
        self.send_batch_data()
    
    def start(self):
        """Start dual Thread system"""
        print("\n" + "="*60)
        print("🎯 Start dual Thread simulated board (Cost-saving batch mode - Cloud Function)")
        print(f"Thread 1: On http://localhost:{self.local_port} receive messages")
        print(f"Thread 2: Collect data every {self.collect_interval} seconds")
        print(f"         Send accumulated {self.batch_size} data in batches to the cloud")
        print("Press Ctrl+C to stop")
        print("="*60)
        
        try:
            receiver = threading.Thread(target=self.receiver_thread)
            receiver.daemon = True
            receiver.start()
            
            time.sleep(1)
            
            print("\n💡 Test command:")
            print(f"   Check status: iwr http://localhost:{self.local_port}")
            print(f"   Send message: iwr -X POST http://localhost:{self.local_port} \\")
            print(f"             -H 'Content-Type: application/json' \\")
            print(f"             -d '{{\"message\":\"hello\",\"from\":\"external source\"}}'")
            print()
            
            self.sender_thread()
            
        except KeyboardInterrupt:
            print(f"\n🛑 User pressed Ctrl+C, stopping...")
            self.stop()
        except Exception as e:
            print(f"❌ Start error: {e}")
            self.stop()
    
    def stop(self):
        """Stop system"""
        print("🔄 Stopping dual Thread system...")
        self.running = False
        
        self.cleanup()
        
        if self.server:
            self.server.shutdown()
        
        print("✅ System stopped")
        print(f"\n📊 Final statistics:")
        print(f"    Total collected data: {self.stats['collected']} data")
        print(f"    Total sent batches: {self.stats['batches_sent']} times")
        print(f"    Success sent: {self.stats['total_sent']} data")
        print(f"    Failed: {self.stats['failed']} data")
        
        if self.stats['collected'] > 0:
            success_rate = (self.stats['total_sent'] / self.stats['collected']) * 100
            print(f"    Success rate: {success_rate:.1f}%")

def main():
    if CLOUD_FUNCTION_URL == "https://your-firebase-project-id.cloudfunctions.net/yourFunctionName" or API_KEY == "your-super-secret-api-key":
        print("❌ Error: Please modify CLOUD_FUNCTION_URL and API_KEY in the code!")
        return

    try:    
        print("=== Dual Thread i.MX 93 simulated board - 💰 Cost-saving mode (Cloud Function) ===")
        print("Mode: Batch send (write to Firebase through Cloud Function)")
        print("(Press Enter to use default values)")
        print()
        
        port_input = input(f"Receiver port (default 8080): ").strip()
        collect_input = input(f"Data collection interval (default 30): ").strip()
        batch_input = input(f"Accumulate how many data to send (default 5): ").strip()
        
        print("\n⚠️  Firebase data overwrite problem:")
        print("If you want to add a new document each time instead of overwriting,")
        print("Please modify the write logic in your Cloud Function.")
        unique_input = input("Use unique device_id to avoid overwriting? (y/N): ").strip().lower()
        
        board = Board()
        
        if port_input:
            board.local_port = int(port_input)
        if collect_input:
            board.collect_interval = int(collect_input)
        if batch_input:
            board.batch_size = int(batch_input)
        if unique_input == 'y':
            board.use_unique_id = True
            print("✅ Will use unique ID (daniel_timestamp)")
        else:
            print("⚠️ Will use fixed ID (daniel), data may be overwritten.")

        send_interval = board.collect_interval * board.batch_size
        calls_per_hour = 3600 // board.collect_interval if board.collect_interval > 0 else 0
        batch_per_hour = 3600 // send_interval if send_interval > 0 else 0
        
        print(f"\n💰 Cost-saving calculation:")
        print(f"   Collect 1 data every {board.collect_interval} seconds")
        print(f"   Send 1 batch of data ( {board.batch_size} data) to Cloud Function every {send_interval} seconds")
        print(f"   Collect about {calls_per_hour} data per hour")
        print(f"   Send about {batch_per_hour} requests per hour")
        print(f"   Automatically send remaining data when the program stops")
        
        confirm = input("\nStart running? (Y/n): ").strip().lower()
        if confirm == 'n':
            print("👋 Bye!")
            return
        
        board.start()
        
    except ValueError:
        print("❌ Please enter a valid number!")
    except KeyboardInterrupt:
        print("\n👋 Bye!")
    except Exception as e:
        print(f"❌ Program error: {e}")

if __name__ == "__main__":
    ble_thread = threading.Thread(target=start_ble_server)
    ble_thread.daemon = True
    ble_thread.start()
    main()
