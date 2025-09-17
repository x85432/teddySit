import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

// BarChart
class BarChartExample extends StatelessWidget {
  const BarChartExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 350,
      child: BarChart(
        BarChartData(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          
          alignment: BarChartAlignment.start,
          groupsSpace: 15,
          maxY: 100,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true, 
                interval: 20, 
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: GoogleFonts.inknutAntiqua(
                      color: Color(0xFFCDCCD3),
                      fontSize: 14, 
                    ),
                  );
                },
              ),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false), 
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const labels = ['A', 'B', 'C', 'D', 'E'];
                  if (value.toInt() < labels.length) {
                    return Text(
                      labels[value.toInt()], 
                      style: GoogleFonts.inknutAntiqua(
                        color: Color(0xFFCDCCD3),
                        fontSize: 14, 
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(
            show: true,
            border: Border(
              left: BorderSide(color: const Color.fromARGB(40, 255, 255, 255), width: 2),  
              bottom: BorderSide(color: const Color.fromARGB(40, 255, 255, 255), width: 2), 
              right: BorderSide(color: const Color.fromARGB(40, 255, 255, 255), width: 2), 
              top: BorderSide(color: const Color.fromARGB(40, 255, 255, 255), width: 2), 
            ),
          ),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(
                toY: 100, 
                color: Color(0xFF7780BA), 
                width: 20,
                borderRadius: BorderRadius.circular(5)
              )
            ]),
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(
                toY: 50, 
                color: Color(0xFF7780BA), 
                width: 20,
                borderRadius: BorderRadius.circular(5)
              )
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(
                toY: 70, 
                color: Color(0xFF7780BA), 
                width: 20,
                borderRadius: BorderRadius.circular(5)
              )
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(
                toY: 30, 
                color: Color(0xFF7780BA), 
                width: 20,
                borderRadius: BorderRadius.circular(5)
              )
            ]),
          ],
        ),
      ),
    );
  }
}

// Longest Time
class LongestTimeWid extends StatelessWidget {
  const LongestTimeWid({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.24,
          child: Container(
            width: 152,
            height: 40,
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
          left: 16,
          top: 8,
          child: CircleAvatar(
            radius: 11.5, // size / 2
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFCDCCD3), width: 3),
              ),
            ),
          )
        ),
        Positioned(
          left: 57,
          top: 8,
          child: Text(
            '20 min',
            style: GoogleFonts.inknutAntiqua(
              fontSize: 14,
              color: Color(0xFFCDCCD3)
            ),
          )
        )
        
      ],
    );
  }
}

// 折線圖
class LineChartPage extends StatelessWidget {
  final String label;
  final List<FlSpot> spots;

  const LineChartPage({super.key, required this.label, required this.spots});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("折線圖: $label"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 350,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: const Color(0xFF7780BA),
                  barWidth: 3,
                  dotData: FlDotData(show: true),
                ),
              ],
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false), // 左邊不顯示
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 2, // 你可以改成 20 / 10 等等
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: GoogleFonts.inknutAntiqua(
                          color: const Color(0xFFCDCCD3),
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(), // X 軸數字
                        style: GoogleFonts.inknutAntiqua(
                          color: const Color(0xFFCDCCD3),
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: const Color.fromARGB(40, 255, 255, 255),
                  width: 2,
                ),
              ),
              gridData: FlGridData(show: false),
            ),
          ),
        ),
      ),
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

class BarToLineChartExample extends StatefulWidget {
  final List<List<FlSpot>> lineDataPerBar;

  const BarToLineChartExample({super.key, required this.lineDataPerBar});

  @override
  BarToLineChartExampleState createState() => BarToLineChartExampleState();
}

class BarToLineChartExampleState extends State<BarToLineChartExample> {
  bool showLineChart = false;
  int selectedBarIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 350,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: showLineChart ? buildAnimatedLineChart() : buildBarChart(),
      ),
    );
  }

  Widget buildBarChart() {
    return BarChart(
      key: const ValueKey('barChart'),
      BarChartData(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        alignment: BarChartAlignment.start,
        groupsSpace: 15,
        maxY: 100,
        barTouchData: BarTouchData(
          enabled: true,
          touchCallback: (event, response) {
            if (response != null &&
                response.spot != null &&
                event.isInterestedForInteractions) {
              setState(() {
                selectedBarIndex = response.spot!.touchedBarGroupIndex;
                showLineChart = true;
              });
            }
          },
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: GoogleFonts.inknutAntiqua(
                    color: Color(0xFFCDCCD3),
                    fontSize: 14,
                  ),
                );
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const labels = ['A', 'B', 'C', 'D', 'E'];
                if (value.toInt() < labels.length) {
                  return Text(
                    labels[value.toInt()],
                    style: GoogleFonts.inknutAntiqua(
                      color: Color(0xFFCDCCD3),
                      fontSize: 14,
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Color.fromARGB(40, 255, 255, 255), width: 2),
        ),
        barGroups: List.generate(widget.lineDataPerBar.length, (index) {
          final yValues = widget.lineDataPerBar[index];
          double maxY = yValues.isNotEmpty
              ? yValues.map((e) => e.y).reduce((a, b) => a > b ? a : b)
              : 0;

          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: maxY,
                color: Color(0xFF7780BA),
                width: 20,
                borderRadius: BorderRadius.circular(5),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  color: Colors.grey,
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget buildAnimatedLineChart() {
    final targetSpots = (selectedBarIndex >= 0 &&
            selectedBarIndex < widget.lineDataPerBar.length)
        ? widget.lineDataPerBar[selectedBarIndex].cast<FlSpot>()
        : <FlSpot>[];

    return Stack(
      key: const ValueKey('lineChart'),
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 700),
          builder: (context, value, child) {
            final animatedSpots = targetSpots
                .map((e) => FlSpot(e.x, e.y * value))
                .toList();
            return LineChart(
              LineChartData(
                minY: 0,
                maxY: 100,
                gridData: FlGridData(show: false),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                      color: Color.fromARGB(40, 255, 255, 255), width: 2),
                ),
                titlesData: FlTitlesData(
                  leftTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: true, reservedSize: 40)),
                  bottomTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: true)),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: animatedSpots,
                    isCurved: true,
                    color: Color(0xFF7780BA),
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                  ),
                ],
              ),
            );
          },
        ),
        Positioned(
          top: 0,
          right: 10,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              setState(() {
                showLineChart = false;
                selectedBarIndex = -1; // 重置高亮
              });
            },
          ),
        ),
      ],
    );
  }
}