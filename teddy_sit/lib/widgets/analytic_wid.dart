import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

// Longest Time
class LongestTimeWid extends StatelessWidget {
  final String text;   // 顯示的文字，例如 "20 min"
  final int type;      // 0 = ✅ 圈圈, 1 = ❌ 叉叉

  const LongestTimeWid({
    super.key,
    required this.text,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 背景
        Opacity(
          opacity: 0.24,
          child: Container(
            width: 152,
            height: 40,
            decoration: ShapeDecoration(
              gradient: const LinearGradient(
                begin: Alignment(0.00, -1.00),
                end: Alignment(0, 1),
                colors: [Color(0xFFE7EAFF), Color(0xFF9785FF)],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
        // Icon
        Positioned(
          left: 16,
          top: 8,
          child: Icon(
            type == 0 ? Icons.circle_outlined : Icons.close, // ✅ 或 ❌
            color: const Color(0xFFCDCCD3),
            size: 23,
          ),
        ),
        // Text
        Positioned(
          left: 57,
          top: 8,
          child: Text(
            text,
            style: GoogleFonts.inknutAntiqua(
              fontSize: 14,
              color: const Color(0xFFCDCCD3),
            ),
          ),
        ),
      ],
    );
  }
}


// Report
class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Opacity(
              opacity: 0.24,
              child: Container(
                width: 135,
                height: 204*0.8,
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Color(0xFFE7EAFF), Color(0xFF9785FF)]    
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ), 
              ),
            ),
            Positioned(
              left: 40,
              top: 7,
              child: Text(
                'A',
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 60,
                  color: Color(0xFFFFFFFF)
                ),
              )
            ),
            Positioned(              
              top: 90,
              left: 22,
              child: Text(
                textAlign: TextAlign.right,
                'Your\nPosture\nhealth Level',
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 13,
                  color: Color(0xFFCDCCD3),
                  height: 20/16
                ),
              )
            )
            
          ],
        ),
        const SizedBox(width: 8),
        Stack(
          children: [
            Opacity(
              opacity: 0.24,
              child: Container(
                width: 227,
                height: 204*0.8,
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Color(0xFFE7EAFF), Color(0xFF9785FF)]    
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ), 
              ),
            ),
            Positioned(              
              top: 18,
              left: 32,
              child: Text(
                textAlign: TextAlign.center,
                'Click here to get the\nanalytic report',
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 13,
                  color: Color(0xFFCDCCD3),
                  height: 20/16
                ),
              )
            ),
            Positioned(
              left: 75,
              top: 65,
              child: Image(
                image: AssetImage('assets/conversation.png'),
                width: 102 * 0.8,
                height: 102 * 0.8,)
              
            )
          ],
        ),

      ],
    );
  }
}

//Bar Chart
class BarToLineChartExample extends StatefulWidget {
  final List<List<FlSpot>> lineDataPerBar;
  final List<String> labels;
  final List<double> barValues;

  const BarToLineChartExample({
    super.key,
    required this.lineDataPerBar,
    required this.labels,
    required this.barValues,
  });

  @override
  State<BarToLineChartExample> createState() => _BarToLineChartExampleState();
}

class _BarToLineChartExampleState extends State<BarToLineChartExample> {
  bool showLineChart = false;
  int selectedBarIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320, 
      width: 350,
      child: Column(
        children: [
          // 上方返回鍵
          if (showLineChart)
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  setState(() {
                    showLineChart = false;
                    selectedBarIndex = -1;
                  });
                },
              ),
            )
          else
            const SizedBox(height: 40), 

          // 下方圖表
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: showLineChart ? buildAnimatedLineChart() : buildBarChart(),
            ),
          ),
        ],
      ),
    );
  }

  /// BarChart
  Widget buildBarChart() {
    return SizedBox(
      key: const ValueKey('barChart'),
      height: 280,
      width: 350,
      child: BarChart(
        BarChartData(
          minY: 0,
          maxY: 100,
          alignment: BarChartAlignment.start,
          gridData: FlGridData(show: false),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: const Color.fromARGB(40, 255, 255, 255),
              width: 2,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 20,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}',
                    style: GoogleFonts.inknutAntiqua(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= widget.labels.length) {
                    return const SizedBox.shrink();
                  }
                  return Text(
                    widget.labels[index],
                    style: GoogleFonts.inknutAntiqua(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(widget.barValues.length, (i) {
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: widget.barValues[i],
                  color: Colors.blueAccent,
                  width: 20,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }),
          barTouchData: BarTouchData(
            touchCallback: (event, response) {
              if (!event.isInterestedForInteractions ||
                  response == null ||
                  response.spot == null) return;

              setState(() {
                selectedBarIndex = response.spot!.touchedBarGroupIndex;
                showLineChart = true;
              });
            },
          ),
        ),
      ),
    );
  }

  /// LineChart
  Widget buildAnimatedLineChart() {
    final targetSpots = (selectedBarIndex >= 0 &&
            selectedBarIndex < widget.lineDataPerBar.length)
        ? widget.lineDataPerBar[selectedBarIndex]
        : <FlSpot>[];

    return SizedBox(
      key: const ValueKey('lineChart'),
      height: 280,
      width: 350,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 700),
        builder: (context, value, child) {
          final animatedSpots =
              targetSpots.map((e) => FlSpot(e.x, e.y * value)).toList();

          return LineChart(
            LineChartData(
              minX: 0,
              maxX: 30, // 0 ~ 180 秒
              minY: 0,
              maxY: 100,
              gridData: FlGridData(show: false),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: const Color.fromARGB(40, 255, 255, 255),
                  width: 2,
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 20,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        '${value.toInt()}pts',
                        style: GoogleFonts.inknutAntiqua(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                      );
                    },
                  ),
                ),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 5, // 每 30 秒一個刻度
                    getTitlesWidget: (value, meta) {
                      return Text(
                        '${value.toInt()}s',
                        style: GoogleFonts.inknutAntiqua(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      );
                    },
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: animatedSpots,
                  isCurved: true,
                  color: const Color(0xFF7780BA),
                  barWidth: 3,
                  dotData: FlDotData(show: true),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}