import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import '../widgets/home.dart';
import '../widgets/sittingpose_wid.dart';
import 'pose.dart';

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
                Navigator.popUntil(context, ModalRoute.withName('/home'));
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
            padding: const EdgeInsets.only(top: 42, left: 6),
            child: SizedBox(
              height: 210,
              width: 350,
              child: PageViewExample(
                width: 350,
                height: 210,
                images: [
                  AssetImage('assets/A1.png'),
                  AssetImage('assets/A2.png'),
                  AssetImage('assets/A3.png'),
                  AssetImage('assets/A4.png'),
                  AssetImage('assets/A5.png'),
                ],
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 29, left: 30),
            child: Row(
              children: [
                InkWell(
                  child: Correctsittingposture(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PosePage(
                          images: const [
                            AssetImage('assets/B1_1.png'),
                            AssetImage('assets/B1_2.png'),
                            AssetImage('assets/B1_3.png'),
                            AssetImage('assets/B1_4.png'),
                            AssetImage('assets/B1_5.png'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 16),
                InkWell(
                  child: Wrongsittingposture(),
                 onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PosePage(
                          images: const [
                            AssetImage('assets/B2_1.png'),
                            AssetImage('assets/B2_2.png'),
                          ],
                        ),
                      ),
                    );
                  },
                )
                
              ],
            )
          ),
          
          //分數計算
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 6),
            child: SizedBox(
              height: 240,
              width: 350,
              child: PageViewExample(
                width: 350,
                height: 240,
                images: [
                  AssetImage('assets/B3_1.png'),
                  AssetImage('assets/B3_2.png'),
                  AssetImage('assets/B3_3.png'),
                  AssetImage('assets/B3_4.png'),
                  AssetImage('assets/B3_5.png'),
                  AssetImage('assets/B3_6.png'),
                ],
              )
            ),
          )
        ],
      )
      
    );
  }
  
}