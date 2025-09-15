import 'package:flutter/material.dart';
import 'widgets/home.dart';
import 'pages/leaderboard.dart';
import 'pages/stretch.dart';
import 'pages/analytic.dart';

void main() {
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







