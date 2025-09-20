import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// 你的裝置資訊（請換成實際值）
final String deviceMacAddress = "20:BA:36:5C:DE:28"; // 注意大小寫不敏感 (Android only)
final String serviceUuid = "12345678-1234-5678-1234-56789abcdef0";
final String charUuid    = "12345678-1234-5678-1234-56789abcdef1";

class BleController extends StatefulWidget {
  const BleController({super.key});

  @override
  State<BleController> createState() => _BleControllerState();
}

class _BleControllerState extends State<BleController> {
  bool _isScanning = false;
  bool _isOn = false;
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  BluetoothDevice? _connectedDevice;
  BluetoothCharacteristic? _targetCharacteristic;

  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;
  StreamSubscription<List<ScanResult>>? _scanResultsSubscription;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  void _initBluetooth() async {
    if (await FlutterBluePlus.isSupported == false) {
      debugPrint("此裝置不支援藍牙");
      return;
    }

    _adapterStateSubscription = FlutterBluePlus.adapterState.listen((s) {
      setState(() => _adapterState = s);
    });

    if (Platform.isAndroid) {
      try {
        await FlutterBluePlus.turnOn();
      } catch (_) {}
    }

    FlutterBluePlus.adapterState
        .where((state) => state == BluetoothAdapterState.on)
        .first
        .then((_) => debugPrint("Bluetooth adapter is ON"));
  }

  /// 以 MAC 掃描並連線（Android only）
  Future<void> connectByMac() async {
    if (_adapterState != BluetoothAdapterState.on) {
      debugPrint("藍牙未開啟");
      return;
    }

    if (!Platform.isAndroid) {
      debugPrint("⚠️ iOS 沒有 MAC 概念，這方法僅適用於 Android");
    }

    setState(() => _isScanning = true);
    _targetCharacteristic = null;

    try {
      _scanResultsSubscription =
          FlutterBluePlus.scanResults.listen((List<ScanResult> results) async {
        for (final r in results) {
          final rid = r.device.remoteId.toString().toUpperCase();
          if (rid == deviceMacAddress.toUpperCase()) {
            debugPrint("找到目標裝置: $rid (rssi=${r.rssi})");
            await FlutterBluePlus.stopScan();
            await _scanResultsSubscription?.cancel();
            setState(() => _isScanning = false);
            await _connectToDevice(r.device);
            return;
          }
        }
      });

      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
    } catch (e) {
      debugPrint("connectByMac 錯誤: $e");
      await FlutterBluePlus.stopScan();
      await _scanResultsSubscription?.cancel();
      setState(() => _isScanning = false);
    }
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      if (_connectedDevice != null &&
          _connectedDevice!.remoteId == device.remoteId) {
        debugPrint("已經連接到: ${device.remoteId}");
        return;
      }

      await device.connect(autoConnect: false, timeout: const Duration(seconds: 15));
      setState(() => _connectedDevice = device);
      debugPrint('✅ 已連接: ${device.remoteId}');

      device.connectionState.listen((BluetoothConnectionState state) {
        debugPrint("connectionState: $state");
        if (state == BluetoothConnectionState.disconnected) {
          debugPrint("裝置已斷線");
          setState(() {
            _connectedDevice = null;
            _targetCharacteristic = null;
          });
        }
      });

      await _discoverAndCacheTarget(device);
    } catch (e) {
      debugPrint('連線錯誤: $e');
      try {
        await device.disconnect();
      } catch (_) {}
      setState(() {
        _connectedDevice = null;
        _targetCharacteristic = null;
      });
    }
  }

  Future<void> _discoverAndCacheTarget(BluetoothDevice device) async {
    try {
      List<BluetoothService> services = await device.discoverServices();
      debugPrint("discoverServices count: ${services.length}");

      // 找目標 service
      final matchingServices = services.where(
        (s) => s.uuid.toString().toLowerCase() == serviceUuid.toLowerCase(),
      );

      if (matchingServices.isEmpty) {
        debugPrint("❌ 找不到指定 service ($serviceUuid)");
        setState(() => _targetCharacteristic = null);
        return;
      }

      final targetService = matchingServices.first;

      // 找目標 characteristic
      final matchingChars = targetService.characteristics.where(
        (c) => c.uuid.toString().toLowerCase() == charUuid.toLowerCase(),
      );

      if (matchingChars.isEmpty) {
        debugPrint("❌ 找不到指定 characteristic ($charUuid)");
        setState(() => _targetCharacteristic = null);
        return;
      }

      final targetChar = matchingChars.first;

      setState(() => _targetCharacteristic = targetChar);
      debugPrint("🎯 已鎖定 characteristic: ${targetChar.uuid}");

      // 如果支援 notify
      if (targetChar.properties.notify || targetChar.properties.indicate) {
        try {
          await targetChar.setNotifyValue(true);
          targetChar.value.listen((data) {
            debugPrint("📩 notify: $data");
          });
        } catch (e) {
          debugPrint("notify 設定失敗: $e");
        }
      }
    } catch (e) {
      debugPrint("discoverAndCacheTarget 錯誤: $e");
      setState(() => _targetCharacteristic = null);
    }
  }


  Future<void> writeToBoard(List<int> bytes, {bool withResponse = true}) async {
    if (_targetCharacteristic == null) {
      debugPrint("沒有 target characteristic");
      return;
    }
    try {
      await _targetCharacteristic!.write(bytes, withoutResponse: !withResponse);
      debugPrint("✅ 寫入成功: $bytes");
    } catch (e) {
      debugPrint("寫入錯誤: $e");
    }
  }

  Future<void> writeStringAsUtf8(String s) async {
    await writeToBoard(s.codeUnits, withResponse: true);
  }

  Future<void> disconnect() async {
    if (_connectedDevice != null) {
      try {
        await _connectedDevice!.disconnect();
      } catch (e) {
        debugPrint("disconnect error: $e");
      }
      setState(() {
        _connectedDevice = null;
        _targetCharacteristic = null;
      });
    }
  }

  @override
  void dispose() {
    _adapterStateSubscription?.cancel();
    _scanResultsSubscription?.cancel();
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  Widget _buildControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: _isScanning ? null : connectByMac,
          child: Text(_isScanning ? '掃描中...' : '連線到 $deviceMacAddress'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _connectedDevice == null ? null : disconnect,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('手動斷線'),
        ),
        const SizedBox(height: 8),
         ElevatedButton(
          onPressed: _targetCharacteristic == null
              ? null
              : () async {
                  final value = _isOn ? "OFF" : "ON";
                  await writeStringAsUtf8(value);
                  setState(() {
                    _isOn = !_isOn;
                  });
                },
          child:  Text(_isOn ? '送出 OFF' : '送出 ON'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('藍芽裝置 (固定 MAC)')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildControls(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  Text('Adapter state: $_adapterState'),
                  const SizedBox(height: 8),
                  Text('Connected device: ${_connectedDevice?.remoteId.toString() ?? "--"}'),
                  const SizedBox(height: 8),
                  Text('Target characteristic: ${_targetCharacteristic?.uuid.toString() ?? "--"}'),
                  const SizedBox(height: 16),
                  const Text('Debug log 請看 console 輸出'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
