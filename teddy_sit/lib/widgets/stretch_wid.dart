import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

double scale = 2340/2400;

class DropdownButtonExample extends StatefulWidget {
  final double width;
  final double height;
  final List<String> options; // ✅ 從外部傳入選單
  final ValueChanged<String> onChanged;

  const DropdownButtonExample({
    super.key,
    this.width = 150*2340/2400,
    this.height = 41*2340/2400,
    required this.options,
    required this.onChanged,
  });

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    if (widget.options.isNotEmpty) {
      dropdownValue = widget.options.first;
    }
  }

  @override
  void didUpdateWidget(DropdownButtonExample oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果舊的選項不存在於新選項中，重置選中值
    if (dropdownValue == null || !widget.options.contains(dropdownValue)) {
      dropdownValue = widget.options.isNotEmpty ? widget.options.first : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: EdgeInsets.symmetric(horizontal: 12*scale),
      decoration: BoxDecoration(
        color: const Color(0x48D9D9D9),
        borderRadius: BorderRadius.circular(18),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: const Color.fromARGB(255, 67, 78, 99),
          borderRadius: BorderRadius.circular(18),
          value: dropdownValue,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFFCDCCD3)),
          elevation: 8,
          style: GoogleFonts.inknutAntiqua(
            color: const Color(0xFFCDCCD3),
            fontSize: 14*scale,
          ),
          onChanged: (String? value) {
            if (value == null) return;
            setState(() {
              dropdownValue = value;
            });
            widget.onChanged(value); // 通知父層
          },
          items: widget.options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Center(child: Text(value)),
            );
          }).toList(),
        ),
      ),
    );
  }
}



// Video
class VideoCard extends StatefulWidget {
  final String videoUrl;
  const VideoCard({super.key, required this.videoUrl});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  String? _currentUrl;

  @override
  void initState() {
    super.initState();
    _currentUrl = widget.videoUrl;
    _initializeController(_currentUrl!);
  }

  @override
  void didUpdateWidget(VideoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.videoUrl != oldWidget.videoUrl) {
      _currentUrl = widget.videoUrl;
      _controller.dispose();
      _initializeController(_currentUrl!);
    }
  }

  void _initializeController(String url) {
    _controller = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(false);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            width: 316*scale*0.9,
            height: 510*scale*0.9,
            color: Colors.black,
            child: _controller.value.isInitialized
                ? VideoPlayer(_controller)
                : const Center(child: CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }
}

