import 'package:flutter/material.dart';
import '../widgets/home.dart';
import '../widgets/leaderboard_wid.dart';

double scale = 2340/2400;

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
        toolbarHeight: 100*scale,
        title: Padding(
          padding: EdgeInsets.only(top: 11*scale, left: 12*scale),
          child: const Teddysit(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 28*scale), 
            child: InkWell(
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
              },
              child: Image(image: AssetImage('assets/Home.png'), width: 35*scale, height: 35*scale),
            ),
          ),
          SizedBox(width: 18*scale),
          Padding(
            padding: EdgeInsets.only(top: 28*scale),
            child: InkWell(
              onTap: () {
                
              },
              child: Image(image: AssetImage('assets/Account.png'), width: 45*scale, height: 45*scale),
            )
          ),
          SizedBox(width: 18*scale),
        ],
      ),
      body: 
        Column(
          children: [
            SizedBox(height: 30*scale),
            Padding(padding: EdgeInsets.only(left: 14*scale),
              child:
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 59*scale),
                      child: Rank3(rank: topThree[1]['rank'], playerName: topThree[1]['name'], score: topThree[1]['score'], type: topThree[1]['type']),
                    ),
                    Rank3(rank: topThree[0]['rank'], playerName: topThree[0]['name'], score: topThree[0]['score'], type: topThree[0]['type']),
                    Padding(
                      padding: EdgeInsets.only(top: 59*scale),
                      child: Rank3(rank: topThree[2]['rank'], playerName: topThree[2]['name'], score: topThree[2]['score'], type: topThree[2]['type']),
                    )
                    
                  ],
                ),
                
            ),
            SizedBox(height: 15*scale),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    left: 20*scale,
                    child: 
                      Opacity(
                        opacity: 0.24,
                        child: Container(
                          width: 370*scale,
                          height: 445*scale,
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
                    height: 445*scale, 
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
                               Divider(
                                color: Color.fromARGB(123, 255, 255, 255),
                                thickness: 2*scale,
                                height: 1*scale,
                                indent: 35*scale,
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