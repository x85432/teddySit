import 'package:flutter/material.dart';
import 'widgets/home.dart';
import 'pages/leaderboard.dart';

import 'package:firebase_core/firebase_core.dart'; // 導入 Firebase 核心套件
import 'package:cloud_functions/cloud_functions.dart'; // 導入 Cloud Functions 套件
import 'firebase_options.dart';

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
  // Cloud functions instance
  final FirebaseFunctions functions = FirebaseFunctions.instance;

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







