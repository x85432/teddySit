import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/home.dart';
import '../widgets/analytic_wid.dart';
//import '../widgets/stretch_wid.dart';

double scale = 2340/2400;

// 下拉選單項目
const List<String> dropdownOptions = ['Today', 'Past 7 Days', 'Past Months'];

class AnalyticPage extends StatefulWidget {
  const AnalyticPage({super.key});
  

  @override
  State<AnalyticPage> createState() => _AnalyticPageState();
}

class _AnalyticPageState extends State<AnalyticPage> {
  String selectedOption = dropdownOptions.first;

  final Map<String, List<List<FlSpot>>> lineDataSets = {
    'Today': [
      [FlSpot(0, 10), FlSpot(1, 20)],
      [FlSpot(0, 30), FlSpot(1, 40)],
      [FlSpot(0, 50), FlSpot(1, 60)],
    ],
    'Past 7 Days': [
      [FlSpot(0, 15), FlSpot(1, 25)],
      [FlSpot(0, 35), FlSpot(1, 45)],
      [FlSpot(0, 55), FlSpot(1, 65)],
    ],
    'Past Months': [
      [FlSpot(0, 20), FlSpot(1, 30)],
      [FlSpot(0, 40), FlSpot(1, 50)],
      [FlSpot(0, 60), FlSpot(1, 70)],
    ],
  };

  final Map<String, List<String>> labelsSets = {
    'Today': ['A', 'B', 'C'],
    'Past 7 Days': ['X', 'Y', 'Z'],
    'Past Months': ['L', 'M', 'N'],
  };

  final Map<String, List<double>> barValuesSets = {
    'Today': [20, 50, 80],
    'Past 7 Days': [30, 40, 70],
    'Past Months': [10, 60, 90],
  };

  final Map<String, double> averageScores = 
  {
    'Today': 85.0,
    'Past 7 Days': 78.5,
    'Past Months': 82.3,
  };

  int correct = 40;
  int incorrect = 50;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100*scale,
        title: Padding(
          padding: EdgeInsets.only(top: 11*scale, left: 12*scale),
          child: const Teddysit(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 28*scale), 
            child: InkWell(
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
              },
              child: Image(
                image: AssetImage('assets/Home.png'),
                width: 35*scale,
                height: 35*scale,
              ),
            ),
          ),
          SizedBox(width: 18*scale),
          Padding(
            padding: EdgeInsets.only(top: 28*scale),
            child: InkWell(
              onTap: () {},
              child: Image(
                image: AssetImage('assets/Account.png'),
                width: 45*scale,
                height: 45*scale,
              ),
            ),
          ),
          SizedBox(width: 18*scale),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20*scale),
          SizedBox(
            height: 41*scale,
            width: 374*scale,
            child: Row(
              children: [
                SizedBox(width: 15*scale),
                Text(
                  'Average Score: ${averageScores[selectedOption] ?? 0}',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 14*scale,
                    color: const Color(0xFFCDCCD3),
                  ),
                ),
                SizedBox(width: 20*scale),
                
                Container(
                  width: 150*scale,
                  height: 41*scale,
                  padding: EdgeInsets.symmetric(horizontal: 12*scale),
                  decoration: BoxDecoration(
                    color: const Color(0x48D9D9D9),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedOption,
                      dropdownColor: const Color.fromARGB(255, 67, 78, 99),
                      borderRadius: BorderRadius.circular(18),
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFFCDCCD3)),
                      elevation: 8,
                      style: GoogleFonts.inknutAntiqua(
                        color: const Color(0xFFCDCCD3),
                        fontSize: 14*scale,
                      ),
                      onChanged: (String? newValue) {
                        if (newValue == null) return;
                        setState(() {
                          selectedOption = newValue;
                        });
                      },
                      items: dropdownOptions
                          .map((value) => DropdownMenuItem<String>(
                                value: value,
                                child: Center(child: Text(value)),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(top: 0*scale, left: 35*scale),
            child: BarToLineChartExample(
              lineDataPerBar: lineDataSets[selectedOption]!,
              labels: labelsSets[selectedOption]!,
              barValues: barValuesSets[selectedOption]!,
            ),
          ),
          SizedBox(height: 10*scale),
          Row(
            children: [
              SizedBox(width: 20*scale),
              Stack(
                children: [
                  Positioned(
                    left: 14*scale,
                    top: 23*scale,
                    child: Text(
                      'Longest Duration\nof Correct and\nIncorrect Posture',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inknutAntiqua(
                        fontSize: 16*scale,
                        color: const Color(0xFFCDCCD3),
                        height: 20/16*scale
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.24,
                    child: Container(
                      width: 187*scale,
                      height: 111*scale,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFE7EAFF), Color(0xFF314AEF)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 19*scale),
              Column(
                children:  [
                  LongestTimeWid(minutes: correct, type: 0), 
                  SizedBox(height: 19*scale),
                  LongestTimeWid(minutes: incorrect, type: 1),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 26*scale, top: 18*scale),
              child: Text(
                'Statistic',
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 14*scale,
                  color: const Color(0xFFCDCCD3),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 21*scale, top: 8*scale),
              child: Report(),
            ),
          ),
        ],
      ),
    );
  }
}
