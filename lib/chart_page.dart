import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kgr_1/status_page.dart';
import 'manual_page.dart';
import 'package:libserialport/libserialport.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

late TransferData data;
late var path;
double maxLability = 0.0;
double minLability = 0.0;

class _MyHomePageState extends State<MyHomePage> {
  late List<LiveData> _chartData;
  late List<LiveData> _chartData1;
  late List<LiveData> _chartMidPoint;
  late List<LiveData> _chartRelaxPoint;
  late List<LiveData> _chartActivationPoint;
  late ChartSeriesController _chartSeriesController;
  late ChartSeriesController _chartSeriesController1;
  late ChartSeriesController _chartMidPointController;
  late ChartSeriesController _chartRelaxPointController;
  late ChartSeriesController _chartActivationPointController;
  int counter = 0;

  bool midFlag = false;
  bool relaxationFlag = false;
  bool activationFlag = false;
  double sum = 0;
  int timeCounter = 0;
  double secSum = 0;
  double secMid = 0;
  int index = 0;
  List<double> secMidOldNew = [0, 0];
  int recCounter = 0;
  ValueNotifier<double> nanOrInfinity = ValueNotifier<double>(0);
  ValueNotifier<double> mid = ValueNotifier<double>(0);
  ValueNotifier<double> relax = ValueNotifier<double>(0);
  ValueNotifier<double> activation = ValueNotifier<double>(0);
  double secRelax = 0;
  double secActivation = 0;
  late Timer timer;
  late IOSink sink;

  void _localFile() async {
    final directory = await getDownloadsDirectory();
    path = directory?.path;
    var chartFile = File('$path/my-list.csv');
    sink = chartFile.openWrite();
    print(chartFile);
  }

  @override
  void initState() {
    _chartData = <LiveData>[];
    _chartData1 = <LiveData>[];
    _chartMidPoint = <LiveData>[];
    _chartRelaxPoint = <LiveData>[];
    _chartActivationPoint = <LiveData>[];
    _localFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> avaiblePorts = SerialPort.availablePorts;
    print("AvailablePorts: $avaiblePorts");
    print(selectedComPort);
    SerialPort port1 = SerialPort(selectedComPort);
    final configu = SerialPortConfig();
    configu.baudRate = 9600;
    configu.bits = 8;
    configu.parity = 0;
    port1.config = configu;
    SerialPortReader reader = SerialPortReader(port1, timeout: 10);
    try {
      port1.openRead();
    } on SerialPortError {
      //if (port1.isOpen) {
      port1.close();
      print('serial port error');
      //}
    }
    String cash = '';
    StreamController<double> testData = StreamController<double>();
    try {
      String mergedData = "";
      Stream<double> upcommingData = reader.stream.map((data) {
        cash = '$cash${String.fromCharCodes(data)}';
        if (cash.endsWith('\n')) {
          mergedData = cash;
          print('*${mergedData.substring(1, mergedData.length - 2)}*\n');
          cash = '';
          double k = 0;
          try {
            k = int.parse(mergedData.substring(1, mergedData.length - 3))
                .toDouble();
          } on FormatException {
            return -1;
          }
          return 1 / k * 10000;
        } else {
          return -1;
        }
      });

      /*upcommingData.*/ testData.stream.listen((data) {
        if (data != -1 && data >= 0) {
          sink.writeln("$timeCounter;$data");
          sum += data;
          counter++;
          if (midFlag != false) {
            mid.value = sum / counter;
          }
          if (relaxationFlag == true) {
            relax.value = ((1 - data / mid.value) * 100).isNegative
                ? 0
                : (1 - data / mid.value) * 100;
            secRelax = data;
          }
          if (activationFlag == true) {
            activation.value = ((data / secRelax - 1) * 100).isNegative
                ? 0
                : (data / secRelax - 1) * 100;
            secActivation = data;
          }
          secSum += data;
          recCounter++;
          secMid = secSum / recCounter;
          secMidOldNew[index] = secMid == 0 ? 10000 : secMid;
          if (index == 1) {
            index = -1;
          }
          index++;
        }
      });
    } on SerialPortError catch (err, _) {
      print(err);
    }
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 247, 254),
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
                                    child: ValueListenableBuilder<double>(
                                        valueListenable: mid.value.isInfinite
                                            ? nanOrInfinity
                                            : mid,
                                        builder: (BuildContext context,
                                            double value, Widget? child) {
                                          return Text(
                                            '${(value * 10).round().toDouble() / 10}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          );
                                        }),
                                  ),
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
                                    child: ValueListenableBuilder<double>(
                                        valueListenable: relax.value.isInfinite
                                            ? nanOrInfinity
                                            : relax,
                                        builder: (BuildContext context,
                                            double value, Widget? child) {
                                          return Text(
                                            '${((value * 10).round().toDouble() / 10).round()}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          );
                                        }),
                                  ),
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
                                width: 40,
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
                                    child: ValueListenableBuilder<double>(
                                        valueListenable:
                                            activation.value.isInfinite
                                                ? nanOrInfinity
                                                : activation,
                                        builder: (BuildContext context,
                                            double value, Widget? child) {
                                          return Text(
                                            '${((value * 10).round().toDouble() / 10).round()}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          );
                                        }),
                                  ),
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
                                width: 40,
                              )
                            ],
                          ),
                        ],
                      ),
                      Expanded(
                          child: SfCartesianChart(
                              axes: <ChartAxis>[
                            NumericAxis(
                                majorGridLines:
                                    const MajorGridLines(color: Colors.red),
                                isVisible: true)
                          ],
                              series: <ChartSeries<LiveData, int>>[
                            StackedLineSeries<LiveData, int>(
                              width: 4,
                              onRendererCreated:
                                  (ChartSeriesController controller) {
                                _chartSeriesController = controller;
                              },
                              dataSource: _chartData,
                              color: const Color(0xff1b87ae),
                              xValueMapper: (LiveData sales, _) => sales.time,
                              yValueMapper: (LiveData sales, _) => sales.mkSim,
                            ),
                            StackedLineSeries<LiveData, int>(
                              width: 2,
                              onRendererCreated:
                                  (ChartSeriesController controller) {
                                _chartSeriesController1 = controller;
                              },
                              dataSource: _chartData1,
                              color: const Color(0xff004764),
                              xValueMapper: (LiveData sales, _) => sales.time,
                              yValueMapper: (LiveData sales, _) =>
                                  sales.mkSimOld,
                            ),
                            ScatterSeries(
                                dataSource: _chartMidPoint,
                                onRendererCreated:
                                    (ChartSeriesController controller) {
                                  _chartMidPointController = controller;
                                },
                                color: const Color.fromARGB(255, 103, 164, 195),
                                markerSettings: const MarkerSettings(
                                    height: 20,
                                    width: 20,
                                    color: Color.fromARGB(255, 103, 164, 195)),
                                name: 'Brazil',
                                xValueMapper: (LiveData sales, _) =>
                                    sales.midTime,
                                yValueMapper: (LiveData sales, _) => sales.mid),
                            ScatterSeries(
                                dataSource: _chartRelaxPoint,
                                onRendererCreated:
                                    (ChartSeriesController controller) {
                                  _chartRelaxPointController = controller;
                                },
                                color: const Color.fromARGB(255, 103, 164, 195),
                                markerSettings: const MarkerSettings(
                                    height: 20,
                                    width: 20,
                                    color: Color.fromARGB(255, 103, 164, 195)),
                                name: 'Brazil',
                                xValueMapper: (LiveData sales, _) =>
                                    sales.relaxTime,
                                yValueMapper: (LiveData sales, _) =>
                                    sales.relax),
                            ScatterSeries(
                                dataSource: _chartActivationPoint,
                                onRendererCreated:
                                    (ChartSeriesController controller) {
                                  _chartActivationPointController = controller;
                                },
                                color: const Color.fromARGB(255, 103, 164, 195),
                                markerSettings: const MarkerSettings(
                                    height: 20,
                                    width: 20,
                                    color: Color.fromARGB(255, 103, 164, 195)),
                                name: 'Brazil',
                                xValueMapper: (LiveData sales, _) =>
                                    sales.activationTime,
                                yValueMapper: (LiveData sales, _) =>
                                    sales.activation),
                          ],
                              primaryXAxis: NumericAxis(
                                  majorGridLines:
                                      const MajorGridLines(width: 1),
                                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                                  interval: 50,
                                  axisLine: const AxisLine(width: 2),
                                  majorTickLines: const MajorTickLines(size: 1),
                                  title: AxisTitle(text: 'Время')),
                              primaryYAxis: NumericAxis(
                                  isInversed: false,
                                  interval: 1,
                                  majorGridLines:
                                      const MajorGridLines(width: 1),
                                  axisLine: const AxisLine(width: 2),
                                  majorTickLines: const MajorTickLines(size: 1),
                                  title: AxisTitle(text: 'МкСим')))),
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      //ToDo: Защита от дурака(late Timer timer), чтобы не нажимали далее, пока не нажмут старт
                      //reader.close();
                      //port1.close();
                      timer.cancel();
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
                  SizedBox(
                    height: 40,
                    width: 400,
                    child: ElevatedButton(
                        onPressed: () {
                          double value = 0;
                          double fvc = 0;
                          double testValue = 5.0;
                          timer = Timer.periodic(
                              const Duration(milliseconds: 200), (timer) {
                            if (timeCounter <= 1550) {
                              timeCounter++;
                              double doubleInRange(
                                      Random source, num start, num end) =>
                                  source.nextDouble() * (end - start) + start;
                              // if (timeCounter <= 300) {
                              //   testValue = 3;
                              // } else if (timeCounter > 300 &&
                              //     timeCounter <= 1200) {
                              //   testValue = 2;
                              // } else if (timeCounter > 1200 &&
                              //     timeCounter <= 1500) {
                              //   testValue = 4;
                              // }
                              if (testValue >= 10) {
                                testValue -= 1;
                              }
                              if (testValue <= 0.4) {
                                testValue += 0.5;
                              }
                              testValue += doubleInRange(Random(), -0.3, 0.3);
                              testData.sink.add(testValue);
                              //print(random);
                              _chartData.add(LiveData(timeCounter, 0, secMid, 0,
                                  0, 0, 0, 0, 0, 0, 0, 0, 0));
                              _chartSeriesController.updateDataSource(
                                addedDataIndex: _chartData.length - 1,
                              );
                              //if (timeCounter <= 300) {
                              if (!secMidOldNew[1].isNaN &&
                                  secMidOldNew[1] != 0 &&
                                  secMidOldNew[1].isFinite &&
                                  !secMidOldNew[0].isNaN &&
                                  secMidOldNew[0] != 0 &&
                                  secMidOldNew[0].isFinite) {
                                fvc = (10000 / secMidOldNew[1]) +
                                    (0.875 * fvc) -
                                    (10000 / secMidOldNew[0] * 1);
                              } else {
                                fvc = 0.01;
                              }
                              maxLability = value;
                              minLability = value;
                              value = value * (1 - 0.15) + fvc * 0.1;
                              value = value.isNegative ? 0 : value;
                              if (value >= maxLability) {
                                maxLability = value;
                              }
                              if (value <= minLability) {
                                minLability = value;
                              }
                              _chartData1.add(LiveData(timeCounter, value, 0, 0,
                                  0, 0, 0, 0, 0, 0, 0, 0, 0));
                              _chartSeriesController1.updateDataSource(
                                addedDataIndex: _chartData1.length - 1,
                              );
                              //}
                            }
                            recCounter = 0;
                            secSum = 0;
                            if (timeCounter == 300) {
                              print('ADD MID POINT');
                              midFlag = false;
                              relaxationFlag = true;
                              _chartMidPoint.clear();
                              _chartMidPoint.add(LiveData(0, 0, 0, 300,
                                  mid.value, 0, 0, 0, 0, 0, 0, 0, 0));
                              _chartMidPointController.updateDataSource(
                                addedDataIndex: _chartMidPoint.length - 1,
                              );
                            }
                            if (timeCounter == 1200) {
                              relaxationFlag = false;
                              activationFlag = true;
                              _chartRelaxPoint.clear();
                              _chartRelaxPoint.add(LiveData(0, 0, 0, 0, 0, 0, 0,
                                  1200, 0, 0, 0, secRelax, 0));
                              _chartRelaxPointController.updateDataSource(
                                addedDataIndex: _chartRelaxPoint.length - 1,
                              );
                            }
                            if (timeCounter == 1500) {
                              activationFlag = false;
                              _chartActivationPoint.clear();
                              _chartActivationPoint.add(LiveData(0, 0, 0, 0, 0,
                                  0, 0, 0, 0, 1500, 0, 0, secActivation));
                              _chartActivationPointController.updateDataSource(
                                addedDataIndex:
                                    _chartActivationPoint.length - 1,
                              );
                            }
                          });
                          midFlag = true;
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 195, 217, 230))),
                        child: const Text('СТАРТ',
                            style: TextStyle(color: Color(0xff000000)))),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero)),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 195, 217, 230))),
                    onPressed: () {
                      data = TransferData(
                          mid.value,
                          _chartData,
                          _chartData1,
                          _chartMidPoint,
                          _chartRelaxPoint,
                          _chartActivationPoint);
                      //ToDo: Защита от дурака(late Timer timer), чтобы не нажимали далее, пока не нажмут старт
                      reader.close();
                      port1.close();
                      timer.cancel();
                      Navigator.of(context).pushNamed('/statusPage',
                          arguments: ScreenArguments('САМООЦЕНКА РЕЛАКСАЦИИ'));
                    },
                    child: const Text('ДАЛЕЕ',
                        style: TextStyle(color: Color(0xff000000))),
                  )
                ],
              )
            ],
          ),
        ));
  }

// List<LiveData> getChartMidPoint() {
//   final List<LiveData> chartPoints = [
//   ];
//   return chartPoints;
// }
}

class ChartStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readChart() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeChart(int counter) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$counter');
  }
}

class TransferData {
  TransferData(this.mid, this.chartData, this.chartData1, this.chartMidPoint,
      this.chartRelaxPoint, this.chartActivationPoint);

  final double mid;
  final List<LiveData> chartData;
  final List<LiveData> chartData1;
  final List<LiveData> chartMidPoint;
  final List<LiveData> chartRelaxPoint;
  final List<LiveData> chartActivationPoint;
}

class LiveData {
  LiveData(
      this.time,
      this.mkSimOld,
      this.mkSim,
      this.midTime,
      this.mid,
      this.personMidTime,
      this.personMid,
      this.relaxTime,
      this.personRelax,
      this.activationTime,
      this.personActivation,
      this.relax,
      this.activation);

  final int time;
  final double mkSimOld;
  final double mkSim;
  final int midTime;
  final double mid;
  final int personMidTime;
  final double personMid;
  final int relaxTime;
  final double personRelax;
  final int activationTime;
  final double personActivation;
  final double activation;
  final double relax;
}
