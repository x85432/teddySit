import 'package:flutter/material.dart';
import 'widgets/home.dart';
import 'pages/leaderboard.dart';

import 'package:firebase_core/firebase_core.dart'; // 導入 Firebase 核心套件
import 'firebase_options.dart';
import 'services/cloud_function_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( // 初始化 Firebase
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeddySit',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF070C24),
        appBarTheme: AppBarTheme(
          backgroundColor:  Color(0xFF070C24),
          foregroundColor: Color(0xFFE8DEF8),   
        ),
      ),
      home: const MyHomePage(title: 'Teddy\nSit'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // 創建 CloudFunctionService 的實例
  final CloudFunctionService _cloudFunctionService = CloudFunctionService();

  /// 通用方法：調用指定的 Cloud Function 並顯示結果 SnackBar
  ///
  /// [functionName]: 要調用的 Cloud Function 的名稱。
  /// [params]: 傳遞給 Cloud Function 的參數。
  /// [requireLimitedUseAppCheckTokens]: 是否需要有限用途 App Check 權杖。
  Future<void> _callCloudFunctionAndShowResult({
    required String functionName,
    Map<String, dynamic>? params,
    bool requireLimitedUseAppCheckTokens = false,
  }) async {
    debugPrint("MyHomePage: Calling Cloud Function '$functionName' from UI event.");

    final CloudFunctionCallResult callResult =
        await _cloudFunctionService.callCallableFunction(
      functionName: functionName,
      params: params,
      requireLimitedUseAppCheckTokens: requireLimitedUseAppCheckTokens,
    );

    if (!mounted) {
      debugPrint("MyHomePage: Widget not mounted, cannot show SnackBar.");
      return;
    }

    String snackBarMessage;
    Color snackBarColor;

    switch (callResult.type) {
      case CloudFunctionResultType.success:
        snackBarMessage = '${callResult.message} 返回數據: ${callResult.data}';
        snackBarColor = Colors.green;
        break;
      case CloudFunctionResultType.firebaseError:
        snackBarMessage = '${callResult.message}';
        snackBarColor = Colors.orange;
        break;
      case CloudFunctionResultType.unexpectedError:
        snackBarMessage = '${callResult.message}';
        snackBarColor = Colors.red;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackBarMessage),
        backgroundColor: snackBarColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.only(top: 11, left: 12),
          child: const Teddysit(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 28), 
            child: InkWell(
              onTap: () {
                // Navigate to settings page
              },
              child: Image(image: AssetImage('assets/Home.png'), width: 35, height: 35),
            ),
          ),
          const SizedBox(width: 18),
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: InkWell(
              onTap: () {
                // Navigate to profile page
              },
              child: Image(image: AssetImage('assets/Account.png'), width: 45, height: 45),
            )
          ),
          const SizedBox(width: 18),
        ],
      ),
      
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: StretchCard(
                    onTap: () {
                      debugPrint("Stretch Recommendations card clicked!");
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  child: CorrectSittingCard(
                    onTap: () {
                      debugPrint("Correct Sitting Poses card clicked!");
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: AnalyticsCard(
                    onTap: () {
                      debugPrint("Analytics card clicked!");
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: LeaderboardCard(
                    onTap: () {
                      debugPrint("Leaderboard card clicked!");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LeaderboardPage()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  child: Donotdisturb(
                    onTap: () {
                      debugPrint("Do Not Disturb card clicked!");
                      _callCloudFunctionAndShowResult(
                        functionName: 'do_not_disturb', // 假設有個函式叫 updateDoNotDisturbStatus
                        // params: {'status': true, 'duration': '30min'},
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const ElapsedTime(),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                InkWell(
                  onTap: () {
                    debugPrint("Start button clicked!");
                  },
                  child: Image(image: AssetImage('assets/Start.png'), width: 52, height: 52),
                ),
                SizedBox(width: 39),
                InkWell(
                  onTap: null,
                  child: Image(image: AssetImage('assets/Pause.png'), width: 52, height: 52),
                ),
                SizedBox(width: 39),
                InkWell(
                  onTap: null,
                  child: Image(image: AssetImage('assets/Stop.png'), width: 52, height: 52),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}







