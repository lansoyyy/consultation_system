import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/models/model.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsTab extends StatefulWidget {
  @override
  State<AnalyticsTab> createState() => _AnalyticsTabState();
}

class _AnalyticsTabState extends State<AnalyticsTab> {
  Map<String, double> nulldatamap = {
    'Empty': 100,
  };

  late List<Concern> _concern = [];

  Map<String, double> getCategoryData() {
    Map<String, double> catMap = {};
    for (var item in _concern) {
      // print(item.mood);
      if (catMap.containsKey(item.concern) == false) {
        catMap[item.concern] = 1;
      } else {
        catMap.update(item.concern, (double v) => catMap[item.concern]! + 1);
        // test[item.category] = test[item.category]! + 1;
      }
      // print(catMap);
    }
    return catMap;
  }

  late List<int> catmapvalues = [];
  List<int> getYData() {
    Map<String, int> catMap = {};

    for (var item in _concern) {
      // print(item.mood);
      if (catMap.containsKey(item.concern) == false) {
        catMap[item.concern] = 1;
      } else {
        catMap.update(item.concern, (int v) => catMap[item.concern]! + 1);
      }
    }

    for (var item in catMap.values) {
      catmapvalues.add(item);
    }

    return catmapvalues;
  }

  final Stream<QuerySnapshot> dataStream =
      FirebaseFirestore.instance.collection('Concerns').snapshots();

  void getFromSnapShot(snapshot) {
    if (snapshot.docs.isNotEmpty) {
      _concern = [];
      for (int i = 0; i < snapshot.docs.length; i++) {
        var a = snapshot.docs[i];

        Concern concern = Concern.fromJson(a.data());
        _concern.add(concern);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NormalText(
                label: 'CONSULTATION ANALYSIS', fontSize: 24, color: primary),
            StreamBuilder<Object>(
                stream: dataStream,
                builder: (
                  context,
                  snapshot,
                ) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('something went wrong'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final data = snapshot.requireData;
                  getFromSnapShot(data);

                  int i = 0;

                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      legend: Legend(
                        isVisible: true,
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<Concern, String>>[
                        LineSeries<Concern, String>(
                          dataSource: _concern,
                          xValueMapper: (Concern concern, _) =>
                              concern.concern.isNotEmpty
                                  ? concern.concern
                                  : 'Empty Set',
                          yValueMapper: (Concern concern, _) =>
                              getYData()[i++].toString().isNotEmpty
                                  ? getYData()[i++]
                                  : 0,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                        ),
                      ],
                    ),
                  );
                }),
            const SizedBox(
              height: 40,
            ),
            StreamBuilder<Object>(
              stream: dataStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final data = snapshot.requireData;
                getFromSnapShot(data);
                return PieChart(
                  dataMap: getCategoryData().isEmpty
                      ? nulldatamap
                      : getCategoryData(),
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
                    showChartValuesInPercentage: true,
                    showChartValuesOutside: false,
                    decimalPlaces: 1,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    ));
  }
}
