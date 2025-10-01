from dperson import dperson
from poseLandmarker_realtime import poseLandmarker
import cv2
import time
import numpy as np
import json
import urllib.request
import urllib.error
import threading

# Model paths
PERSON_DETECTION_MODEL = "models/dperson_shufflenetv2_vela.tflite"
POSE_LANDMARK_MODEL = "models/movenet.tflite"

# Thresholds
PERSON_DETECTION_THRESHOLD = 0.5

# Local receiver (test.py) endpoint
RECEIVER_URL = "http://localhost:8080"

class RealtimePoseDetection:
    def __init__(self):
        print("Initializing models...")
        self.detector = dperson(PERSON_DETECTION_MODEL)
        self.pose_landmarker = poseLandmarker(POSE_LANDMARK_MODEL)
        
        # Performance tracking
        self.fps_counter = 0
        self.fps_start_time = time.time()
        self.current_fps = 0
        
        # Processing flags
        self.skip_frames = 0  # Process every nth frame for better performance
        self.frame_count = 0

        # Outbound send throttling
        self.last_send_time = 0.0
        self.send_interval_sec = 1.0  # send at most once per second
        
        print("Models loaded successfully!")

    def _serialize_landmarks(self, landmarks_array):
        """Convert landmarks ndarray (N x 2 or N x 3) to JSON-serializable list"""
        serialized = []
        for i in range(landmarks_array.shape[0]):
            point = landmarks_array[i]
            item = {"y": float(point[0]), "x": float(point[1])}
            if len(point) > 2:
                item["score"] = float(point[2])
            serialized.append(item)
        return serialized

    def _send_pose_to_receiver(self, person_count, landmarks_array):
        """POST pose data to local receiver (test.py). Non-blocking best-effort."""
        try:
            #print(self._serialize_landmarks(landmarks_array)[5]['score'], self._serialize_landmarks(landmarks_array)[5]['x'], self._serialize_landmarks(landmarks_array)[5]['y'])
            payload = {
                "device_id": "daniel",
                "timestamp": int(time.time()),
                "person_count": int(person_count),
                "landmarks": self._serialize_landmarks(landmarks_array),
            }
            data_bytes = json.dumps(payload, ensure_ascii=False).encode("utf-8")
            req = urllib.request.Request(
                RECEIVER_URL,
                data=data_bytes,
                headers={"Content-Type": "application/json"},
                method="POST",
            )
            # Small timeout to avoid blocking realtime loop
            urllib.request.urlopen(req, timeout=0.2).read()
        except Exception:
            # Silently ignore network errors to keep realtime loop smooth
            pass

    def draw_fps(self, image, fps):
        """Draw FPS counter on image"""
        cv2.putText(image, f'FPS: {fps:.1f}', (10, 30), 
                   cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)

    def draw_detection_info(self, image, person_count):
        """Draw detection information on image"""
        status = f'Persons detected: {person_count}'
        cv2.putText(image, status, (10, 70), 
                   cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 255, 255), 2)

    def process_frame(self, frame):
        """Process a single frame"""
        start_time = time.time()
        
        # Person detection
        bboxes = self.detector.detect(frame, PERSON_DETECTION_THRESHOLD)
        
        # Draw person detection bounding boxes
        if len(bboxes) > 0:
            #frame = self.detector.show(frame)
            
            # Pose estimation on the whole frame
            # Note: For better performance, you might want to crop to person bbox
            pose_output = self.pose_landmarker.run_inference(frame)
            landmarks = pose_output[0, 0, ...]
            
            # Draw pose landmarks
            frame = self.pose_landmarker.draw_landmarks(frame, landmarks)

            # Throttled send of landmarks to local receiver
            now = time.time()
            if now - self.last_send_time >= self.send_interval_sec:
                self._send_pose_to_receiver(len(bboxes), landmarks)
                self.last_send_time = now
        
        # Calculate processing time
        processing_time = time.time() - start_time
        
        return frame, len(bboxes), processing_time

    def update_fps(self):
        """Update FPS counter"""
        self.fps_counter += 1
        current_time = time.time()
        if current_time - self.fps_start_time >= 1.0:
            self.current_fps = self.fps_counter / (current_time - self.fps_start_time)
            self.fps_counter = 0
            self.fps_start_time = current_time

    def run(self, camera_id=0):
        """Main loop for real-time processing"""
        print(f"Starting camera {camera_id}...")
        
        # Initialize camera
        cap = cv2.VideoCapture(camera_id)
        
        if not cap.isOpened():
            print(f"Error: Cannot open camera {camera_id}")
            return
        
        # Set camera properties for better performance
        cap.set(cv2.CAP_PROP_FRAME_WIDTH, 640) # 640
        cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 480) # 480
        cap.set(cv2.CAP_PROP_FPS, 60)
        
        print("Camera initialized successfully!")
        print("Press 'q' to quit, 's' to save current frame, 'p' to toggle processing")
        
        processing_enabled = True
        
        try:
            while True:
                ret, frame = cap.read()
                if not ret:
                    print("Error: Cannot read frame from camera")
                    break
                
                self.frame_count += 1
                
                # Skip frames for performance if needed
                if processing_enabled and (self.frame_count % (self.skip_frames + 1) == 0):
                    try:
                        processed_frame, person_count, proc_time = self.process_frame(frame)
                        display_frame = processed_frame
                        
                        # Add processing time info
                        cv2.putText(display_frame, f'Proc time: {proc_time:.3f}s', 
                                  (10, 110), cv2.FONT_HERSHEY_SIMPLEX, 0.6, (255, 0, 0), 2)
                        
                        # Add detection info
                        self.draw_detection_info(display_frame, person_count)
                        
                    except Exception as e:
                        print(f"Processing error: {e}")
                        display_frame = frame
                        cv2.putText(display_frame, 'Processing Error', (10, 110), 
                                  cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255), 2)
                else:
                    display_frame = frame
                    if not processing_enabled:
                        cv2.putText(display_frame, 'Processing Paused (Press P)', (10, 110), 
                                  cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 100, 255), 2)
                
                # Update and display FPS
                self.update_fps()
                self.draw_fps(display_frame, self.current_fps)
                
                # Display the frame
                cv2.imshow('Real-time Pose Detection', display_frame)
                #cv2.moveWindow('Real-time Pose Detection', 100, 100)
                
                # Handle key presses
                key = cv2.waitKey(1) & 0xFF
                if key == ord('q'):
                    print("Quitting...")
                    break
                elif key == ord('s'):
                    filename = f'capture_{int(time.time())}.jpg'
                    cv2.imwrite(filename, display_frame)
                    print(f"Frame saved as {filename}")
                elif key == ord('p'):
                    processing_enabled = not processing_enabled
                    status = "enabled" if processing_enabled else "disabled"
                    print(f"Processing {status}")
                elif key == ord('f'):
                    # Toggle frame skipping
                    self.skip_frames = 0 if self.skip_frames > 0 else 2
                    print(f"Frame skipping: {'disabled' if self.skip_frames == 0 else 'enabled'}")
                
        except KeyboardInterrupt:
            print("Interrupted by user")
        
        finally:
            # Clean up
            cap.release()
            cv2.destroyAllWindows()
            print("Camera released and windows closed")

def main():
    """Main function"""
    try:
        app = RealtimePoseDetection()
        app.run(camera_id=0)  # Use /dev/video0
    except Exception as e:
        print(f"Application error: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    main()