import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class BleService {
  // 單例
  static final BleService instance = BleService._internal();
  BleService._internal();

  BluetoothDevice? _connectedDevice;
  BluetoothCharacteristic? _targetCharacteristic;

  final String deviceMacAddress = "20:BA:36:5C:DE:28";
  final String serviceUuid = "12345678-1234-5678-1234-56789abcdef0";
  final String charUuid    = "12345678-1234-5678-1234-56789abcdef1";

  // 連線
  Future<void> connectByMac() async {
    if (!Platform.isAndroid) {
      debugPrint("⚠️ iOS 沒有 MAC 概念");
      return;
    }

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    FlutterBluePlus.scanResults.listen((results) async {
      for (var r in results) {
        if (r.device.remoteId.str.toUpperCase() == deviceMacAddress.toUpperCase()) {
          debugPrint("✅ 找到裝置，開始連線...");
          await FlutterBluePlus.stopScan();
          _connectedDevice = r.device;
          await _connectedDevice!.connect();

          // 探索 service/characteristic
          List<BluetoothService> services = await _connectedDevice!.discoverServices();
          for (var s in services) {
            if (s.uuid.toString().toLowerCase() == serviceUuid.toLowerCase()) {
              for (var c in s.characteristics) {
                if (c.uuid.toString().toLowerCase() == charUuid.toLowerCase()) {
                  _targetCharacteristic = c;
                  debugPrint("🎯 已鎖定 characteristic");
                  return;
                }
              }
            }
          }
        }
      }
    });
  }
  // 斷線
  Future<void> disconnect() async {
    if (_connectedDevice != null) {
      try {
        await _connectedDevice!.disconnect();
        debugPrint("🔌 已斷線");
      } catch (e) {
        debugPrint("❌ 斷線失敗: $e");
      } finally {
        _connectedDevice = null;
        _targetCharacteristic = null;
      }
    } else {
      debugPrint("⚠️ 沒有裝置可斷線");
    }
  }

  // 傳送字串
  Future<void> sendString(String s) async {
    if (_targetCharacteristic == null) {
      debugPrint("❌ 尚未連線到 characteristic");
      return;
    }
    await _targetCharacteristic!.write(s.codeUnits, withoutResponse: false);
    debugPrint("📤 已送出: $s");
  }

  Future<void> sendOn() async => await sendString("ON");
  Future<void> sendOff() async => await sendString("OFF");

}

  