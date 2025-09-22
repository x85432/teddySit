import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:teddy_sit/pages/piechart_test.dart';
import '../widgets/home.dart';
import '../widgets/analytic_wid.dart';
import '../widgets/piechart_wid.dart';
import '../services/sensor_data_manager.dart';
//import '../widgets/stretch_wid.dart';

double scale = 2340/2400;

// 下拉選單項目
const List<String> dropdownOptions = ['Today', 'Past 3 Days', 'Past 5 Days'];

class AnalyticPage extends StatefulWidget {
  
  const AnalyticPage({super.key,});
  

  @override
  State<AnalyticPage> createState() => _AnalyticPageState();
}

class _AnalyticPageState extends State<AnalyticPage> {
  String selectedOption = dropdownOptions.first;

  final Map<String, List<List<FlSpot>>> lineDataSets = {
    'Today': [
      [FlSpot(0, 10), FlSpot(1, 20), FlSpot.nullSpot, FlSpot(3, 5), FlSpot(4, 6)],
      [FlSpot(0, 30), FlSpot(1, 40)],
      [FlSpot(0, 50), FlSpot(1, 60)],
    ],
    'Past 3 Days': [
      [FlSpot(0, 15), FlSpot(1, 25)],
      [FlSpot(0, 35), FlSpot(1, 45)],
      [FlSpot(0, 55), FlSpot(1, 65)],
    ],
    'Past 5 Days': [
      [FlSpot(0, 20), FlSpot(1, 30)],
      [FlSpot(0, 40), FlSpot(1, 50)],
      [FlSpot(0, 60), FlSpot(1, 70)],
    ],
  };

  final Map<String, List<String>> labelsSets = {
    'Today': ['9/21'],
    'Past 3 Days': ['9/21', '9/20', '9/19'],
    'Past 5 Days': ['9/21', '9/20', '9/19', '9/18', '9/17'],
  };

  Map<String, List<double>> get barValuesSets {
    final today = DateTime.now().toString().split(' ')[0];
    final yesterday = DateTime.now().subtract(Duration(days: 1)).toString().split(' ')[0];
    final dayBeforeYesterday = DateTime.now().subtract(Duration(days: 2)).toString().split(' ')[0];
    final day3 = DateTime.now().subtract(Duration(days: 3)).toString().split(' ')[0];
    final day4 = DateTime.now().subtract(Duration(days: 4)).toString().split(' ')[0];
    debugPrint('Today: $today, Yesterday: $yesterday, Day Before Yesterday: $dayBeforeYesterday');
    List<Map<String, dynamic>> datas1 = SensorDataManager.getSensorDataLast30Seconds(10);
    List<Map<String, dynamic>> datas2 = SensorDataManager.getSensorDataLast30Seconds(20);
    List<Map<String, dynamic>> datas3 = SensorDataManager.getSensorDataLast30Seconds(30);
    List<Map<String, dynamic>> datas4 = SensorDataManager.getSensorDataLast30Seconds(40);
    List<Map<String, dynamic>> datas5 = SensorDataManager.getSensorDataLast30Seconds(50);
    return {
      'Today': [SensorDataManager.getAverageFrameScoreByDateDirect(datas1)],
      'Past 3 Days': [
        SensorDataManager.getAverageFrameScoreByDateDirect(datas1),
        SensorDataManager.getAverageFrameScoreByDateDirect(datas2),
        SensorDataManager.getAverageFrameScoreByDateDirect(datas3),
      ],
      'Past 5 Days': [
        SensorDataManager.getAverageFrameScoreByDateDirect(datas1),
        SensorDataManager.getAverageFrameScoreByDateDirect(datas2),
        SensorDataManager.getAverageFrameScoreByDateDirect(datas3),
        SensorDataManager.getAverageFrameScoreByDateDirect(datas4),
        SensorDataManager.getAverageFrameScoreByDateDirect(datas5),
      ], // 暫時保持靜態資料，因為需要更複雜的月份計算
    };
  }

  final Map<String, double> averageScores = {
    'Today': SensorDataManager.getAverageFrameScoreByDateDirect(SensorDataManager.getSensorDataLast30Seconds(10)),
    'Past 3 Days': SensorDataManager.getAverageFrameScoreByDateDirect(SensorDataManager.getSensorDataLast30Seconds(10) + SensorDataManager.getSensorDataLast30Seconds(20) + SensorDataManager.getSensorDataLast30Seconds(30)),
    'Past 5 Days': SensorDataManager.getAverageFrameScoreByDateDirect(SensorDataManager.getSensorDataLast30Seconds(10) + SensorDataManager.getSensorDataLast30Seconds(20) + SensorDataManager.getSensorDataLast30Seconds(30) + SensorDataManager.getSensorDataLast30Seconds(40) + SensorDataManager.getSensorDataLast30Seconds(50)),
  };

  int correct = 40;
  int incorrect = 50;

  

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> datas1 = SensorDataManager.getSensorDataLast30Seconds(10);
    List<Map<String, dynamic>> datas2 = SensorDataManager.getSensorDataLast30Seconds(20);
    List<Map<String, dynamic>> datas3 = SensorDataManager.getSensorDataLast30Seconds(30);
    List<Map<String, dynamic>> datas4 = SensorDataManager.getSensorDataLast30Seconds(40);
    List<Map<String, dynamic>> datas5 = SensorDataManager.getSensorDataLast30Seconds(50);
    Map<String, double> frameLevelStats;
    if(selectedOption == 'Today'){
      frameLevelStats = SensorDataManager.getFrameLevelStatsByDate(datas1);
    }
    else if(selectedOption == 'Past 3 Days'){
      List<Map<String, dynamic>> combinedDatas = [];
      combinedDatas.addAll(datas1);
      combinedDatas.addAll(datas2);
      combinedDatas.addAll(datas3);
      frameLevelStats = SensorDataManager.getFrameLevelStatsByDate(combinedDatas);
    }
    else{
      List<Map<String, dynamic>> combinedDatas = [];
      combinedDatas.addAll(datas1);
      combinedDatas.addAll(datas2);
      combinedDatas.addAll(datas3);
      combinedDatas.addAll(datas4);
      combinedDatas.addAll(datas5);
      frameLevelStats = SensorDataManager.getFrameLevelStatsByDate(combinedDatas);
    }

    if (frameLevelStats['A+'] == null) {
      frameLevelStats['A+'] = 0;
    } 
    if (frameLevelStats['A'] == null){
      frameLevelStats['A'] = 0;
    }
    if (frameLevelStats['B'] == null){
      frameLevelStats['B'] = 0;
    }
    if (frameLevelStats['C'] == null){
      frameLevelStats['C'] = 0;
    }
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
          //SizedBox(height: 5*scale),
          
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PieChartPage()));
              },
              child:Padding(
                padding: EdgeInsets.only(left: 38*scale, top: 15*scale),
                child: Text(
                  'Status Distribution',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 14*scale,
                    color: const Color(0xFFCDCCD3),
                  ),
                ),
              ),
            )
          ),
          SizedBox(height: 40,),
        
          PieChartGrades(
            grades: {
              'A+': frameLevelStats['A+'] ?? 0,
              'A': frameLevelStats['A'] ?? 0,
              'B': frameLevelStats['B'] ?? 0,
              'C': frameLevelStats['C'] ?? 0,
            },
            scale: 0.72
          ),
          
          SizedBox(height: 45,),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Report()
          )
          
          
        ],
      ),
    );
  }
}
