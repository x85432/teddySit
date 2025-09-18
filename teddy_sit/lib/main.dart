import 'package:flutter/material.dart';
import 'package:teddy_sit/pages/Userprofile.dart';
import 'widgets/home.dart';
import 'pages/profile.dart';
import 'pages/Userprofile.dart';
import 'pages/leaderboard.dart';
import 'pages/stretch.dart';
import 'pages/analytic.dart';
import 'pages/sittingpose.dart';


import 'package:firebase_core/firebase_core.dart'; // 導入 Firebase 核心套件
import 'firebase_options.dart';
// import 'services/cloud_function_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

// Firebase App check
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart'; // for kDebug

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp( // 初始化 Firebase
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 根據 kDebugMode 判斷是否為開發模式
  if (kDebugMode) {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug,
    );

    print('App Check initialized in Debug mode. Please check device logs (Logcat/Xcode Console) to confirm which Debug Token is being used.');

  } else {
    // 在 Release 模式下使用正式的提供程式
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity,
      appleProvider: AppleProvider.deviceCheck,
    );
  }

  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
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
        scaffoldBackgroundColor: Color(0xFF070C24),
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
    Future<void> callDoNotDisturb() async {
    try {
      // 獲取 Firebase Functions 實例
      FirebaseFunctions functions = FirebaseFunctions.instance;
      
      // 調用 'do_not_disturb' 函數
      HttpsCallable callable = functions.httpsCallable('do_not_disturb');
      debugPrint('🚀 正在調用 do_not_disturb 函數...');
      // 執行調用（可以傳入資料，這裡傳空的 Map）
      final result = await callable.call({});
      
      // 獲取回傳的資料
      final data = result.data;
      
      debugPrint('✅ 成功調用 Callable Function！');
      debugPrint('回應訊息: ${data['message']}');

      return data;
      
    } on FirebaseFunctionsException catch (error) {
      debugPrint('❌ Firebase Functions 錯誤:');
      debugPrint('Code: ${error.code}');
      debugPrint('Message: ${error.message}');
      debugPrint('Details: ${error.details}');
    } catch (error) {
      debugPrint('❌ 一般錯誤: $error');
    }
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserProfilePage()),
                );
                debugPrint("Account button clicked!");
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StretchPage()),
                      );
                      debugPrint("Stretch Recommendations card clicked!");
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  child: CorrectSittingCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SittingPosePage()),
                      );
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AnalyticPage()),
                      );
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
                  child: Donotdisturb(),
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
                  onTap: ()
                  {
                    debugPrint('Pause!33');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfilePage()),
                    );
                    callDoNotDisturb();
                  },
                  child: Image(image: AssetImage('assets/Pause.png'), width: 52, height: 52),
                ),
                SizedBox(width: 39),
                InkWell(
                  onTap: ()
                  {
                    debugPrint('Stop!33');
                  },
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







