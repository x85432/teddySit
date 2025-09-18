import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/home.dart';
import '../widgets/analytic_wid.dart';
//import '../widgets/stretch_wid.dart';

// 下拉選單項目
const List<String> dropdownOptions = ['Set 1', 'Set 2', 'Set 3'];

class AnalyticPage extends StatefulWidget {
  const AnalyticPage({super.key});

  @override
  State<AnalyticPage> createState() => _AnalyticPageState();
}

class _AnalyticPageState extends State<AnalyticPage> {
  String selectedOption = dropdownOptions.first;

  // 不同數據對應
  final Map<String, List<List<FlSpot>>> lineDataSets = {
    'Set 1': [
      [FlSpot(0, 10), FlSpot(1, 20)],
      [FlSpot(0, 30), FlSpot(1, 40)],
      [FlSpot(0, 50), FlSpot(1, 60)],
    ],
    'Set 2': [
      [FlSpot(0, 15), FlSpot(1, 25)],
      [FlSpot(0, 35), FlSpot(1, 45)],
      [FlSpot(0, 55), FlSpot(1, 65)],
    ],
    'Set 3': [
      [FlSpot(0, 20), FlSpot(1, 30)],
      [FlSpot(0, 40), FlSpot(1, 50)],
      [FlSpot(0, 60), FlSpot(1, 70)],
    ],
  };

  final Map<String, List<String>> labelsSets = {
    'Set 1': ['A', 'B', 'C'],
    'Set 2': ['X', 'Y', 'Z'],
    'Set 3': ['L', 'M', 'N'],
  };

  final Map<String, List<double>> barValuesSets = {
    'Set 1': [20, 50, 80],
    'Set 2': [30, 40, 70],
    'Set 3': [10, 60, 90],
  };

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
              },
              child: const Image(
                image: AssetImage('assets/Home.png'),
                width: 35,
                height: 35,
              ),
            ),
          ),
          const SizedBox(width: 18),
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: InkWell(
              onTap: () {},
              child: const Image(
                image: AssetImage('assets/Account.png'),
                width: 45,
                height: 45,
              ),
            ),
          ),
          const SizedBox(width: 18),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          SizedBox(
            height: 41,
            width: 374,
            child: Row(
              children: [
                const SizedBox(width: 30),
                Text(
                  'Average Score',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 14,
                    color: const Color(0xFFCDCCD3),
                  ),
                ),
                const SizedBox(width: 100),
                // ✅ 下拉選單
                Container(
                  width: 130,
                  height: 41,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
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
                        fontSize: 14,
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
          // ✅ 圖表
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 35),
            child: BarToLineChartExample(
              lineDataPerBar: lineDataSets[selectedOption]!,
              labels: labelsSets[selectedOption]!,
              barValues: barValuesSets[selectedOption]!,
            ),
          ),
          const SizedBox(height: 27),
          Row(
            children: [
              const SizedBox(width: 20),
              Stack(
                children: [
                  Positioned(
                    left: 14,
                    top: 23,
                    child: Text(
                      'Longest Duration\nof Correct and\nIncorrect Posture',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inknutAntiqua(
                        fontSize: 16,
                        color: const Color(0xFFCDCCD3),
                        height: 20/16
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
              const SizedBox(width: 19),
              Column(
                children: const [
                  LongestTimeWid(text: '20 min', type: 0), 
                  SizedBox(height: 19),
                  LongestTimeWid(text: '15 min', type: 1),
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
                  color: const Color(0xFFCDCCD3),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 21, top: 8),
              child: Report(),
            ),
          ),
        ],
      ),
    );
  }
}
