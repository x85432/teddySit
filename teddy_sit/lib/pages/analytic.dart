import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:teddy_sit/pages/piechart_test.dart';
import '../widgets/home.dart';
import '../widgets/analytic_wid.dart';
import '../widgets/piechart_wid.dart';
import '../services/sensor_data_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import '../widgets/stretch_wid.dart';

double scale = 2340/2400;

// 下拉選單項目
const List<String> dropdownOptions = ['Today', 'Past 3 Days', 'Past 5 Days'];

class AnalyticPage extends StatefulWidget {
  final String lastUpdate;
  const AnalyticPage({super.key, required this.lastUpdate});
  
  
  @override
  State<AnalyticPage> createState() => _AnalyticPageState();
}

class _AnalyticPageState extends State<AnalyticPage> {
  String selectedOption = dropdownOptions.first;
  late String lastUpdateString;

  // 用來存 Firestore 撈回來的 5 段資料
  List<List<Map<String, dynamic>>> chunks = [[], [], [], [], []];
  @override

  void initState() {
    super.initState();
    lastUpdateString = widget.lastUpdate; // 取 yyyy-MM-dd

    _loadData(); // 撈資料
  }

  Future<void> _loadData() async {
    // 一次撈 150 秒
    final allData = await SensorDataManager.getSensorDataBySecond(lastUpdateString, 150);
    final lastUpdateTime = DateTime.parse(lastUpdateString);

    // 切成 5 段，每段 30 秒
    List<List<Map<String, dynamic>>> tmp = [];
    for (int i = 0; i < 5; i++) {
      final start = i * 30;
      final end = (i + 1) * 30;

      final chunk = allData.where((d) {
        final time = DateTime.parse(d['timestamp']);
        final diff = lastUpdateTime.difference(time).inSeconds;
        return diff >= start && diff < end;
      }).toList();

      tmp.add(chunk);
    }

    setState(() {
      chunks = tmp;
    });
  }

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

  // 柱狀圖x軸顯示的字
  final Map<String, List<String>> labelsSets = {
    'Today': ['9/21'],
    'Past 3 Days': ['9/21', '9/20', '9/19'],
    'Past 5 Days': ['9/21', '9/20', '9/19', '9/18', '9/17'],
  };

  Map<String, List<double>> get barValuesSets {
    return {
      'Today': [
        SensorDataManager.getAverageFrameScoreByDateDirect(chunks[0]),
      ],
      'Past 3 Days': [
        for (int i = 0; i < 3; i++)
          SensorDataManager.getAverageFrameScoreByDateDirect(chunks[i]),
      ],
      'Past 5 Days': [
        for (int i = 0; i < 5; i++)
          SensorDataManager.getAverageFrameScoreByDateDirect(chunks[i]),
      ],
    };
  }

  Map<String, double> get averageScores {
    return {
      'Today': chunks[0].isEmpty
          ? 0
          : SensorDataManager.getAverageFrameScoreByDateDirect(chunks[0]),
      'Past 3 Days': chunks.take(3).expand((e) => e).isEmpty
          ? 0
          : SensorDataManager.getAverageFrameScoreByDateDirect(
              chunks.take(3).expand((e) => e).toList()),
      'Past 5 Days': chunks.expand((e) => e).isEmpty
          ? 0
          : SensorDataManager.getAverageFrameScoreByDateDirect(
              chunks.expand((e) => e).toList()),
    };
  }

  int correct = 40;
  int incorrect = 50;

  

  @override
  Widget build(BuildContext context) {
    // 如果資料還沒載入，顯示 loading
    if (chunks.every((c) => c.isEmpty)) {
      return const Center(child: CircularProgressIndicator());
    }

    Map<String, double> frameLevelStats;
    if(selectedOption == 'Today'){
      frameLevelStats = SensorDataManager.getFrameLevelStatsByDate(chunks[0]);
    }
    else if(selectedOption == 'Past 3 Days'){
      frameLevelStats = SensorDataManager.getFrameLevelStatsByDate(
        chunks.take(3).expand((e) => e).toList(),
      );
    }
    else{
      frameLevelStats = SensorDataManager.getFrameLevelStatsByDate(
        chunks.expand((e) => e).toList(),
      );
    }

    // 確保 key 存在
    for (var grade in ['A+', 'A', 'B', 'C']) {
      frameLevelStats.putIfAbsent(grade, () => 0);
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
