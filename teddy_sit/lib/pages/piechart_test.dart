import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/home.dart';
import '../widgets/piechart_wid.dart';
//import '../widgets/stretch_wid.dart';

double scale = 2340/2400;



class PieChartPage extends StatefulWidget {
  const PieChartPage({super.key});
  

  @override
  State<PieChartPage> createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  
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
      body:
      PieChartGrades(
        grades: {
          'A+': 10,
          'A': 5,
          'B': 3,
          'C': 2,
        },
      ),
 
    );
  }
}
