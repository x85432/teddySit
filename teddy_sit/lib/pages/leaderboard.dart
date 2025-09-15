import 'package:flutter/material.dart';
import '../widgets/home.dart';
import '../widgets/leaderboard_wid.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  final List<Map<String, dynamic>> leaderboardData = const [
    {'rank': 1, 'name': 'Pineapple', 'score': 100, 'type': 1},
    {'rank': 2, 'name': 'Banana', 'score': 90, 'type': 0},
    {'rank': 3, 'name': 'Apple', 'score': 80, 'type': 0},
    {'rank': 4, 'name': 'Player4', 'score': 70},
    {'rank': 5, 'name': 'Player5', 'score': 60},
    {'rank': 6, 'name': 'Player6', 'score': 50},
    {'rank': 7, 'name': 'Player7', 'score': 40},
    {'rank': 8, 'name': 'Player8', 'score': 30},
    {'rank': 9, 'name': 'Player9', 'score': 20},
    {'rank': 10, 'name': 'Player10', 'score': 10},
    
  ];

  @override
  Widget build(BuildContext context) {
    final topThree = leaderboardData.take(3).toList();
    final others = leaderboardData.skip(3).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                Navigator.pop(context);
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
                
              },
              child: Image(image: AssetImage('assets/Account.png'), width: 45, height: 45),
            )
          ),
          const SizedBox(width: 18),
        ],
      ),
      body: 
        Column(
          children: [
            const SizedBox(height: 30),
            Padding(padding: const EdgeInsets.only(left: 14),
              child:
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 59),
                      child: Rank3(rank: topThree[1]['rank'], playerName: topThree[1]['name'], score: topThree[1]['score'], type: topThree[1]['type']),
                    ),
                    Rank3(rank: topThree[0]['rank'], playerName: topThree[0]['name'], score: topThree[0]['score'], type: topThree[0]['type']),
                    Padding(
                      padding:const EdgeInsets.only(top: 59),
                      child: Rank3(rank: topThree[2]['rank'], playerName: topThree[2]['name'], score: topThree[2]['score'], type: topThree[2]['type']),
                    )
                    
                  ],
                ),
                
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    left: 20,
                    child: 
                      Opacity(
                        opacity: 0.24,
                        child: Container(
                          width: 370,
                          height: 445,
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.0, -1.0),
                              end: Alignment(0, 1),
                              colors: [Color(0xFFE7EAFF), Color(0xFF314AEF)],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                  ),
                  
                  SizedBox(
                    height: 445, 
                    child: SingleChildScrollView(
                      child: Column(
                        children: others.map((data) => Column(
                          children: [
                            Rank(
                              rank: data['rank'],
                              playerName: data['name'],
                              score: data['score'],
                              imagePath: data['imagePath'],
                            ),
                             if (data['rank'] % 8 != 0) 
                              const Divider(
                                color: Color.fromARGB(123, 255, 255, 255),
                                thickness: 2,
                                height: 1,
                                indent: 35,
                                endIndent: 40,
                              ),
                          ],
                        )).toList(),
                      ),
                    ),
                  )

                ],
              ),
            )


            
            
            
          
          ],
        ),
        
    );
  }
}