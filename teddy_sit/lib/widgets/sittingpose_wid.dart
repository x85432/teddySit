import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewExample extends StatefulWidget {
  
  final List<ImageProvider> images;
  final double width;
  final double height;

  const PageViewExample({
    super.key,
    required this.images,
    this.width = 350,
    this.height = 210,
  });

  @override
  State<PageViewExample> createState() => _PageViewExampleState();
}

class _PageViewExampleState extends State<PageViewExample> {
  late PageController _pageViewController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // --- PageView ---
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: PageView.builder(
              controller: _pageViewController,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Image(
                  image: widget.images[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),

        // --- Page Indicator ---
        Positioned(
          bottom: 8,
          child: SmoothPageIndicator(
            controller: _pageViewController,
            count: widget.images.length,
            effect: ExpandingDotsEffect(
              dotHeight: 12,
              dotWidth: 12,
              spacing: 8,
              activeDotColor: Colors.white,
              dotColor: Colors.grey.shade400,
            ),
          ),
        ),
      ],
    );
  }
}

class Correctsittingposture extends StatelessWidget {
  const Correctsittingposture({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 170,
          height: 212,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 170,
                  height: 212,
                  decoration: ShapeDecoration(
                    color: Color(0xFF7780BA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 87,
                child: Container(
                  width: 101,
                  height: 101,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/Correct.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 82,
                child: Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/CorrectSitting.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 11,
                top: 25,
                child: SizedBox(
                  width: 155,
                  height: 75,
                  child: Text(
                    'Correct Sitting Posture to Follow',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inknutAntiqua(
                      color: Colors.white,
                      fontSize: 15,
                      height: 20/15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Wrongsittingposture extends StatelessWidget {
  const Wrongsittingposture({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 170,
          height: 212,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 170,
                  height: 212,
                  decoration: ShapeDecoration(
                    color: Color(0xFF7780BA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 38,
                top: 93,
                child: Container(
                  width: 95,
                  height: 95,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/Wrong1.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 38,
                top: 93,
                child: Container(
                  width: 95,
                  height: 95,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/Wrong2.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33,
                top: 82,
                child: Container(
                  width: 107,
                  height: 107,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/WrongSitting.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 15,
                child: SizedBox(
                  width: 140,
                  height: 75,
                  child: Text(
                    'Wrong Sitting Patterns You Should Avoid',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inknutAntiqua(
                      color: Colors.white,
                      fontSize: 14,
                      height: 20/14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}