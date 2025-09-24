import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

// 時間記錄類別
class TimeSegment {
  final DateTime startTime;
  final DateTime? endTime;

  TimeSegment({required this.startTime, this.endTime});

  Duration get duration {
    if (endTime != null) {
      return endTime!.difference(startTime);
    }
    return DateTime.now().toUtc().difference(startTime);
  }

  String get formattedStart => '${startTime.year}-${startTime.month.toString().padLeft(2, '0')}-${startTime.day.toString().padLeft(2, '0')} ${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}:${startTime.second.toString().padLeft(2, '0')}';
  String get formattedEnd => endTime != null ? '${endTime!.year}-${endTime!.month.toString().padLeft(2, '0')}-${endTime!.day.toString().padLeft(2, '0')} ${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}:${endTime!.second.toString().padLeft(2, '0')}' : '進行中';
}

class TimerSession {
  final List<TimeSegment> segments = [];
  
  void startSegment() {
    segments.add(TimeSegment(startTime: DateTime.now().toUtc()));
  }

  void endCurrentSegment() {
    if (segments.isNotEmpty && segments.last.endTime == null) {
      final lastSegment = segments.removeLast();
      segments.add(TimeSegment(startTime: lastSegment.startTime, endTime: DateTime.now().toUtc()));
    }
  }

  Duration get totalDuration {
    return segments.fold(Duration.zero, (total, segment) => total + segment.duration);
  }

  String getSessionSummary() {
    String summary = '📊 完整使用記錄：\n總時長: ${_formatDuration(totalDuration)}\n時間段:\n';
    for (int i = 0; i < segments.length; i++) {
      final segment = segments[i];
      summary += '  ${i + 1}. ${segment.formattedStart} - ${segment.formattedEnd} (${_formatDuration(segment.duration)})\n';
    }
    return summary;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inHours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
  }
}

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
  final bool trans;

  const StretchCard({super.key, this.onTap, required this.trans});

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
              top: (trans == false) ? 135*scale : 145*scale,
              child: SizedBox(
                width: 173*scale,
                height: 75*scale,
                child: Text(
                  (trans == false) ? 'Stretch Recommendations' : '伸展建議',
                  textAlign: TextAlign.left,
                  style: (trans == false) ? GoogleFonts.inknutAntiqua(
                    color: Colors.white,
                    fontSize: 16*scale,
                    height: 1.2*scale,
                  ) : GoogleFonts.notoSerifTc(
                    color: Colors.white,
                    fontSize: 20*scale,
                    height: 1.2*scale,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 6*scale,
              top: (trans == false) ? 180*scale : 175*scale,
              child: SizedBox(
                width: 165*scale,
                height: 75*scale,
                child: Text(
                  (trans == false) ? 'Your personalized recommendations sports' : '您的個性化運動建議',
                  textAlign: TextAlign.left,
                  style: (trans == false) ? GoogleFonts.inknutAntiqua(
                    color: Color(0xFFE8E5ED),
                    fontSize: 11*scale,
                    height: 1.2*scale,
                  ) : GoogleFonts.notoSerifTc(
                    color: Color(0xFFE8E5ED),
                    fontSize: 15*scale,
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
  final bool trans;

  const CorrectSittingCard({super.key, this.onTap, required this.trans});

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
              top: (trans == false) ? 135*scale : 145*scale,
              child: SizedBox(
                width: 169*scale,
                height: 75*scale,
                child: Text(
                  (trans == false) ? 'Correct\nSitting Poses' : '正確的坐姿',
                  textAlign: TextAlign.right,
                  style: (trans == false) ? GoogleFonts.inknutAntiqua(
                    color: Colors.white,
                    fontSize: 16*scale,
                    height: 1.2*scale,
                  ) : GoogleFonts.notoSerifTc(
                    color: Colors.white,
                    fontSize: 20*scale,
                    height: 1.2*scale)
                ),
              ),
            ),
            Positioned(
              left: 6*scale,
              top: (trans == false) ? 180*scale : 175*scale,
              child: SizedBox(
                width: 165*scale,
                height: 75*scale,
                child: Text(
                  (trans == false) ? 'Learn the correct sitting poses by videos' : '通過影片學習正確的坐姿',
                  textAlign: TextAlign.right,
                  style: (trans == false) ? GoogleFonts.inknutAntiqua(
                    color: Color(0xFFE8E5ED),
                    fontSize: 11*scale,
                    height: 1.2*scale,
                  ) : GoogleFonts.notoSerifTc(
                    color: Color(0xFFE8E5ED),
                    fontSize: 14*scale,
                    height: 1.2*scale)
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
  final bool trans;

  const AnalyticsCard({super.key, this.onTap, required this.trans});

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
              top: (trans == false) ? 24*scale : 28*scale,
              child: SizedBox(
                width: 272*scale,
                height: 75*scale,
                child: Text(
                  (trans == false) ? 'Analytics' : '分析',
                  textAlign: TextAlign.center,
                  style: (trans == false) ? GoogleFonts.inknutAntiqua(
                    color: Colors.white,
                    fontSize: 24*scale,
                    height: 1.2*scale,
                  ) : GoogleFonts.notoSerifTc(
                    color: Colors.white,
                    fontSize: 30*scale,
                    height: 1.2*scale)
                ),
              ),
            ),
            Positioned(
              left: (trans == false) ? 128*scale : 140*scale,
              top: (trans == false) ? 59*scale : 70*scale,
              child: SizedBox(
                width: 240*scale,
                height: 75*scale,
                child: Text(
                  (trans == false) ? 'Analyze your sitting posture to detect imbalances, slouching, \nor other issues' : '分析你的坐姿以檢測不平衡、\n駝背或其他問題',
                  textAlign: TextAlign.center,
                  style: (trans == false) ? GoogleFonts.inknutAntiqua(
                    color: const Color(0xFFD9D8DD),
                    fontSize: 12*scale,
                    height: 1.3*scale,
                  ) : GoogleFonts.notoSerifTc(
                    color: const Color(0xFFD9D8DD),
                    fontSize: 15*scale,
                    height: 1.3*scale)
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
  final bool trans;

  const LeaderboardCard({super.key, this.onTap, required this.trans});

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
                  (trans == false) ? 'Leaderboard' : '排行榜',
                  textAlign: TextAlign.center,
                  style: (trans == false) ?GoogleFonts.inknutAntiqua(
                    color: Colors.white,
                    fontSize: 18*scale,
                  ) : GoogleFonts.notoSerifTc(
                    color: Colors.white,
                    fontSize: 23*scale)
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
                  fontSize: 42*scale,
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
  final bool trans;

  const Donotdisturb({super.key, required this.trans});

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
              top: (widget.trans == false) ? 48*scale : 53*scale,
              child: SizedBox(
                width: 188*scale,
                height: 77*scale,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: (widget.trans == false) ? GoogleFonts.inknutAntiqua(
                    color: _isPressed ? Colors.black : Colors.white,
                    fontSize: 13*scale,
                    height: 1.0*scale,
                  ) : GoogleFonts.notoSerifTc(
                    color: _isPressed ? Colors.black : Colors.white,
                    fontSize: 20*scale,
                    height: 1.0*scale,
                  ),
                  child: Text(
                    _isPressed
                      ? (widget.trans ? '勿擾模式 開啟' : 'Do Not Disturb ON')
                      : (widget.trans ? '勿擾模式 關閉' : 'Do Not Disturb OFF'),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: (widget.trans == false) ? 70*scale : 77*scale,
              child: SizedBox(
                width: 188*scale,
                height: 75*scale,
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: (widget.trans == false) ?GoogleFonts.inknutAntiqua(
                    color: _isPressed ? Colors.black54 : const Color(0xFFCCCBD2),
                    fontSize: 11*scale,
                    height: 20/11*scale,
                  ) : GoogleFonts.notoSerifTc(
                    color: _isPressed ? Colors.black54 : const Color(0xFFCCCBD2),
                    fontSize: 15*scale,
                    height: 20/15*scale,
                  ),
                  child: Text(
                    _isPressed
                        ? (widget.trans ? '僅記錄坐姿，不提醒' : 'Only records sitting posture, without reminders')
                        : (widget.trans ? '現在記錄並提醒您的坐姿' : 'Now it records and reminds your posture'),
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
  final bool trans;
  final VoidCallback? onStart;
  final VoidCallback? onPause;
  final VoidCallback? onStop;

  const ElapsedTime({
    super.key,
    this.isRunning = false,
    this.shouldReset = false,
    required this.trans,
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
  TimerSession _session = TimerSession();  // 新增時間記錄

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
    // 避免重複啟動
    if (_timer != null && _timer!.isActive) {
      return;
    }

    _session.startSegment();  // 開始新的時間段
    final now = DateTime.now().toUtc();
    debugPrint('⏰ 開始時間: ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}');

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _pauseTimer() {
    _session.endCurrentSegment();  // 結束當前時間段
    final now = DateTime.now().toUtc();
    debugPrint('⏸️ 暫停時間: ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}');
    debugPrint(_session.getSessionSummary());  // 顯示目前記錄


    _timer?.cancel();
  }

  void _stopTimer() {
    _session.endCurrentSegment();  // 結束當前時間段
    final now = DateTime.now().toUtc();
    debugPrint('⏹️ 結束時間: ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}');
    debugPrint(_session.getSessionSummary());  // 顯示完整記錄


    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _session = TimerSession();  // 重置會話
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

  // 取得完整時間記錄的方法
  TimerSession getCurrentSession() {
    return _session;
  }

  // 直接取得時間段列表
  List<TimeSegment> getSegments() {
    return _session.segments;
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
                        fontSize: 54*2340/2400,
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
                top: (widget.trans == false) ? 31*scale : 28*scale,
                child: SizedBox(
                  width: 212*scale,
                  height: 21*scale,
                  child: Text(
                    widget.trans ? '已用時間' : 'Elapsed Time',
                    textAlign: TextAlign.center,
                    style: (widget.trans == false) ? GoogleFonts.inknutAntiqua(
                      textStyle: const TextStyle(
                        color: Color(0xFFCCCBD2),
                        fontSize: 11*2340/2400,
                      ),
                      height: 1.2*2340/2400,
                    ) : GoogleFonts.notoSerifTc(
                      textStyle: const TextStyle(
                        color: Color(0xFFCCCBD2),
                        fontSize: 15*2340/2400,
                      ),
                      height: 1.2*2340/2400)
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

