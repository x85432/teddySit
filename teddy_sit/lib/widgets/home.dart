import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

double scale = 2340/2440;
// Logo
class Teddysit extends StatelessWidget {
  const Teddysit({super.key});
  //final double scale = 2340/2400;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 275*scale,
          height: 87*scale,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: SizedBox(
                  width: 275*scale,
                  height: 87*scale,
                  child: Text(
                    'Teddy\nSit',
                    style: GoogleFonts.kirangHaerang(
                      color: const Color(0xFFE8E5ED),
                      fontSize: 38*scale,
                      height: 40/38*scale,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 47*scale,
                top: 45*scale,
                child: Container(
                  width: 27*scale,
                  height: 27*scale,
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
        width: 179*scale,
        height: 241*scale,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 179*scale,
                height: 241*scale,
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
              left: 18*scale,
              top: 23*scale,
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  width: 153*scale,
                  height: 199*scale,
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
              left: 6*scale,
              top: 135*scale,
              child: SizedBox(
                width: 173*scale,
                height: 75*scale,
                child: Text(
                  'Stretch Recommendations',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inknutAntiqua(
                    color: Colors.white,
                    fontSize: 16*scale,
                    height: 1.2*scale,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 6*scale,
              top: 180*scale,
              child: SizedBox(
                width: 165*scale,
                height: 75*scale,
                child: Text(
                  'Your personalized recommendations sports',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.inknutAntiqua(
                    color: Color(0xFFE8E5ED),
                    fontSize: 11*scale,
                    height: 1.2*scale,
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
        width: 179*scale,
        height: 241*scale,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 179*scale,
                height: 241*scale,
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
              left: 13*scale,
              top: 21*scale,
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  width: 153*scale,
                  height: 199*scale,
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
              top: 135*scale,
              child: SizedBox(
                width: 169*scale,
                height: 75*scale,
                child: Text(
                  'Correct\nSitting Poses',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inknutAntiqua(
                    color: Colors.white,
                    fontSize: 16*scale,
                    height: 1.2*scale,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 6*scale,
              top: 180*scale,
              child: SizedBox(
                width: 165*scale,
                height: 75*scale,
                child: Text(
                  'Learn the correct sitting poses by videos',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inknutAntiqua(
                    color: Color(0xFFE8E5ED),
                    fontSize: 11*scale,
                    height: 1.2*scale,
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
        width: 381*scale,
        height: 133*scale,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 381*scale,
                height: 133*scale,
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
              left: 18*scale,
              top: 20*scale,
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  width: 123*scale,
                  height: 91*scale,
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
              left: 109*scale,
              top: 24*scale,
              child: SizedBox(
                width: 272*scale,
                height: 75*scale,
                child: Text(
                  'Analytics',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inknutAntiqua(
                    color: Colors.white,
                    fontSize: 24*scale,
                    height: 1.2*scale,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 128*scale,
              top: 59*scale,
              child: SizedBox(
                width: 240*scale,
                height: 75*scale,
                child: Text(
                  'Analyze your sitting posture to detect imbalances, slouching, \nor other issues',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inknutAntiqua(
                    color: const Color(0xFFD9D8DD),
                    fontSize: 12*scale,
                    height: 1.3*scale,
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
        width: 165*scale,
        height: 129*scale,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 165*scale,
                height: 129*scale,
                decoration: ShapeDecoration(
                  color: const Color(0xFF7780BA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 7*scale,
              top: 81*scale,
              child: SizedBox(
                width: 151*scale,
                height: 45*scale,
                child: Text(
                  'Leaderboard',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inknutAntiqua(
                    color: Colors.white,
                    fontSize: 20*scale,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 18*scale,
              top: 9*scale,
              child: Text(
                'Pr',
                style: GoogleFonts.inknutAntiqua(
                  color: Colors.white,
                  fontSize: 14*scale,
                ),
              ),
            ),
            Positioned(
              left: 13*scale,
              top: 9*scale,
              child: Text(
                '99',
                style: GoogleFonts.inknutAntiqua(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 48*scale,
                ),
              ),
            ),
            Positioned(
              left: 95*scale,
              top: 28*scale,
              child: Container(
                width: 53*scale,
                height: 53*scale,
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
        width: 188*scale,
        height: 129*scale,
        decoration: BoxDecoration(
          color: _isPressed ? const Color(0xFFE7EAFF) : const Color(0xFF7780BA),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 12*scale,
              top: 13*scale,
              child: Opacity(
                opacity: 0.72,
                child: Container(
                  width: 30*scale,
                  height: 30*scale,
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
              top: 48*scale,
              child: SizedBox(
                width: 188*scale,
                height: 77*scale,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: GoogleFonts.inknutAntiqua(
                    color: _isPressed ? Colors.black : Colors.white,
                    fontSize: 16*scale,
                    height: 1.0*scale,
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
              top: 70*scale,
              child: SizedBox(
                width: 188*scale,
                height: 75*scale,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: GoogleFonts.inknutAntiqua(
                    color: _isPressed ? Colors.black54 : const Color(0xFFCCCBD2),
                    fontSize: 11*scale,
                    height: 20/11*scale,
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
          width: 260*scale,
          height: 133*scale,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 48*scale,
                child: SizedBox(
                  width: 260*scale,
                  height: 68*scale,
                  child: Text(
                    _formatTime(_seconds),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inknutAntiqua(
                      textStyle: const TextStyle(
                        color: Color(0xFFE8E5ED),
                        fontSize: 64*2340/2400,
                      ),
                      height: 1.0*2340/2400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 59*scale,
                top: 27*scale,
                child: Opacity(
                  opacity: 0.46,
                  child: Container(
                    width: 138*scale,
                    height: 21*scale,
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
                left: 26*scale,
                top: 31*scale,
                child: SizedBox(
                  width: 212*scale,
                  height: 21*scale,
                  child: Text(
                    'Elapsed Time',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inknutAntiqua(
                      textStyle: const TextStyle(
                        color: Color(0xFFCCCBD2),
                        fontSize: 11*2340/2400,
                      ),
                      height: 1.2*2340/2400,
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

