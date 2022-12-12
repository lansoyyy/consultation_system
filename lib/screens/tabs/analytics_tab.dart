import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/models/model.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../widgets/appabr_widget.dart';

class AnalyticsTab extends StatefulWidget {
  PageController page = PageController();

  AnalyticsTab({required this.page});
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

  int total1 = 0;
  getData1() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Concerns')
        .where('concern', isEqualTo: 'Grades');

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          total1 = querySnapshot.size;
        }
      });
    }
  }

  int total2 = 0;
  getData2() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Concerns')
        .where('concern', isEqualTo: 'Requirements');

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          total2 = querySnapshot.size;
        }
      });
    }
  }

  int total3 = 0;
  getData3() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Concerns')
        .where('concern', isEqualTo: 'Attendance');

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          total3 = querySnapshot.size;
        }
      });
    }
  }

  int total4 = 0;
  getData4() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Concerns')
        .where('concern', isEqualTo: 'Others');

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          total4 = querySnapshot.size;
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData1();
    getData2();
    getData3();
    getData4();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWidget(widget.page),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NormalText(
                    label: 'CONSULTATION ANALYSIS',
                    fontSize: 24,
                    color: primary),
                StreamBuilder<Object>(
                    stream: dataStream,
                    builder: (
                      context,
                      snapshot,
                    ) {
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('something went wrong'));
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
                          series: <ChartSeries>[
                            LineSeries<ChartData, String>(
                                dataSource: [
                                  // Bind data source
                                  ChartData('Grades', total1.toDouble()),
                                  ChartData('Requirements', total2.toDouble()),
                                  ChartData('Attendance', total3.toDouble()),
                                  ChartData('Others', total4.toDouble()),
                                ],
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y)
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

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
