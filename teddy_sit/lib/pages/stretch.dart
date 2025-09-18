import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home.dart';
import '../widgets/stretch_wid.dart';

class StretchPage extends StatelessWidget {
  const StretchPage({super.key});

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
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(width: 248),
                //DropdownButtonExample()
              ],
            ),
            const SizedBox(height: 28),
            Stack(
            children: [
              // 影片
              SizedBox(
                width: 356,
                height: 639,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: const Color(0xFF3A3F55),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 69, left: 19),
                child: VideoCard(
                  videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16),
                child: Icon(  
                  Icons.favorite_border, 
                  color: Colors.white, 
                  size: 48,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 593, left: 16),
                child: Text(  
                  'Stretching Exercise 1', 
                  style: GoogleFonts.inknutAntiqua(
                    color: Color(0xFFCDCCD3), 
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
            
            
            
          ],
        ),
      ),
    );
  }
}