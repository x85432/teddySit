import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import '../widgets/home.dart';
import '../widgets/sittingpose_wid.dart';

class SittingPosePage extends StatelessWidget{
  const SittingPosePage({super.key});

  @override
  Widget build(BuildContext context){
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
      body: Column(
        children: [
          //使用目的
          Padding(
            padding: const EdgeInsets.only(top: 42, left: 30),
            child: SizedBox(
              height: 210,
              child: PageViewExample(
                width: 350,
                height: 210,
                images: [
                  AssetImage('assets/1.png'),
                  AssetImage('assets/2.png'),
                  AssetImage('assets/3.png'),
                ],
              )
            ),
          ),

          //分數計算
          Padding(
            padding: const EdgeInsets.only(top: 261, left: 30),
            child: SizedBox(
              height: 240,
              child: PageViewExample(
                width: 350,
                height: 240,
                images: [
                  AssetImage('assets/1.png'),
                  AssetImage('assets/2.png'),
                  AssetImage('assets/3.png'),
                ],
              )
            ),
          )
        ],
      )
      
    );
  }
  
}