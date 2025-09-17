import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/home.dart';
import '../widgets/analytic_wid.dart';
import '../widgets/stretch_wid.dart';

class AnalyticPage extends StatelessWidget {
  const AnalyticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: Padding(
          padding: const EdgeInsets.only(top: 11, left: 12),
          child: const Teddysit(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 28), 
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings page
              },
              child: Image(image: AssetImage('assets/Home.png'), width: 35, height: 35),
            ),
          ),
          const SizedBox(width: 18),
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: InkWell(
              onTap: () {
                
              },
              child: Image(image: AssetImage('assets/Account.png'), width: 45, height: 45),
            )
          ),
          const SizedBox(width: 18),
        ],
      ),
      body:
      Column(
        children: [
          SizedBox(height: 30),
          SizedBox(
            height: 41,
            width: 374,
            child: Row(
              children: [
                SizedBox(width: 30),
                Text(
                  'Average Score',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 14,
                    color: Color(0xFFCDCCD3),
                  ),
                ),
                SizedBox(width: 100),
                DropdownButtonExample(),
              ],
            ),
          ), 
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 35),
            child:
            //BarChartExample()
            BarToLineChartExample(
              lineDataPerBar: [
                [FlSpot(0, 10), FlSpot(1, 20), FlSpot(2, 30)], // A
                [FlSpot(0, 50), FlSpot(1, 60), FlSpot(2, 70)], // B
                [FlSpot(0, 30), FlSpot(1, 40), FlSpot(2, 50)], // C
                [FlSpot(0, 20), FlSpot(1, 30), FlSpot(2, 40)], // D
                [FlSpot(0, 0), FlSpot(1, 10), FlSpot(2, 20)],  // E
              ],
            ),
          ),
          const SizedBox(height: 27),
          Row(
            children: [
              const SizedBox(width: 20),
              Stack(
                children: [
                  Positioned(
                    left: 25,
                    top: 24,
                    child: Text(
                      'Longest Duration\nof Correct and\nIncorrect Posture',
                      style: GoogleFonts.inknutAntiqua(
                        fontSize: 14,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.24,
                    child: Container(
                      width: 187,
                      height: 111,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [Color(0xFFE7EAFF), Color(0xFF314AEF)]    
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ), 
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 19),
              Column(
                children: [
                  LongestTimeWid(),
                  SizedBox(height: 19),
                  LongestTimeWid()
                ],
              ),

            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 26, top: 18),
              child: Text(
                'Statistic',
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 14,
                  color: Color(0xFFCDCCD3),
                ),
              ),
            ),
          ),
           Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 21, top: 8),
              child: Report()
            ),
          ),
          
          
          
        ]
      )
    );
  }
}