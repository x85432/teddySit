import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home.dart';
import '../widgets/sittingpose_wid.dart';

double scale = 2340/2400;

class PosePage extends StatelessWidget {
  final List<ImageProvider> images; // ← 從外面傳進來

  const PosePage({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
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
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Image(
                image: AssetImage('assets/Home.png'),
                width: 35*scale,
                height: 35*scale,
              ),
            ),
          ),
          SizedBox(width: 18*scale),
          Padding(
            padding: EdgeInsets.only(top: 28*scale),
            child: InkWell(
              onTap: () {},
              child: Image(
                image: AssetImage('assets/Account.png'),
                width: 45*scale,
                height: 45*scale,
              ),
            ),
          ),
          SizedBox(width: 18*scale),
        ],
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 20*scale, left: 30*scale),
              child: Row(
                children: [
                  const Image(image: AssetImage('assets/Arrow.png')),
                  Text(
                    'Back',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inknutAntiqua(
                      fontSize: 16*scale,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15*scale, left: 5*scale),
            child: SizedBox(
              height: 640*scale,
              width: 350*scale,
              child: PageViewExample(
                width: 350*scale,
                height: 640*scale,
                images: images, // ← 直接用傳進來的
              ),
            ),
          ),
        ],
      ),
    );
  }
}
