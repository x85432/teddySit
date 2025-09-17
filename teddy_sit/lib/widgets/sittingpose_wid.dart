import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageViewExample extends StatefulWidget {
  /// 外部傳入每頁圖片
  final List<ImageProvider> images;

  /// 外部控制寬高
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
