import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

double scale  = 2340/2400;
// Longest Time
class LongestTimeWid extends StatelessWidget {   
  final int type;  
  final int minutes;

  const LongestTimeWid({
    super.key,
    required this.type,
    required this.minutes
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 背景
        Opacity(
          opacity: 0.24,
          child: Container(
            width: 152*scale,
            height: 40*scale,
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
          left: 16*scale,
          top: 8*scale,
          child: Icon(
            type == 0 ? Icons.circle_outlined : Icons.close, // ✅ 或 ❌
            color: const Color(0xFFCDCCD3),
            size: 23*scale,
          ),
        ),
        // Text
        Positioned(
          left: 57*scale,
          top: 8*scale,
          child: Text(
            '$minutes min',
            style: GoogleFonts.inknutAntiqua(
              fontSize: 14*scale,
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
  
  final double score;
  const Report({super.key, this.score = 0});
  
  String level(double num)
  {
    if (score >= 90) {return 'A+';}
    else if (score >= 75) {return 'A';}
    else if (score >= 60) {return 'B';}
    return 'C';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Opacity(
              opacity: 0.24,
              child: Container(
                width: 450*0.8*scale,
                height: 110*0.8*scale,
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(0.00, -1.00),
                    end: Alignment(0, 1),
                    colors: [Color(0xFFE8EBFF), Color(0xFF9886FF)]    
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ), 
              ),
            ),
            Positioned(
              left: 15,
              top: 14.5,
              child: Opacity(
              opacity: 0.24,
              child: Container(
                width: 74*0.8*scale,
                height: 74*0.8*scale,
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
            ),
            Positioned(
              left: 30,
              top: 16,
              child: Text(
                level(score),
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 32,
                  color: Colors.white,
                ),
               
              )
            ),
            Positioned(
              left: 113,
              top: 6,
              child: Text(
                textAlign: TextAlign.center,
                'Your Posture\nHealth Level &\nFinal Grade',
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 14.5,
                  color: Colors.white,
                ),
               
              )
            ),
            Positioned(
              left: 280,
              top: 14.5,
              child: Opacity(
              opacity: 0.24,
              child: Container(
                width: 74*0.8*scale,
                height: 74*0.8*scale,
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
            ),
            Positioned(
              left: 285,
              top: 19.6,
              child: Text(
                '${score.toInt()}',
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 30,
                  color: Colors.white,
                ),
               
              )
            ),
            
            
            
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
      height: 260*scale, 
      width: 350*scale,
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
            SizedBox(height: 40*scale), 

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
      height: 220*scale,
      width: 350*scale,
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
              width: 2*scale,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40*scale,
                interval: 20,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}',
                    style: GoogleFonts.inknutAntiqua(
                      color: Colors.white,
                      fontSize: 12*scale,
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
                      fontSize: 12*scale,
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
                  width: 20*scale,
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
    final allSpotsList = widget.lineDataPerBar;

    // 計算每個 segment 的偏移量
    final offsets = <double>[];
    double currentOffset = 0.0;
    const double segmentGap = 1; // 你想要的間距

    for (var spots in allSpotsList) {
      offsets.add(currentOffset);
      if (spots.isNotEmpty) {
        currentOffset += spots.last.x; // 取最後一點的 x
      }
      currentOffset += segmentGap; // 加上間隔
    }

    return SizedBox(
      key: const ValueKey('lineChart'),
      height: 220 * scale,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: (allSpotsList.length * 300).toDouble(),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 700),
            builder: (context, value, child) {
              const double segmentGap = 5.0; // 每個 segment 的間距 (x 軸上分隔開的距離)

              final animatedLines = allSpotsList.asMap().entries.map((entry) {
                final idx = entry.key;
                final spots = entry.value;

                final animatedSpots = spots
                    .map((e) => FlSpot(e.x + offsets[idx], e.y * value))
                    .toList();

                return LineChartBarData(
                  spots: animatedSpots,
                  isCurved: false,
                  color: const Color(0xFF7780BA),
                  barWidth: 3 * scale,
                  dotData: FlDotData(show: true),
                );
              }).toList();

              double chartMaxX = 30; // 預設 30
              if (allSpotsList.isNotEmpty) {
                  final maxXFromData = allSpotsList.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final spots = entry.value;
                  if (spots.isEmpty) return 0.0;
                  // 每個 segment 的最後一個點的 X + offset
                      return spots.last.x + offsets[idx];
                  }).reduce((a, b) => a > b ? a : b);

                  chartMaxX = maxXFromData;
              }

              return LineChart(
                LineChartData(
                  minX: 0,
                  maxX: chartMaxX,
                  minY: 0,
                  maxY: 100,
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: const Color.fromARGB(40, 255, 255, 255),
                      width: 2 * scale,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40 * scale,
                        interval: 20,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}',
                            style: GoogleFonts.inknutAntiqua(
                              color: Colors.white,
                              fontSize: 12 * scale,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 5, // 可依 segmentGap 調整
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}s',
                            style: GoogleFonts.inknutAntiqua(
                              color: Colors.white,
                              fontSize: 12 * scale,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  lineBarsData: animatedLines,
                ),
              );
            },
          ),
        )
      )
    );
  }

}