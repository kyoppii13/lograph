import 'package:flutter/material.dart';
import 'package:lograph/screens/log_detail.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GraphItem extends StatelessWidget {
  GraphItem({this.date, this.value, this.category, this.icon});

  final DateTime date;
  final String value;
  final String category;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    var formatter = DateFormat('y/MM/dd HH:mm');
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Container(
        // decoration: BoxDecoration(
        //   borderRadius: const BorderRadius.all(Radius.circular(2)),
        //   gradient: LinearGradient(
        //     colors: const [
        //       Colors.blue,
        //       Colors.blueGrey,
        //     ],
        //     begin: Alignment.bottomCenter,
        //     end: Alignment.topCenter,
        //   ),
        // ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(MdiIcons.armFlexOutline),
                Text(
                  category,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
                padding: EdgeInsets.only(right: 16, left: 6),
                child: LineChart(sampleData1()))
          ],
        ),
      ),
    );
  }
}

LineChartData sampleData1() {
  return LineChartData(
    lineTouchData: LineTouchData(
      touchTooltipData: LineTouchTooltipData(
        tooltipBgColor: Colors.grey.withOpacity(0.3),
      ),
      touchCallback: (LineTouchResponse touchResponse) {},
      handleBuiltInTouches: true,
    ),
    gridData: FlGridData(
      show: false,
    ),
    titlesData: FlTitlesData(
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        textStyle: const TextStyle(
          color: Color(0xff72719b),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        margin: 10,
        getTitles: (value) {
          switch (value.toInt()) {
            case 2:
              return '08/20';
            case 7:
              return '08/21';
            case 12:
              return '08/22';
          }
          return '';
        },
      ),
      leftTitles: SideTitles(
        showTitles: true,
        textStyle: const TextStyle(
          color: Color(0xff75729e),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 30:
              return '30kg';
            case 40:
              return '40kg';
            case 50:
              return '50kg';
            case 60:
              return '60kg';
          }
          return '';
        },
        margin: 8,
        reservedSize: 30,
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: const Border(
        bottom: BorderSide(
          color: Color(0xff4e4965),
          width: 4,
        ),
        left: BorderSide(
          color: Colors.transparent,
        ),
        right: BorderSide(
          color: Colors.transparent,
        ),
        top: BorderSide(
          color: Colors.transparent,
        ),
      ),
    ),
    minX: 0,
    maxX: 14,
    maxY: 60,
    minY: 20,
    lineBarsData: linesBarData1(),
  );
}

List<LineChartBarData> linesBarData1() {
  final LineChartBarData lineChartBarData3 = LineChartBarData(
    spots: [
      FlSpot(1, 50),
      FlSpot(3, 54),
      FlSpot(6, 52),
      FlSpot(10, 53),
      FlSpot(13, 55),
    ],
    isCurved: false,
    colors: const [Colors.blue],
    barWidth: 3,
    isStrokeCapRound: true,
    dotData: FlDotData(show: true),
    belowBarData: BarAreaData(
      show: false,
    ),
  );
  return [
    lineChartBarData3,
  ];
}
