# on_off_gatt_server.py
from bluezero import peripheral

upload_enabled = False

def write_handler(value, options=None):
    global upload_enabled
    msg = value.decode().strip().upper()
    if msg == "ON":
        upload_enabled = True
        print("Upload function enabled (flag = True)")
    elif msg == "OFF":
        upload_enabled = False
        print("Upload function disabled (flag = False)")
    else:
        print("⚠️ Unknown command:", msg)

def start_ble_server():
    SERVICE_UUID = '12345678-1234-5678-1234-56789abcdef0'
    CHAR_UUID = '12345678-1234-5678-1234-56789abcdef1'

    adapter_addr = 'MAC_ADDRESS'  # Your hci0 MAC
    local_name = 'IMX93'

    periph = peripheral.Peripheral(adapter_addr, local_name)
    periph.add_service(srv_id=1, uuid=SERVICE_UUID, primary=True)
    periph.add_characteristic(
        srv_id=1,
        chr_id=1,
        uuid=CHAR_UUID,
        value=b'ON',
        notifying=False,
        flags=['read', 'write'],
        write_callback=write_handler
    )
    print("📶 GATT server started...")
    periph.publish()

if __name__ == "__main__":
    start_ble_server()