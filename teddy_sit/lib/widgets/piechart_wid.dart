import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

class PieChartGrades extends StatelessWidget {
  final Map<String, double> grades; // 例如 {'A+': 10, 'A': 5, 'B': 3, 'C': 2}
  final double scale; // 新增比例參數

  const PieChartGrades({super.key, required this.grades, this.scale = 1.0}); // 預設 scale = 1

  @override
  Widget build(BuildContext context) {
    // 固定顏色對應
    final Map<String, Color> colorMap = {
      'A+': Color(0xFF8675FF),
      'A': Color(0xFF8277D3),
      'B': Color(0xFFCEC5FF),
      'C': Color(0xFF989FD1),
    };

    // 計算總和
    double total = grades.values.fold(0, (sum, value) => sum + value);

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 200 * scale,
            height: 200 * scale,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 40 * scale, // 圓心空白半徑
                sections: grades.entries.map((entry) {
                  final percent = total == 0 ? 0.0 : (entry.value / total * 100);
                  return PieChartSectionData(
                    value: entry.value,
                    color: colorMap[entry.key] ?? Colors.grey,
                    radius: 100 * scale, // 半徑
                    title: '${entry.key}\n${entry.value.toInt()} ${percent.toInt()}%',
                    titleStyle: GoogleFonts.inknutAntiqua(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14 * scale, // 字體大小
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                total.toInt().toString(),
                style: GoogleFonts.inknutAntiqua(
                  fontSize: 30 * scale,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
