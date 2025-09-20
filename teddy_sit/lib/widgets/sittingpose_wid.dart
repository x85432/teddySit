import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

double scale = 2340/2400;
class PageViewExample extends StatefulWidget {
  
  final List<ImageProvider> images;
  final double width;
  final double height;

  const PageViewExample({
    super.key,
    required this.images,
    this.width = 350*2340/2400,
    this.height = 210*2340/2400,
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
          bottom: 8*scale,
          child: SmoothPageIndicator(
            controller: _pageViewController,
            count: widget.images.length,
            effect: ExpandingDotsEffect(
              dotHeight: 12*scale,
              dotWidth: 12*scale,
              spacing: 8*scale,
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
          width: 170*scale,
          height: 212*scale,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 170*scale,
                  height: 212*scale,
                  decoration: ShapeDecoration(
                    color: Color(0xFF7780BA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33*scale,
                top: 87*scale,
                child: Container(
                  width: 101*scale,
                  height: 101*scale,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/Correct.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33*scale,
                top: 82*scale,
                child: Container(
                  width: 112*scale,
                  height: 112*scale,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/CorrectSitting.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 11*scale,
                top: 25*scale,
                child: SizedBox(
                  width: 155*scale,
                  height: 75*scale,
                  child: Text(
                    'Correct Sitting Posture Tips',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inknutAntiqua(
                      color: Colors.white,
                      fontSize: 15*scale,
                      height: 20/15*scale,
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
          width: 170*scale,
          height: 212*scale,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 170*scale,
                  height: 212*scale,
                  decoration: ShapeDecoration(
                    color: Color(0xFF7780BA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 38*scale,
                top: 93*scale,
                child: Container(
                  width: 95*scale,
                  height: 95*scale,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/Wrong1.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 38*scale,
                top: 93*scale,
                child: Container(
                  width: 95*scale,
                  height: 95*scale,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/Wrong2.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 33*scale,
                top: 82*scale,
                child: Container(
                  width: 107*scale,
                  height: 107*scale,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/WrongSitting.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 15*scale,
                top: 15*scale,
                child: SizedBox(
                  width: 140*scale,
                  height: 75*scale,
                  child: Text(
                    'Common Mistakes to Avoid',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inknutAntiqua(
                      color: Colors.white,
                      fontSize: 14*scale,
                      height: 20/14*scale,
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