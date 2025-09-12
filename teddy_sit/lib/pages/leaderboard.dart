import 'package:flutter/material.dart';
import '../widgets/home.dart';
import '../widgets//rank.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Rank(rank: 1, playerName: "Player 1", score: 100, imagePath: 'assets/Account.png'),
          Rank(rank: 2, playerName: "Player 2", score: 90),
          Rank(rank: 3, playerName: "Player 3", score: 80),
          Rank(rank: 4, playerName: "Player 4", score: 70),
          Rank(rank: 5, playerName: "Player 5", score: 60),
        ],
      ),
    );
  }
}