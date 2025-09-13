import 'package:flutter/material.dart';
import 'widgets/home.dart';
import 'pages/leaderboard.dart';

// for cloud functions and firestore for Firebases
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'firebase_options.dart';

// Firebase App check
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart'; // for kDebug

// main function must be an async function
void main() async {
  // cloud functions and database necessary
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // // 根據 kDebugMode 判斷是否為開發模式
  // if (kDebugMode) {
  //   // 在 Debug 模式下使用 Debug Provider
  //   await FirebaseAppCheck.instance.activate(
  //     androidProvider: AndroidProvider.debug,
  //     appleProvider: AppleProvider.debug,
  //   );
  // } else {
  //   // 在 Release 模式下使用正式的提供程式
  //   await FirebaseAppCheck.instance.activate(
  //     androidProvider: AndroidProvider.playIntegrity, // 或其他正式提供程式
  //     appleProvider: AppleProvider.deviceCheck,       // 或其他正式提供程式
  //   );
  // }

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
  // A variable to store the message from the cloud function
  String _cloudFunctionMessage = '';

  // Asynchronous function to call the Cloud Function
  Future<void> _callDoNotDisturbFunction() async {
    try {
      // Get an instance of the Firebase Functions
      final functions = FirebaseFunctions.instance;
      // Get the callable function by its name
      final HttpsCallable callable = functions.httpsCallable('do_not_disturb');
      // Call the function
      final HttpsCallableResult result = await callable.call();

      // Check if the result has data
      if (result.data != null && result.data is Map && result.data['message'] != null) {
        // Update the state with the message from the function
        setState(() {
          _cloudFunctionMessage = result.data['message'] as String;
        });
        // Log the message for debugging
        debugPrint('Cloud Function Response: $_cloudFunctionMessage');
      }
    } catch (e) {
      // Handle any errors that occur during the function call
      debugPrint('Error calling Cloud Function: $e');
      setState(() {
        _cloudFunctionMessage = 'Error: $e';
      });
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
                      _callDoNotDisturbFunction();
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







