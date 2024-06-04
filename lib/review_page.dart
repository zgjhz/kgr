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
  String relaxName = "Релаксация";
  String personRelaxName = "С. релаксации";
  String activationName = "Активация";
  String personActivationName = "С. активации";
  String midName = "Фон";
  String personMidName = "С. фона";
  String concentrationName = "Концентрация";
  String personConcentrartionName = "С. Концентрации";

  @override
  void initState() {
    int newConcentration = (concentration * 10).round();
    int personConcentrartion =
        PersonConcentrationPoint.personConcentrartionPoint.round();
    int personMid = PersonMidPoint.personMidPoint.round();
    int personActivation = PersonActivationPoint.personActivationPoint.round();
    int personRelax = PersonRelaxPoint.personRelaxPoint.round();
    int mid = newMid;
    // double relaxAccuracy = (differ.relax - personRelax).isNegative
    //     ? -(differ.relax - personRelax)
    //     : (differ.relax - personRelax);
    // double activationAccuracy =
    //     (differ.activation - personActivation).isNegative
    //         ? -(differ.activation - personActivation)
    //         : (differ.activation - personActivation);
    // if (relax <= personRelax){
    //   relaxName = "Польз. релаксация";
    //   personRelaxName = "Апп. релаксация";
    //   var temp = relax;
    //   relax = personRelax;
    //   personRelax = temp;
    // }
    // if (activation <= personActivation){
    //   activationName = "Польз. активация";
    //   personActivationName = "Апп. активация";
    //   var temp = activation;
    //   activation = personActivation;
    //   personActivation = temp;
    // }if (mid <= personMid){
    //   midName = "Польз. фон";
    //   personMidName = "Апп. фон";
    //   var temp = mid;
    //   mid = personMid;
    //   personMid = temp;
    // }
    data1 = [
      BarChartData('Релаксация', relax, 0, 0, 0, 0, 0, 0, 0),
      BarChartData('C. Релаксации', 0, personRelax, 0, 0, 0, 0, 0, 0),
      BarChartData('Активация', 0, 0, activation, 0, 0, 0, 0, 0),
      BarChartData('С. Активации', 0, 0, 0, personActivation, 0, 0, 0, 0),
      BarChartData('Фон', 0, 0, 0, 0, mid, 0, 0, 0),
      BarChartData('С. Фона', 0, 0, 0, 0, 0, personMid, 0, 0),
      BarChartData('Концентрация', 0, 0, 0, 0, 0, 0, newConcentration, 0),
      BarChartData(
          'С. Концентрации', 0, 0, 0, 0, 0, 0, 0, personConcentrartion),
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
              const EdgeInsets.only(left: 150, top: 40, right: 250, bottom: 60),
          child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: NumericAxis(
                              minimum: 0,
                              maximum: 10,
                              interval: 1,
                              labelStyle: const TextStyle(color: Colors.grey)),
                          tooltipBehavior: _tooltipBehavior,
                          legend: Legend(isVisible: true),
                          series: <ChartSeries>[
                            StackedColumnSeries<BarChartData, String>(
                              dataSource: data1,
                              xValueMapper: (BarChartData data, _) => data.name,
                              yValueMapper: (BarChartData data, _) =>
                                  data.relax,
                              name: relaxName,
                            ),
                            StackedColumnSeries<BarChartData, String>(
                                dataSource: data1,
                                xValueMapper: (BarChartData data, _) =>
                                    data.name,
                                yValueMapper: (BarChartData data, _) =>
                                    data.personRelax,
                                name: personRelaxName),
                            StackedColumnSeries<BarChartData, String>(
                                dataSource: data1,
                                xValueMapper: (BarChartData data, _) =>
                                    data.name,
                                yValueMapper: (BarChartData data, _) =>
                                    data.activation,
                                name: activationName),
                            StackedColumnSeries<BarChartData, String>(
                                dataSource: data1,
                                xValueMapper: (BarChartData data, _) =>
                                    data.name,
                                yValueMapper: (BarChartData data, _) =>
                                    data.personActivation,
                                name: personActivationName),
                            StackedColumnSeries<BarChartData, String>(
                                dataSource: data1,
                                xValueMapper: (BarChartData data, _) =>
                                    data.name,
                                yValueMapper: (BarChartData data, _) =>
                                    data.mid,
                                name: midName),
                            StackedColumnSeries<BarChartData, String>(
                                dataSource: data1,
                                xValueMapper: (BarChartData data, _) =>
                                    data.name,
                                yValueMapper: (BarChartData data, _) =>
                                    data.personMid,
                                name: personMidName),
                            StackedColumnSeries<BarChartData, String>(
                                dataSource: data1,
                                xValueMapper: (BarChartData data, _) =>
                                    data.name,
                                yValueMapper: (BarChartData data, _) =>
                                    data.concentration,
                                name: concentrationName),
                            StackedColumnSeries<BarChartData, String>(
                                dataSource: data1,
                                xValueMapper: (BarChartData data, _) =>
                                    data.name,
                                yValueMapper: (BarChartData data, _) =>
                                    data.personConcentrartion,
                                name: personConcentrartionName),
                          ]),
                    ),
                    const Expanded(child: Text("ТЕКСТ ОБОБЩЕНИЯ РЕЗУЛЬТАТОВ"))
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Row(
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
                          child: const Text(
                            'НАЗАД',
                            style: TextStyle(color: Color(0xff000000)),
                          )),
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
                                  const Color(0xfffec700))),
                          onPressed: () {
                            isSaving = true;
                          },
                          child: const Text('СОХРАНИТЬ', style: TextStyle(color: Color(0xff000000)),),),
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
                          child: const Text(
                            'ВЫЙТИ',
                            style: TextStyle(color: Color(0xff000000)),
                          )),
                    ),
                  ],
                )
              ])),
        ));
  }
}

class BarChartData {
  BarChartData(
      this.name,
      this.relax,
      this.personRelax,
      this.activation,
      this.personActivation,
      this.mid,
      this.personMid,
      this.concentration,
      this.personConcentrartion);

  final String name;
  final int relax;
  final int personRelax;
  final int activation;
  final int personActivation;
  final int mid;
  final int personMid;
  final int concentration;
  final int personConcentrartion;
}
