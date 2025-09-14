// lib/services/cloud_function_service.dart
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

// 定義 Cloud Function 結果的類型
enum CloudFunctionResultType {
  success,         // 成功
  firebaseError,   // Firebase Functions 錯誤
  unexpectedError, // 其他意外錯誤
}

// 用來封裝 Cloud Function 調用結果的類別
class CloudFunctionCallResult {
  final CloudFunctionResultType type; // 結果類型
  final String message;               // 顯示給用戶的訊息
  final dynamic data;                 // 成功時返回的數據，或錯誤時的詳細資訊

  CloudFunctionCallResult({
    required this.type,
    required this.message,
    this.data,
  });
}

class CloudFunctionService {
  final FirebaseFunctions _functions;

  CloudFunctionService({FirebaseFunctions? functions})
      : _functions = functions ?? FirebaseFunctions.instance;

  /// 通用方法：調用任何 on_call 類型的 Cloud Function
  ///
  /// [functionName]: 要調用的 Cloud Function 的名稱。
  /// [params]: 傳遞給 Cloud Function 的參數，必須是 JSON 兼容的 Map。
  /// [requireLimitedUseAppCheckTokens]: 如果伺服器端的 on_call 函式開啟了
  ///   App Check 的重播攻擊防護 (consumeAppCheckToken: true)，
  ///   則此參數必須設定為 true。
  ///
  /// 返回一個 CloudFunctionCallResult 物件，由 UI 層處理其結果。
  Future<CloudFunctionCallResult> callCallableFunction({
    required String functionName,
    Map<String, dynamic>? params,
    bool requireLimitedUseAppCheckTokens = false,
  }) async {
    debugPrint("CloudFunctionService: Calling Cloud Function '$functionName' with params: $params");
    try {
      HttpsCallable callable;

      if (requireLimitedUseAppCheckTokens) {
        debugPrint("CloudFunctionService: Requesting limited-use App Check token for replay protection.");
        callable = _functions.httpsCallable(
          functionName,
          // options: HttpsCallableOptions(
          //   requireLimitedUseAppCheckTokens: true,
          // ),
        );
      } else {
        callable = _functions.httpsCallable(functionName);
      }

      final HttpsCallableResult result = await callable.call(params);

      debugPrint('CloudFunctionService: "$functionName" result: ${result.data}');
      return CloudFunctionCallResult(
        type: CloudFunctionResultType.success,
        message: 'Cloud Function "$functionName" 成功！',
        data: result.data,
      );
    } on FirebaseFunctionsException catch (e) {
      debugPrint('CloudFunctionService: "$functionName" failed: ${e.code} - ${e.message}');
      return CloudFunctionCallResult(
        type: CloudFunctionResultType.firebaseError,
        message: 'Cloud Function "$functionName" 錯誤 (${e.code}): ${e.message}',
        data: e.code,
      );
    } catch (e) {
      debugPrint('CloudFunctionService: An unexpected error occurred for "$functionName": $e');
      return CloudFunctionCallResult(
        type: CloudFunctionResultType.unexpectedError,
        message: 'Cloud Function "$functionName" 發生了未預期的錯誤: $e',
        data: e.toString(),
      );
    }
  }


  // 這裡可以新增其他 functions
}
