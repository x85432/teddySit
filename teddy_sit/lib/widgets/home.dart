import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

// Logo
class Teddysit extends StatelessWidget {
  const Teddysit({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 275,
          height: 87,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: SizedBox(
                  width: 275,
                  height: 87,
                  child: Text(
                    'Teddy\nSit',
                    style: GoogleFonts.kirangHaerang(
                      color: const Color(0xFFE8E5ED),
                      fontSize: 38,
                      height: 40/38,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 47,
                top: 45,
                child: Container(
                  width: 27,
                  height: 27,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/bear.png"),
                      fit: BoxFit.fill,
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

// Stretch Recommendations
class StretchCard extends StatelessWidget {
  final VoidCallback? onTap;

  const StretchCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 179,
        height: 241,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 179,
                height: 241,
                decoration: ShapeDecoration(
                  color: const Color(0xFF7780BA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x2D000000),
                      blurRadius: 11.10,
                      offset: Offset(0, 11),
                      spreadRadius: 11,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 18,
              top: 23,
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  width: 153,
                  height: 199,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/stretch.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 6,
              top: 135,
              child: SizedBox(
                width: 173,
                height: 75,
                child: Text(
                  'Stretch Recommendations',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inknutAntiqua(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.2,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 6,
              top: 180,
              child: SizedBox(
                width: 165,
                height: 75,
                child: Text(
                  'Your personalized recommendations sports',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inknutAntiqua(
                    color: Color(0xFFE8E5ED),
                    fontSize: 11,
                    height: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Correct Sitting Poses
class CorrectSittingCard extends StatelessWidget {
  final VoidCallback? onTap;

  const CorrectSittingCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 179,
        height: 241,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 179,
                height: 241,
                decoration: ShapeDecoration(
                  color: const Color(0xFF7780BA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x2D000000),
                      blurRadius: 11.10,
                      offset: Offset(0, 11),
                      spreadRadius: 11,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 13,
              top: 21,
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  width: 153,
                  height: 199,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/sitting.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 135,
              child: SizedBox(
                width: 169,
                height: 75,
                child: Text(
                  'Correct\nSitting Poses',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inknutAntiqua(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.2,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 6,
              top: 180,
              child: SizedBox(
                width: 165,
                height: 75,
                child: Text(
                  'Learn the correct sitting poses by videos',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inknutAntiqua(
                    color: Color(0xFFE8E5ED),
                    fontSize: 11,
                    height: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Analytics
class AnalyticsCard extends StatelessWidget {
  final VoidCallback? onTap;

  const AnalyticsCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 381,
        height: 133,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 381,
                height: 133,
                decoration: ShapeDecoration(
                  color: const Color(0xFF7780BA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x2B000000),
                      blurRadius: 7.8,
                      offset: Offset(0, 3),
                      spreadRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 18,
              top: 20,
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  width: 123,
                  height: 91,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/barchart.png"), 
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 109,
              top: 24,
              child: SizedBox(
                width: 272,
                height: 75,
                child: Text(
                  'Analytics',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inknutAntiqua(
                    color: Colors.white,
                    fontSize: 24,
                    height: 1.2,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 128,
              top: 59,
              child: SizedBox(
                width: 240,
                height: 75,
                child: Text(
                  'Analyze your sitting posture to detect imbalances, slouching, \nor other issues',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inknutAntiqua(
                    color: const Color(0xFFD9D8DD),
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Leaderboard
class LeaderboardCard extends StatelessWidget {
  final VoidCallback? onTap;

  const LeaderboardCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 165,
        height: 129,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 165,
                height: 129,
                decoration: ShapeDecoration(
                  color: const Color(0xFF7780BA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 7,
              top: 81,
              child: SizedBox(
                width: 151,
                height: 45,
                child: Text(
                  'Leaderboard',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inknutAntiqua(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 18,
              top: 9,
              child: Text(
                'Pr',
                style: GoogleFonts.inknutAntiqua(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            Positioned(
              left: 13,
              top: 9,
              child: Text(
                '99',
                style: GoogleFonts.inknutAntiqua(
                  color: Colors.white,
                  fontSize: 48,
                ),
              ),
            ),
            Positioned(
              left: 95,
              top: 28,
              child: Container(
                width: 53,
                height: 53,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/ranking.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Donotdisturb extends StatefulWidget {
  const Donotdisturb({super.key});

  @override
  State<Donotdisturb> createState() => _DonotdisturbState();
}

class _DonotdisturbState extends State<Donotdisturb> {
  bool _isPressed = false;

  void _toggle() {
    setState(() {
      _isPressed = !_isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggle,
      borderRadius: BorderRadius.circular(25),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: 188,
        height: 129,
        decoration: BoxDecoration(
          color: _isPressed ? const Color(0xFFE7EAFF) : const Color(0xFF7780BA),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 12,
              top: 13,
              child: Opacity(
                opacity: 0.72,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/moon.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 48,
              child: SizedBox(
                width: 188,
                height: 77,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: GoogleFonts.inknutAntiqua(
                    color: _isPressed ? Colors.black : Colors.white,
                    fontSize: 16,
                    height: 1.0,
                  ),
                  child: Text(
                    _isPressed ? 'Do Not Disturb ON' : 'Do Not Disturb OFF',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 70,
              child: SizedBox(
                width: 188,
                height: 75,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: GoogleFonts.inknutAntiqua(
                    color: _isPressed ? Colors.black54 : const Color(0xFFCCCBD2),
                    fontSize: 11,
                    height: 20/11,
                  ),
                  child: Text(
                    _isPressed
                        ? 'Only records sitting posture, without reminders'
                        : 'Now it records and reminds your posture',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Elapsed Time
class ElapsedTime extends StatefulWidget {
  final bool isRunning;
  final bool shouldReset;
  final VoidCallback? onStart;
  final VoidCallback? onPause;
  final VoidCallback? onStop;

  const ElapsedTime({
    super.key,
    this.isRunning = false,
    this.shouldReset = false,
    this.onStart,
    this.onPause,
    this.onStop,
  });

  @override
  State<ElapsedTime> createState() => _ElapsedTimeState();
}

class _ElapsedTimeState extends State<ElapsedTime> {
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isRunning) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(ElapsedTime oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldReset && !oldWidget.shouldReset) {
      _stopTimer();
    } else if (widget.isRunning && !oldWidget.isRunning) {
      _startTimer();
    } else if (!widget.isRunning && oldWidget.isRunning) {
      _pauseTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
    });
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 260,
          height: 133,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 48,
                child: SizedBox(
                  width: 260,
                  height: 68,
                  child: Text(
                    _formatTime(_seconds),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inknutAntiqua(
                      textStyle: const TextStyle(
                        color: Color(0xFFE8E5ED),
                        fontSize: 64,
                      ),
                      height: 1.0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 59,
                top: 27,
                child: Opacity(
                  opacity: 0.46,
                  child: Container(
                    width: 138,
                    height: 21,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF7780BA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(115),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 26,
                top: 31,
                child: SizedBox(
                  width: 212,
                  height: 21,
                  child: Text(
                    'Elapsed Time',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inknutAntiqua(
                      textStyle: const TextStyle(
                        color: Color(0xFFCCCBD2),
                        fontSize: 11,
                      ),
                      height: 1.2,
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

