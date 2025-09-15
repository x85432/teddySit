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

