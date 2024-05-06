import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:kgr_1/status_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:path_provider/path_provider.dart';

import 'chart_page.dart';

late Differ differ;

class FinalChartPage extends StatefulWidget {
  const FinalChartPage({Key? key}) : super(key: key);

  @override
  State<FinalChartPage> createState() => _FinalChartPageState();
}

var relax = 0;
var activation = 0;
var newMid = 0;

class _FinalChartPageState extends State<FinalChartPage> {
  List<LiveData> personMidPoint = [];

  List<LiveData> personRelaxPoint = [];
  List<LiveData> personActivationPoint = [];
  double personMid = PersonMidPoint.personMidPoint;
  double personRelax = PersonRelaxPoint.personRelaxPoint;
  double personActivation = PersonActivationPoint.personActivationPoint;

  double mid = data.mid;
  late GlobalKey<SfCartesianChartState> _cartesianChartKey;
  double concentration = 1.0;

  double calculateMeanDerivative(List<LiveData> data) {
    double meanDerivative = 0.0;
    for (int i = 1; i < data.length - 1; i++) {
      final int dx = data[i + 1].time - data[i].time;
      final double dy = (data[i + 1].mkSim - data[i].mkSim).abs();
      meanDerivative += (dy / dx) / (i + 1);
    }
    return meanDerivative;
  }

  @override
  void initState() {
    relax = (1 - data.chartRelaxPoint[0].relax / data.mid).isNegative
        ? 0
        : ((1 - data.chartRelaxPoint[0].relax / data.mid) * 100).round();
    activation = (data.chartActivationPoint[0].activation /
                    data.chartRelaxPoint[0].relax -
                1)
            .isNegative
        ? 0
        : ((data.chartActivationPoint[0].activation /
                        data.chartRelaxPoint[0].relax -
                    1) *
                100)
            .round();
    print(calculateMeanDerivative(data.chartData));
    concentration -= calculateMeanDerivative(data.chartData) * 1.1;
    _cartesianChartKey = GlobalKey();
    super.initState();
  }

  Future<void> _exportChartAsImage() async {
    final ui.Image data =
        await _cartesianChartKey.currentState!.toImage(pixelRatio: 3.0);
    final ByteData? bytes =
        await data.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageBytes =
        bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    final directory = await getDownloadsDirectory();
    path = directory?.path;
    final file = File('$path/my-chart.png');
    file.writeAsBytes(imageBytes);
  }

  @override
  Widget build(BuildContext context) {
    if (personMid == 1) {
      personMid = 0.84;
    } else if (personMid == 2) {
      personMid = 1.68;
    } else if (personMid == 3) {
      personMid = 2.50;
    } else if (personMid == 4) {
      personMid = 2.60;
    } else if (personMid == 5) {
      personMid = 3.2;
    } else if (personMid == 6) {
      personMid = 3.8;
    } else if (personMid == 7) {
      personMid = 4.90;
    } else if (personMid == 8) {
      personMid = 5;
    } else if (personMid == 9) {
      personMid = 5.3;
    } else if (personMid == 10) {
      personMid = 5.5;
    }

    if (personRelax == 0) {
      personRelax == 0;
    }
    if (personRelax == 1) {
      personRelax = (1 - 0.06) * mid;
    } else if (personRelax == 2) {
      personRelax = (1 - 0.12) * mid;
    } else if (personRelax == 3) {
      personRelax = (1 - 0.19) * mid;
    } else if (personRelax == 4) {
      personRelax = (1 - 0.2625) * mid;
    } else if (personRelax == 5) {
      personRelax = (1 - 0.335) * mid;
    } else if (personRelax == 6) {
      personRelax = (1 - 0.4075) * mid;
    } else if (personRelax == 7) {
      personRelax = (1 - 0.49) * mid;
    } else if (personRelax == 8) {
      personRelax = (1 - 0.5) * mid;
    } else if (personRelax == 9) {
      personRelax = (1 - 0.57) * mid;
    } else if (personRelax == 10) {
      personRelax = (1 - 0.64) * mid;
    }
    double _relax = data.chartRelaxPoint[0].relax;
    if (personActivation == 1) {
      personActivation = 1.06 * _relax;
    } else if (personActivation == 2) {
      personActivation = 1.12 * _relax;
    } else if (personActivation == 3) {
      personActivation = 1.20 * _relax;
    } else if (personActivation == 4) {
      personActivation = 1.24 * _relax;
    } else if (personActivation == 5) {
      personActivation = 1.28 * _relax;
    } else if (personActivation == 6) {
      personActivation = 1.32 * _relax;
    } else if (personActivation == 7) {
      personActivation = 1.36 * _relax;
    } else if (personActivation == 8) {
      personActivation = 1.37 * _relax;
    } else if (personActivation == 9) {
      personActivation = 1.42 * _relax;
    } else if (personActivation == 10) {
      personActivation = 1.50 * _relax;
    }
    personRelaxPoint = [
      LiveData(0, 0, 0, 0, 0, 0, 0, 600, personRelax, 0, 0, 0, 0)
    ];
    personActivationPoint = [
      LiveData(0, 0, 0, 0, 0, 0, 0, 0, 0, 900, personActivation, 0, 0)
    ];
    List<LiveData> personMidPoint = [
      LiveData(0, 0, 0, 0, 0, 300, personMid, 0, 0, 0, 0, 0, 0)
    ];

    if (relax == 0) {
      relax = 0;
    } else if (relax >= 1 && relax <= 10) {
      relax = 2;
    } else if (relax >= 11 && relax <= 19) {
      relax = 3;
    } else if (relax >= 20 && relax <= 27) {
      relax = 4;
    } else if (relax >= 28 && relax <= 35) {
      relax = 5;
    } else if (relax >= 36 && relax <= 43) {
      relax = 6;
    } else if (relax >= 44 && relax <= 49) {
      relax = 7;
    } else if (relax >= 50 && relax <= 60) {
      relax = 8;
    } else if (relax >= 61 && relax <= 70) {
      relax = 9;
    } else if (relax >= 71) {
      relax = 10;
    }
    if (activation >= 0 && activation <= 6) {
      activation = 1;
    } else if (activation >= 7 && activation <= 13) {
      activation = 2;
    } else if (activation >= 14 && activation <= 20) {
      activation = 3;
    } else if (activation >= 21 && activation <= 25) {
      activation = 4;
    } else if (activation >= 25 && activation <= 29) {
      activation = 5;
    } else if (activation >= 29 && activation <= 33) {
      activation = 6;
    } else if (activation >= 33 && activation <= 36) {
      activation = 7;
    } else if (activation >= 37 && activation <= 47) {
      activation = 8;
    } else if (activation >= 48 && activation <= 58) {
      activation = 9;
    } else if (activation >= 58) {
      activation = 10;
    }
    if (mid >= 0.0 && mid <= 1.0) {
      newMid = 1;
    } else if (mid > 1.0 && mid <= 1.8) {
      newMid = 2;
    } else if (mid > 1.8 && mid <= 2.5) {
      newMid = 3;
    } else if (mid > 2.5 && mid <= 3.0) {
      newMid = 4;
    } else if (mid > 3.0 && mid <= 3.6) {
      newMid = 5;
    } else if (mid > 3.6 && mid <= 4.5) {
      newMid = 6;
    } else if (mid > 4.5 && mid <= 4.9) {
      newMid = 7;
    } else if (mid > 5 && mid <= 5.7) {
      newMid = 8;
    } else if (mid > 5.7 && mid <= 6.1) {
      newMid = 9;
    } else if (mid > 6.1) {
      newMid = 10;
    }

    differ = Differ(relax, activation, newMid);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 233, 247, 229),
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 246, 246, 246),
            shape:
                const Border(bottom: BorderSide(color: Colors.grey, width: 2)),
            toolbarHeight: 150,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/variant_B_icon.png',
                  scale: 0.9,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Expanded(
                    child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text('Вариант Б',
                            style: TextStyle(
                                fontSize: 24,
                                color: Color(0xff2389b1),
                                fontWeight: FontWeight.w900)),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                            'Экспертная информационно-аналитическая система психологического сопровождения спортсменов'),
                      )
                    ],
                  ),
                )),
                Image.asset(
                  'assets/images/niifk_logo.png',
                  scale: 0.9,
                ),
              ],
            )),
        body: Container(
          alignment: Alignment.center,
          padding:
              const EdgeInsets.only(left: 50, top: 70, right: 50, bottom: 80),
          child: Column(
            children: [
              Expanded(
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Row(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'ФОН',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 110,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 90,
                                child: Container(
                                  color:
                                      const Color.fromARGB(255, 104, 163, 193),
                                  child: Center(
                                      child: Text(
                                    '${(data.chartMidPoint[0].mid * 10).round().toDouble() / 10}',
                                    style: const TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('МкСим',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 104, 163, 193),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14))
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Row(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'РЕЛАКСАЦИЯ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 90,
                                child: Container(
                                  color:
                                      const Color.fromARGB(255, 104, 163, 193),
                                  child: Center(
                                      child: Text(
                                    '$relax',
                                    style: const TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Баллов',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 104, 163, 193),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14)),
                              const SizedBox(
                                width: 0,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Row(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'АКТИВАЦИЯ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 45,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 90,
                                child: Container(
                                  color:
                                      const Color.fromARGB(255, 104, 163, 193),
                                  child: Center(
                                      child: Text(
                                    '$activation',
                                    style: const TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('Баллов',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 104, 163, 193),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14)),
                              const SizedBox(
                                width: 0,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Row(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'КОНЦЕНТРАЦИЯ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 45,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 90,
                                child: Container(
                                  color:
                                      const Color.fromARGB(255, 104, 163, 193),
                                  child: Center(
                                      child: Text(
                                    '${(concentration * 100).toInt()}',
                                    style: const TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text('%',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 104, 163, 193),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14)),
                              const SizedBox(
                                width: 0,
                              )
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                          child: SfCartesianChart(
                              key: _cartesianChartKey,
                              axes: <ChartAxis>[
                                NumericAxis(
                                    majorGridLines:
                                        const MajorGridLines(color: Colors.red),
                                    isVisible: true)
                              ],
                              series: <ChartSeries<LiveData, int>>[
                                StackedLineSeries<LiveData, int>(
                                  width: 4,
                                  dataSource: data.chartData,
                                  color: const Color.fromRGBO(192, 108, 132, 1),
                                  xValueMapper: (LiveData sales, _) =>
                                      sales.time,
                                  yValueMapper: (LiveData sales, _) =>
                                      sales.mkSim,
                                ),
                                StackedLineSeries<LiveData, int>(
                                  width: 2,
                                  dataSource: data.chartData1,
                                  color: const Color.fromRGBO(192, 108, 132, 1),
                                  xValueMapper: (LiveData sales, _) =>
                                      sales.time,
                                  yValueMapper: (LiveData sales, _) =>
                                      sales.mkSimOld,
                                ),
                                ScatterSeries(
                                    dataSource: data.chartMidPoint,
                                    color: const Color.fromARGB(
                                        255, 103, 164, 195),
                                    markerSettings: const MarkerSettings(
                                        height: 20,
                                        width: 20,
                                        color:
                                            Color.fromARGB(255, 103, 164, 195)),
                                    name: 'Brazil',
                                    xValueMapper: (LiveData sales, _) =>
                                        sales.midTime,
                                    yValueMapper: (LiveData sales, _) =>
                                        sales.mid),
                                ScatterSeries(
                                    dataSource: data.chartRelaxPoint,
                                    color: const Color.fromARGB(
                                        255, 103, 164, 195),
                                    markerSettings: const MarkerSettings(
                                        height: 20,
                                        width: 20,
                                        color:
                                            Color.fromARGB(255, 103, 164, 195)),
                                    name: 'Brazil',
                                    xValueMapper: (LiveData sales, _) =>
                                        sales.relaxTime,
                                    yValueMapper: (LiveData sales, _) =>
                                        sales.relax),
                                ScatterSeries(
                                    dataSource: data.chartActivationPoint,
                                    color: const Color.fromARGB(
                                        255, 103, 164, 195),
                                    markerSettings: const MarkerSettings(
                                        height: 20,
                                        width: 20,
                                        color:
                                            Color.fromARGB(255, 103, 164, 195)),
                                    name: 'Brazil',
                                    xValueMapper: (LiveData sales, _) =>
                                        sales.activationTime,
                                    yValueMapper: (LiveData sales, _) =>
                                        sales.activation),
                                ScatterSeries(
                                    dataSource: personMidPoint,
                                    color:
                                        const Color.fromARGB(255, 242, 151, 0),
                                    markerSettings: const MarkerSettings(
                                        height: 20,
                                        width: 20,
                                        shape: DataMarkerType.invertedTriangle,
                                        color:
                                            Color.fromARGB(255, 242, 151, 0)),
                                    name: 'Brazil',
                                    xValueMapper: (LiveData sales, _) =>
                                        sales.personMidTime,
                                    yValueMapper: (LiveData sales, _) =>
                                        sales.personMid),
                                ScatterSeries(
                                    dataSource: personRelaxPoint,
                                    color:
                                        const Color.fromARGB(255, 93, 195, 101),
                                    markerSettings: const MarkerSettings(
                                        height: 20,
                                        width: 20,
                                        shape: DataMarkerType.invertedTriangle,
                                        color:
                                            Color.fromARGB(255, 93, 195, 101)),
                                    name: 'Brazil',
                                    xValueMapper: (LiveData sales, _) =>
                                        sales.relaxTime,
                                    yValueMapper: (LiveData sales, _) =>
                                        sales.personRelax),
                                ScatterSeries(
                                    dataSource: personActivationPoint,
                                    color:
                                        const Color.fromARGB(255, 193, 14, 34),
                                    markerSettings: const MarkerSettings(
                                        height: 20,
                                        width: 20,
                                        shape: DataMarkerType.invertedTriangle,
                                        color:
                                            Color.fromARGB(255, 193, 14, 34)),
                                    name: 'Brazil',
                                    xValueMapper: (LiveData sales, _) =>
                                        sales.activationTime,
                                    yValueMapper: (LiveData sales, _) =>
                                        sales.personActivation),
                              ],
                              primaryXAxis: NumericAxis(
                                  majorGridLines:
                                      const MajorGridLines(width: 1),
                                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                                  interval: 50,
                                  axisLine: const AxisLine(width: 1),
                                  majorTickLines: const MajorTickLines(size: 1),
                                  title: AxisTitle(text: 'Время')),
                              primaryYAxis: NumericAxis(
                                  isInversed: false,
                                  majorGridLines:
                                      const MajorGridLines(width: 1),
                                  axisLine: const AxisLine(width: 1),
                                  majorTickLines: const MajorTickLines(size: 1),
                                  title: AxisTitle(text: 'МкСим')))),
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/statusPage',
                          arguments:
                              ScreenArguments('Самооценка текущего состояния'));
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero)),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 195, 217, 230))),
                    child: const Text(
                      'НАЗАД',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _exportChartAsImage();
                      Navigator.of(context).pushNamed('/reviewPage');
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero)),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 195, 217, 230))),
                    child: const Text(
                      'ДАЛЕЕ',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class PersonMidPoint {
  static double personMidPoint = 0;
}

class PersonRelaxPoint {
  static double personRelaxPoint = 0;
}

class PersonActivationPoint {
  static double personActivationPoint = 0;
}

class Differ {
  Differ(this.relax, this.activation, this.mid);

  int relax = 0;
  int activation = 0;
  int mid = 0;
}
// class RelaxPoint {
//   static double relaxPoint = 0;
// }
//
// class ActivationPoint {
//   static double activationPoint = 0;
// }
