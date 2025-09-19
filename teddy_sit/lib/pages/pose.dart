import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home.dart';
import '../widgets/sittingpose_wid.dart';

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
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Image(
                image: AssetImage('assets/Home.png'),
                width: 35,
                height: 35,
              ),
            ),
          ),
          const SizedBox(width: 18),
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: InkWell(
              onTap: () {},
              child: const Image(
                image: AssetImage('assets/Account.png'),
                width: 45,
                height: 45,
              ),
            ),
          ),
          const SizedBox(width: 18),
        ],
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 30),
              child: Row(
                children: [
                  const Image(image: AssetImage('assets/Arrow.png')),
                  Text(
                    'Back',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inknutAntiqua(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 5),
            child: SizedBox(
              height: 640,
              width: 350,
              child: PageViewExample(
                width: 350,
                height: 640,
                images: images, // ← 直接用傳進來的
              ),
            ),
          ),
        ],
      ),
    );
  }
}
