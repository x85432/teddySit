import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../pages/signup.dart';
import '../pages/login.dart';

class AuthService {

  // 創建用戶 Firestore document
  Future<void> _createUserDocument(User user, {String? name}) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);

      // 檢查用戶 document 是否已存在
      final docSnapshot = await userDoc.get();

      if (!docSnapshot.exists) {
        // 創建新的用戶 document
        await userDoc.set({
          'uid': user.uid,
          'name': name ?? '',
          'email': user.email,
          'dateOfBirth': null,
          'height': null,
          'weight': null,
          'createdAt': FieldValue.serverTimestamp(),
          'lastLoginAt': FieldValue.serverTimestamp(),
        });

        debugPrint('用戶 document 已創建: ${user.email}');
      } else {
        // 更新最後登入時間
        await userDoc.update({
          'lastLoginAt': FieldValue.serverTimestamp(),
        });

        debugPrint('用戶 document 已更新: ${user.email}');
      }
    } catch (e) {
      debugPrint('創建/更新用戶 document 錯誤: $e');
    }
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required BuildContext context
  }) async {
    
    try {

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      // 創建用戶的 Firestore document
      if (userCredential.user != null) {
        await _createUserDocument(userCredential.user!, name: name);
      }

      Fluttertoast.showToast(
        msg: "註冊成功！",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14.0,
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pop(context);
      
    } on FirebaseAuthException catch(e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
       Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
    catch(e){

    }

  }

  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    
    try {

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      // 更新用戶的 Firestore document
      if (userCredential.user != null) {
        await _createUserDocument(userCredential.user!);
      }

      Fluttertoast.showToast(
        msg: "登入成功！",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 14.0,
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.popUntil(context, (route) => route.isFirst);
      
    } on FirebaseAuthException catch(e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      }
       Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
    catch(e){

    }

  }

  Future<void> signout({
    required BuildContext context
  }) async {

    await FirebaseAuth.instance.signOut();

    Fluttertoast.showToast(
      msg: "已成功登出",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 14.0,
    );

    // AuthWrapper 會自動處理頁面切換，所以不需要手動導航
  }
}