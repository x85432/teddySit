import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import '../widgets/home.dart';
import '../widgets/sittingpose_wid.dart';
import 'pose.dart';

double scale = 2340/2400;

class SittingPosePage extends StatelessWidget{
  const SittingPosePage({super.key});

  @override
  Widget build(BuildContext context){
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
      body: Column(
        children: [
          //使用目的
          Padding(
            padding: EdgeInsets.only(top: 20*scale, left: 6*scale),
            child: SizedBox(
              height: 210*scale,
              width: 350*scale,
              child: PageViewExample(
                width: 350*scale,
                height: 210*scale,
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
            padding: EdgeInsets.only(top: 20*scale, left: 30*scale),
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
                SizedBox(width: 16*scale),
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
            padding: EdgeInsets.only(top: 20*scale, left: 6*scale),
            child: SizedBox(
              height: 220*scale,
              width: 350*scale,
              child: PageViewExample(
                width: 350*scale,
                height: 220*scale,
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