import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kgr_1/final_chart_page.dart';
import 'package:kgr_1/status_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'chart_page.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late List<BarChartData> data1;
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    double personMid = PersonMidPoint.personMidPoint;
    double personActivation = PersonActivationPoint.personActivationPoint;
    double personRelax = PersonRelaxPoint.personRelaxPoint;
    double mid = data.chartMidPoint[0].mid;
    double relax = data.chartRelaxPoint[0].relax < mid ? data.chartRelaxPoint[0].relax : 0;
    double activation = data.chartActivationPoint[0].activation > data.chartRelaxPoint[0].relax ?  data.chartActivationPoint[0].activation : 0;
    double relaxAccuracy = (differ.relax - personRelax).isNegative
        ? -(differ.relax - personRelax)
        : (differ.relax - personRelax);
    double activationAccuracy =
        (differ.activation - personActivation).isNegative
            ? -(differ.activation - personActivation)
            : (differ.activation - personActivation);
    data1 = [
      BarChartData('Релаксация', relax, 0, 0, 0, 0, 0),
      BarChartData('Релаксация', 0, personRelax, 0, 0, 0, 0),
      BarChartData('Активация', 0, 0, activation, 0, 0, 0),
      BarChartData('Активация', 0, 0, 0, personActivation, 0, 0),
      BarChartData('Фон', 0, 0, 0, 0, mid, 0),
      BarChartData('Фон', 0, 0, 0, 0, 0, personMid),
    ];
    _tooltipBehavior = TooltipBehavior(enable: true);
    print(
        "mid: $mid personMid: $personMid \n activation: $activation personActivation: $personActivation \n relax: $relax personRelax: $personRelax");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSaving = false;
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
              const EdgeInsets.only(left: 150, top: 50, right: 250, bottom: 80),
          child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: const Text(
                    'РЕЗУЛЬТАТЫ ТЕСТИРОВАНИЯ НАВЫКА ПСИХИЧЕСКОЙ САМОРЕГУЛЯЦИИ',
                    style: TextStyle(
                        fontSize: 28,
                        color: Color(0xff2389b1),
                        fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(
                            isInversed: true,
                          ),
                          primaryYAxis: NumericAxis(
                              minimum: 0,
                              maximum: 10,
                              interval: 1,
                              labelStyle:
                                  const TextStyle(color: Colors.black12)),
                          tooltipBehavior: _tooltipBehavior,
                          legend: Legend(isVisible: true),
                          series: <ChartSeries>[
                            StackedBarSeries<BarChartData, String>(
                                dataSource: data1,
                                xValueMapper: (BarChartData data, _) =>
                                    data.name,
                                yValueMapper: (BarChartData data, _) =>
                                    data.relax,
                                name: "Апп. релакс"),
                            StackedBarSeries<BarChartData, String>(
                                dataSource: data1,
                                xValueMapper: (BarChartData data, _) =>
                                    data.name,
                                yValueMapper: (BarChartData data, _) =>
                                    data.personRelax,
                                name: "Польз. релакс"),
                            StackedBarSeries<BarChartData, String>(
                                dataSource: data1,
                                xValueMapper: (BarChartData data, _) =>
                                    data.name,
                                yValueMapper: (BarChartData data, _) =>
                                    data.activation,
                                name: "Апп. активация"),
                            StackedBarSeries<BarChartData, String>(
                                dataSource: data1,
                                xValueMapper: (BarChartData data, _) =>
                                    data.name,
                                yValueMapper: (BarChartData data, _) =>
                                    data.personActivation,
                                name: "Польз. активация"),
                            StackedBarSeries<BarChartData, String>(
                                dataSource: data1,
                                xValueMapper: (BarChartData data, _) =>
                                    data.name,
                                yValueMapper: (BarChartData data, _) =>
                                    data.mid,
                                name: "Апп. фон"),
                            StackedBarSeries<BarChartData, String>(
                                dataSource: data1,
                                xValueMapper: (BarChartData data, _) =>
                                    data.name,
                                yValueMapper: (BarChartData data, _) =>
                                    data.personMid,
                                name: "Польз. фон"),
                          ]),
                    ),
                    const Expanded(child: Text("ТЕКСТ ОБОБЩЕНИЯ РЕЗУЛЬТАТОВ"))
                  ],
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 120,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero)),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 195, 217, 230))),
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                                '/statusPage',
                                arguments: ScreenArguments(
                                    'САМООЦЕНКА ТЕКУЩЕГО СОСТОЯНИЯ ТЕСТИРУЕМОГО ПЕРЕД ТЕСТИРОВАНИЕМ'));
                          },
                          child: const Text('Вперед')),
                    ),
                    SizedBox(
                      height: 40,
                      width: 400,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero)),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 213, 203, 37))),
                          onPressed: () {
                            isSaving = true;
                          },
                          child: const Text('Сохранить')),
                    ),
                    SizedBox(
                      height: 40,
                      width: 120,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero)),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 195, 217, 230))),
                          onPressed: () {
                            if (isSaving == false) {
                              File(path).delete();
                            }
                            exit(0);
                          },
                          child: const Text('Выйти')),
                    ),
                  ],
                ))
              ])),
        ));
  }
}

class BarChartData {
  BarChartData(this.name, this.relax, this.personRelax, this.activation,
      this.personActivation, this.mid, this.personMid);

  final String name;
  final double relax;
  final double personRelax;
  final double activation;
  final double personActivation;
  final double mid;
  final double personMid;
}
