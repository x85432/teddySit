import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fl_chart/fl_chart.dart';

class ProfileService {

  // 獲取當前用戶資料
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        return userDoc.data();
      }

      return null;
    } catch (e) {
      debugPrint('獲取用戶資料錯誤: $e');
      return null;
    }
  }

  // 更新用戶資料
  Future<bool> updateUserProfile({
    String? name,
    String? dateOfBirth,
    String? height,
    String? weight,
  }) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;

      Map<String, dynamic> updateData = {};

      if (name != null) updateData['name'] = name;
      if (dateOfBirth != null) updateData['dateOfBirth'] = dateOfBirth;
      if (height != null) updateData['height'] = height;
      if (weight != null) updateData['weight'] = weight;

      if (updateData.isNotEmpty) {
        updateData['lastUpdatedAt'] = FieldValue.serverTimestamp();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update(updateData);

        Fluttertoast.showToast(
          msg: "個人資料已更新！",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 14.0,
        );

        return true;
      }

      return false;
    } catch (e) {
      debugPrint('更新用戶資料錯誤: $e');

      Fluttertoast.showToast(
        msg: "更新失敗，請稍後再試",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );

      return false;
    }
  }

  // 格式化日期顯示
  String formatDateForDisplay(String? date) {
    if (date == null || date.isEmpty) return '未設定';
    return date;
  }

  // 格式化身高顯示
  String formatHeightForDisplay(String? height) {
    if (height == null || height.isEmpty) return '未設定';
    return height.endsWith('cm') ? height : '${height}cm';
  }

  // 格式化體重顯示
  String formatWeightForDisplay(String? weight) {
    if (weight == null || weight.isEmpty) return '未設定';
    return weight.endsWith('kg') ? weight : '${weight}kg';
  }
}