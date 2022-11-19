import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsTab extends StatelessWidget {
  List<SalesData> data = [
    SalesData('Grades', 35),
    SalesData('Requirements', 28),
    SalesData('Attendance', 34),
    SalesData('Instructional Materials', 32),
    SalesData('Others', 40)
  ];

  Map<String, double> dataMap = {
    "Grades": 5,
    "Requirements": 3,
    "Attendance": 2,
    "Instructional Materials": 2,
    "Others": 2,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NormalText(
              label: 'CONSULTATION ANALYSIS', fontSize: 24, color: primary),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              legend: Legend(
                isVisible: true,
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                  dataSource: data,
                  xValueMapper: (SalesData sales, _) => sales.month,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          PieChart(
            dataMap: dataMap,
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 6.2,
            colorList: const [Colors.blue, Colors.red, Colors.green],
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,

            legendOptions: const LegendOptions(
              showLegendsInRow: false,
              showLegends: true,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
            // gradientList: ---To add gradient colors---
            // emptyColorGradient: ---Empty Color gradient---
          )
        ],
      ),
    ));
  }
}

class SalesData {
  final String month;
  final double sales;

  SalesData(this.month, this.sales);
}
