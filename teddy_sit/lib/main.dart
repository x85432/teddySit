import 'package:flutter/material.dart';
import 'package:teddy_sit/pages/Userprofile.dart';
import 'widgets/home.dart';
import 'widgets/auth_wrapper.dart';
import 'pages/profile.dart';
import 'pages/leaderboard.dart';
import 'pages/stretch.dart';
import 'pages/analytic.dart';
import 'pages/sittingpose.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:firebase_core/firebase_core.dart'; // 導入 Firebase 核心套件
import 'firebase_options.dart';
// import 'services/cloud_function_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'services/sensor_data_manager.dart';

// Firebase App check
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart'; // for kDebug
import 'package:firebase_auth/firebase_auth.dart';

// Notifications
import 'notifications/permission_handler.dart';
import 'notifications/service.dart';

import 'package:fluttertoast/fluttertoast.dart';

// bluetooth
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'controller/ble_controller.dart';
import 'services/ble_service.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp( // 初始化 Firebase
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 初始化 SensorDataManager
  await SensorDataManager.initialize();

  // 根據 kDebugMode 判斷是否為開發模式
  if (kDebugMode) {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug,
    );

  } else {
    // 在 Release 模式下使用正式的提供程式
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity,
      appleProvider: AppleProvider.deviceCheck,
    );
  }

  // 每次啟動都自動登出
  await FirebaseAuth.instance.signOut();

  // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  // FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  
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
      initialRoute: '/home',
      routes: {
        '/home': (context) => const MyHomePage(title: 'Teddy\nSit'),
        '/profile': (context) => const ProfilePage(),
        '/userProfile': (context) => const UserProfilePage(),
        '/leaderboard': (context) => const LeaderboardPage(),
        '/stretch': (context) => const StretchPage(),
        '/analytic': (context) => const AnalyticPage(),
        '/sittingPose': (context) => const SittingPosePage(),
      },
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
  final NotificationPermissionHandler _permissionHandler =
      NotificationPermissionHandler(); // add this
  final GlobalKey _elapsedTimeKey = GlobalKey();
  
  final userEmail = FirebaseAuth.instance.currentUser?.email;
  
  bool _isTimerRunning = false;
  bool _shouldReset = false;
  final double scale = 2220/2400;

  var lastUpdate = "";

  Future<void> _requestPermissionsOnStartup() async { // add this
    bool permissionsGranted =
        await _permissionHandler.checkNotificationPermissions();

    if (!permissionsGranted) {
      await _permissionHandler.requestNotificationPermissions();
    }
  }

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
  initState() { // add this
    super.initState();
    _requestPermissionsOnStartup(); // add this
  }

  Future<Map<String, Map<String, dynamic> >?> getSensorDataByTimeRange({
    required String deviceId,
    required DateTime startTimeUtc,
    required DateTime endTimeUtc,
    String collectionName = "score",
  }) async {
    try {
      final functions = FirebaseFunctions.instance;
      final callable = functions.httpsCallable('get_sensor_data_by_time_range');

      final result = await callable.call({
        "device_id": deviceId,
        "collection_name": collectionName,
        "start_time": startTimeUtc.toUtc().toIso8601String(), // 一律轉成 UTC ISO8601
        "end_time": endTimeUtc.toUtc().toIso8601String(),
      });

      final data = Map<String, dynamic>.from(result.data);
      if (data["status"] == "success") {
        final sensorData = (data['data'] as List)
            .map((item) => Map<String, dynamic>.from(item))
            .toList();

        // 🔹 轉換成 Map<int, Map<String, dynamic>>
        final Map<String, Map<String, dynamic>> mappedData = {
          for (int i = 0; i < sensorData.length; i++) i.toString(): sensorData[i]
        };
        debugPrint("拿到 ${sensorData.length} 筆資料");
        return mappedData;
      } else {
        debugPrint("錯誤: ${data['message']}");
        return null;
      }
    } catch (e) {
      debugPrint("呼叫失敗: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100 * scale,
        title: Padding(
          padding: EdgeInsets.only(top: 11 * scale, left: 12 * scale),
          child: const Teddysit(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 28 * scale), 
            child: InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (_) => const BleController()),
                // );
                BleService.instance.connectByMac();
                Fluttertoast.showToast(
                  msg: "藍芽偵測啟動！",
                  toastLength: Toast.LENGTH_SHORT, // 或 Toast.LENGTH_LONG
                  gravity: ToastGravity.BOTTOM,    // TOP, CENTER, BOTTOM
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                //Navigator.popUntil(context, ModalRoute.withName('/home'));
                // Navigate to settings page
                //getSensorDataByTimeRange(deviceId: "redTest", startTime: "2025-09-20T00:00:00+08:00", endTime: "2025-09-21T00:00:00+08:00", collectionName: "scores");
              },
              child: Image(image: AssetImage('assets/bluetooth.png'), width: 35 * scale, height: 35 * scale),
            ),
          ),
          
                    SizedBox(width: 18 * scale),
          Padding(
            padding: EdgeInsets.only(top: 28 * scale),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthWrapper()),
                );
                debugPrint("Account button clicked!");
              },
              child: Image(image: AssetImage('assets/Account.png'), width: 45 * scale, height: 45 * scale),
            )
          ),
          SizedBox(width: 18 * scale),
        ],
      ),
      
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10 * scale),
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
                SizedBox(width: 10 * scale),
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
            SizedBox(height: 15 * scale),
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
            SizedBox(height: 15  * scale),
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
                SizedBox(width: 10 * scale),
                SizedBox(
                  child: Donotdisturb(),
                ),
              ],
            ),
            //SizedBox(height: 10 * scale),
            ElapsedTime(key: _elapsedTimeKey, isRunning: _isTimerRunning, shouldReset: _shouldReset),
            //SizedBox(height: 5 * scale),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                InkWell(
                  onTap: () async {
                    setState(() {
                      _isTimerRunning = true;
                      _shouldReset = false;
                      NotificationService().showBasicNotification( // add this
                        'Teddy Sit',
                        '計時開始',
                      );
                      
                    });
                    debugPrint("Start button clicked!");

                    // 傳送 ON
                    await BleService.instance.sendOn();

                  },
                  child: Image(image: AssetImage('assets/Start.png'), width: 52 * scale, height: 52 * scale),
                ),
                SizedBox(width: 39 * scale),
                InkWell(
                  onTap: () async {
                    setState(() {
                      _isTimerRunning = false;
                      _shouldReset = false;
                    });
                    debugPrint('Pause button clicked!');
                    await BleService.instance.sendOff();
                  },
                  child: Image(image: AssetImage('assets/Pause.png'), width: 52 * scale, height: 52 * scale),
                ),
                SizedBox(width: 39 * scale),
                InkWell(
                  onTap: () async {
                    final userEmail = FirebaseAuth.instance.currentUser?.email;
                    debugPrint("目前使用的信箱: $userEmail");
                    final navigator = Navigator.of(context);
                    setState(() {
                      _isTimerRunning = false;
                      _shouldReset = true;
                    });
                    debugPrint('Stop button clicked!');

                    // 取得時間段資料
                    final elapsedTimeState = _elapsedTimeKey.currentState;

                    if (elapsedTimeState != null) {
                      final session = (elapsedTimeState as dynamic).getCurrentSession();
                      final segments = session?.segments ?? []; // 這個session的所有segments
                      

                      // debugPrint("測試$segments.toString()");
                      //debugPrint("測試${segments.last.endTime.toString()}");
                      if (segments.isNotEmpty) {
                        final startDateTime = segments.first.startTime;
                        final lastSegmentEnd = segments.last.endTime ?? DateTime.now().toUtc();
                        debugPrint("測試${lastSegmentEnd.toString()}");
                        lastUpdate = lastSegmentEnd;  // 更新最後一次 Stop 的時間


                        if (startDateTime == null) {
                          debugPrint("⚠️ Start time 為空，無法查詢");
                          return;
                        }

                        final newData = [];
                        for (var aSeg in segments) {
                          final startUtc = aSeg.startTime;
                          final endUtc = aSeg.endTime;
                          final sensorData = await getSensorDataByTimeRange(
                            deviceId: "daniel",
                            startTimeUtc: startUtc,
                            endTimeUtc: endUtc,
                            collectionName: "scores",
                          );
                          sensorData?["startTime"] = {"Time": startUtc.toString()};
                          sensorData?["endTime"]   = {"Time":   endUtc.toString()};
                          newData.add(sensorData);
                        }

                        await SensorDataManager.initialize();
                        await SensorDataManager.addSensorData(
                          newData,
                          startDateTime.toUtc().toIso8601String()
                        );

                        // // 撈Session資料
                        // final startUtc = startDateTime.toUtc();
                        // final endUtc = DateTime.utc(
                        //   lastSegmentEnd.year,
                        //   lastSegmentEnd.month,
                        //   lastSegmentEnd.day,
                        //   lastSegmentEnd.hour,
                        //   lastSegmentEnd.minute,
                        //   lastSegmentEnd.second
                        // );

                        // debugPrint('  startTime(UTC): ${startUtc.toIso8601String()}');
                        // debugPrint('  endTime(UTC): ${endUtc.toIso8601String()}');
                                           
                        if (newData.isNotEmpty) {
                          debugPrint('✅ 撈到 ${newData.length} 筆感測器資料 (UTC)');
                          await BleService.instance.sendOff();
                          navigator.push(
                            MaterialPageRoute(builder: (context) => const StretchPage()),
                          );
                        } else {
                          debugPrint('⚠️ 沒有撈到資料 (UTC)');
                        }
                      }

                    } else {
                      debugPrint('無法取得 ElapsedTime 狀態');
                    }

                    // Reset the flag after a brief delay
                    Future.delayed(Duration(milliseconds: 100), () {
                      if (mounted) {
                        setState(() {
                          _shouldReset = false;
                        });
                      }
                    });

                    await BleService.instance.sendOff();

                    navigator.push(
                      MaterialPageRoute(builder: (context) => const StretchPage()),
                    );


                  },
                  child: Image(image: AssetImage('assets/Stop.png'), width: 52 * scale, height: 52 * scale),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}







