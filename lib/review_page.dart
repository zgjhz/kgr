import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kgr_1/final_chart_page.dart';
import 'package:kgr_1/status_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'chart_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late List<BarChartData> data1;
  late TooltipBehavior _tooltipBehavior;
  late GlobalKey<SfCartesianChartState> _cartesianChartKey;
  int relaxAccuracy =
      (10 - (relax - PersonRelaxPoint.personRelaxPoint).abs().toInt()) * 10;
  int activationAccuracy = (10 -
          (activation - PersonActivationPoint.personActivationPoint)
              .abs()
              .toInt()) *
      10;
  int concentrationAccuracy = (10 -
          (concentration - PersonConcentrationPoint.personConcentrationPoint)
              .abs()
              .toInt()) *
      10;
  var characteristicPersonMid = "";
  var descriptionPersonMid = "";
  var scorePersonMid = "";
  var characteristicPersonRelax = "";
  var descriptionPersonRelax = "";
  var scorePersonRelax = "";
  var characteristicPersonActivation = "";
  var descriptionPersonActivation = "";
  var scorePersonActivation = "";
  var characteristicPersonConcentration = "";
  var descriptionPersonConcentration = "";
  var scorePersonConcentration = "";
  var characteristicMid = "";
  var descriptionMid = "";
  var scoreMid = "";
  var characteristicRelax = "";
  var descriptionRelax = "";
  var scoreRelax = "";
  var characteristicActivation = "";
  var descriptionActivation = "";
  var scoreActivation = "";
  var characteristicConcentration = "";
  var descriptionConcentration = "";
  var scoreConcentration = "";
  List getAccuracy(int value, String type) {
    List a = [];
    int score = (value / 10).round();
    a.add(score);
    if (score <= 10 && score >= 8) {
      a.add("продемонстрирована высокая точность самооценки $type");
    } else if (score <= 7 && score >= 4) {
      a.add("продемонстрирована средняя точность самооценки $type");
    } else if (score <= 3 && score >= 1) {
      a.add("продемонстрирована низкая точность самооценки $type");
    }
    return a;
  }
  @override
  void initState() {
    if (PersonMidPoint.personMidPoint >= 1 &&
        PersonMidPoint.personMidPoint <= 3) {
      scorePersonMid = "низкая";
      characteristicPersonMid = "Низкий уровень";
      descriptionPersonMid =
      "Испытуемый оценил свое исходное психоэмоциональное состояние как спокойное, без напряжения";
    } else if (PersonMidPoint.personMidPoint >= 4 &&
        PersonMidPoint.personMidPoint <= 7) {
      scorePersonMid = "средняя";
      characteristicPersonMid = "Средний уровень";
      descriptionPersonMid =
      "Испытуемый оценил свое исходное психоэмоциональное состояние как средне-напряженное";
    } else if (PersonMidPoint.personMidPoint >= 7 &&
        PersonMidPoint.personMidPoint <= 10) {
      scorePersonMid = "высокая";
      characteristicPersonMid = "Высокий уровень";
      descriptionPersonMid =
      "Испытуемый оценил свое исходное психоэмоциональное состояние как сильно-напряженное";
    }
    if (PersonRelaxPoint.personRelaxPoint == 0) {
      scorePersonRelax = "низкая";
      characteristicPersonRelax = "Расслабиться не получилось";
      descriptionPersonRelax =
      "Испытуемый сообщил, что расслабиться не получилось";
    } else if (PersonRelaxPoint.personRelaxPoint >= 1 &&
        PersonRelaxPoint.personRelaxPoint <= 3) {
      scorePersonRelax = "низкая";
      characteristicPersonRelax = "Расслабился немного";
      descriptionPersonRelax =
      "Испытуемый сообщил, что расслабился незначительно";
    } else if (PersonRelaxPoint.personRelaxPoint >= 4 &&
        PersonRelaxPoint.personRelaxPoint <= 7) {
      scorePersonRelax = "средняя";
      characteristicPersonRelax = "Расслабился средне";
      descriptionPersonRelax = "Испытуемый сообщил, что расслабился средне";
    } else if (PersonRelaxPoint.personRelaxPoint >= 7 &&
        PersonRelaxPoint.personRelaxPoint <= 10) {
      scorePersonRelax = "высокая";
      characteristicPersonRelax = "Сильно расслабился";
      descriptionPersonRelax = "Испытуемый сообщил, что полностью расслабился";
    }
    if (PersonActivationPoint.personActivationPoint == 0) {
      scorePersonActivation = "низкая";
      characteristicPersonActivation = "Активироваться не получилось";
      descriptionPersonActivation =
      "Испытуемый сообщил, что активироваться не получилось";
    } else if (PersonActivationPoint.personActivationPoint >= 1 &&
        PersonActivationPoint.personActivationPoint <= 3) {
      scorePersonActivation = "низкая";
      characteristicPersonActivation = "Активировался немного";
      descriptionPersonActivation =
      "Испытуемый сообщил, что активировался незначительно";
    } else if (PersonActivationPoint.personActivationPoint >= 4 &&
        PersonActivationPoint.personActivationPoint <= 7) {
      scorePersonActivation = "средняя";
      characteristicPersonActivation = "Активировался средне";
      descriptionPersonActivation = "Испытуемый сообщил, что активировался средне";
    } else if (PersonActivationPoint.personActivationPoint >= 7 &&
        PersonActivationPoint.personActivationPoint <= 10) {
      scorePersonActivation = "высокая";
      characteristicPersonActivation = "Активировался полностью";
      descriptionPersonActivation =
      "Испытуемый сообщил, что максимально активировался";
    }
    if (PersonActivationPoint.personActivationPoint == 0) {
      scorePersonConcentration = "низкая";
      characteristicPersonConcentration = "Активироваться не получилось";
      descriptionPersonConcentration =
      "Испытуемый сообщил, что не смог сконцентрироваться.";
    } else if (PersonActivationPoint.personActivationPoint >= 1 &&
        PersonActivationPoint.personActivationPoint <= 3) {
      scorePersonConcentration = "низкая";
      characteristicPersonConcentration = "Активировался немного";
      descriptionPersonConcentration =
      "Испытуемый сообщил, что немного сконцентрировался.";
    } else if (PersonActivationPoint.personActivationPoint >= 4 &&
        PersonActivationPoint.personActivationPoint <= 7) {
      scorePersonConcentration = "средняя";
      characteristicPersonConcentration = "Активировался средне";
      descriptionPersonConcentration = "Испытуемый сообщил, что сконцентрировался средне.";
    } else if (PersonActivationPoint.personActivationPoint >= 7 &&
        PersonActivationPoint.personActivationPoint <= 10) {
      scorePersonConcentration = "высокая";
      characteristicPersonConcentration = "Активировался полностью";
      descriptionPersonConcentration =
      "Испытуемый сообщил, что максимально удерживал концентрацию на поставленной задаче.";
    }
    if (newMid >= 1 && newMid <= 3) {
      scoreMid = "низкая";
      characteristicMid = "Низкий уровень";
      descriptionMid =
      "Зарегистрирован низкий уровень исходного фонового психоэмоционального состояния, напряжение отсутствует";
    }
    else if (newMid >= 4 && newMid <= 7) {
      scoreMid = "средняя";
      characteristicMid = "Средний уровень";
      descriptionMid =
      "Зарегистрирован средний уровень исходного фонового психоэмоционального состояния. Состояние оптимального тонуса";
    }
    else if (newMid >= 7 && newMid <= 10) {
      scoreMid = "высокая";
      characteristicMid = "Высокий уровень";
      descriptionMid =
      "Зарегистрирован высокий уровень исходного фонового психоэмоционального состояния, напряжение высокое";
    }
    if (relax == 0) {
      scoreRelax = "низкая";
      characteristicRelax = "Отсутствует способность к релаксации";
      descriptionRelax = "Способность расслабиться не продемонстрирована";
    }
    else if (relax >= 1 && relax <= 3) {
      scoreRelax = "низкая";
      characteristicRelax = "Низкая способность к релаксации";
      descriptionRelax = "Продемонстрирована низкая способность расслабления";
    }
    else if (relax >= 4 && relax <= 7) {
      scoreRelax = "средняя";
      characteristicRelax = "Средняя способность к релаксации";
      descriptionRelax = "Продемонстрирована средняя способность расслабления";
    }
    else if (relax >= 7 && relax <= 10) {
      scoreRelax = "высокая";
      characteristicRelax = "Высокая способность к релаксации";
      descriptionRelax = "Продемонстрирована высокая способность расслабления";
    }
    if (activation == 0) {
      scoreActivation = "низкая";
      characteristicActivation = "Отсутствует способность к активации";
      descriptionActivation =
      "Способность активироваться не продемонстрирована";
    }
    else if (activation >= 1 && activation <= 3) {
      scoreActivation = "низкая";
      characteristicActivation = "Низкая способность к активации";
      descriptionActivation = "Продемонстрирована низкая способность активации";
    }
    else if (activation >= 4 && activation <= 7) {
      scoreActivation = "средняя";
      characteristicActivation = "Средняя способность к активации";
      descriptionActivation =
      "Продемонстрирована средняя способность активации";
    }
    else if (activation >= 7 && activation <= 10) {
      scoreActivation = "высокая";
      characteristicActivation = "Высокая способность к активации";
      descriptionActivation =
      "Продемонстрирована высокая способность активации";
    }
    if (activation == 0) {
      scoreConcentration = "низкая";
      characteristicActivation = "Отсутствует способность к активации";
      descriptionConcentration =
      "Способность активироваться не продемонстрирована";
    }
    else if (activation >= 1 && activation <= 3) {
      scoreConcentration = "низкая";
      characteristicConcentration = "Низкая способность концентрации";
      descriptionConcentration = "Продемонстрирована низкая способность концентрации на выполнении поставленной задачи";
    }
    else if (activation >= 4 && activation <= 7) {
      scoreConcentration = "средняя";
      characteristicConcentration = "Средняя способность концентрации";
      descriptionConcentration =
      "Продемонстрирована средняя способность концентрации на выполнении поставленной задачи";
    }
    else if (activation >= 7 && activation <= 10) {
      scoreConcentration = "высокая";
      characteristicConcentration = "Высокая способность концентрации";
      descriptionConcentration =
      "Продемонстрирована высокая способность концентрации на выполнении поставленной задачи";
    }
    int newConcentration = (concentration * 10).round();
    int personConcentrartion =
        PersonConcentrationPoint.personConcentrationPoint.round();
    int personMid = PersonMidPoint.personMidPoint.round();
    int personActivation = PersonActivationPoint.personActivationPoint.round();
    int personRelax = PersonRelaxPoint.personRelaxPoint.round();
    int mid = newMid;
    data1 = [
      BarChartData('Точность релаксации', relaxAccuracy, 0, 0),
      BarChartData('Точность активации', 0, activationAccuracy, 0),
      BarChartData('Точность концентрации', 0, 0, concentrationAccuracy),
    ];
    _cartesianChartKey = GlobalKey();
    _tooltipBehavior = TooltipBehavior(enable: true);
    print(
        "mid: $mid personMid: $personMid \n activation: $activation personActivation: $personActivation \n relax: $relax personRelax: $personRelax");
    super.initState();
  }

  Future<List<int>> _readImageData() async {
    final ui.Image data =
        await _cartesianChartKey.currentState!.toImage(pixelRatio: 1.0);
    final ByteData? bytes =
        await data.toByteData(format: ui.ImageByteFormat.png);
    return bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }

  void _renderPDF() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    PdfDocument document =
        PdfDocument(inputBytes: File('$path/Output.pdf').readAsBytesSync());
    final List<int> imageBytes = await _readImageData();
    final PdfBitmap bitmap = PdfBitmap(imageBytes);
    PdfPage page4 = document.pages.add();
    page4.graphics.drawImage(bitmap, const Rect.fromLTWH(0, 0, 500, 250));
    Future<List<int>> _readData(String name) async {
      final ByteData data = await rootBundle.load('assets/fonts/$name');
      return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    }

    PdfFont tableFont = PdfTrueTypeFont(await _readData('ArialRegular.ttf'), 10,
        style: PdfFontStyle.regular);
    // Создаем стиль для цветных ячеек
    PdfGridCellStyle lowStyle = PdfGridCellStyle(
      font: tableFont,
      backgroundBrush: PdfBrushes.lightPink,
    );
    PdfGridCellStyle mediumStyle = PdfGridCellStyle(
      font: tableFont,
      backgroundBrush: PdfBrushes.lightYellow,
    );
    PdfGridCellStyle highStyle = PdfGridCellStyle(
      font: tableFont,
      backgroundBrush: PdfBrushes.lightGreen,
    );
    PdfFont regularFont = PdfTrueTypeFont(
        await _readData('ArialRegular.ttf'), 12,
        style: PdfFontStyle.regular);
    page4.graphics.drawString("Диапазоны точности самооценки ", regularFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 250, 600, 50));
    PdfGrid grid2 = PdfGrid();
    grid2.style = PdfGridStyle(
        borderOverlapStyle: PdfBorderOverlapStyle.overlap,
        cellPadding: PdfPaddings(left: 1, right: 2, top: 3, bottom: 4),
        backgroundBrush: PdfBrushes.white,
        textBrush: PdfBrushes.black,
        font: tableFont);
    grid2.columns.add(count: 4);

    grid2.headers.add(1);
    PdfGridRow header2 = grid2.headers[0];
    header2.cells[0].value = 'Точность Самооценки';
    header2.cells[1].value = 'Диапазон значений';
    header2.cells[2].value = 'Диапазон значений (баллы)';
    header2.cells[3].value = 'Характеристика';

    PdfGridRow row = grid2.rows.add();
    row.cells[0].value = '';
    row.cells[1].value = '100-70%';
    row.cells[2].value = '1-3';
    row.cells[2].style = highStyle;
    row.cells[3].value = 'Высокая точность самооценки';
    row.cells[3].style = highStyle;

    row = grid2.rows.add();
    row.cells[0].value = '';
    row.cells[1].value = '60-30%';
    row.cells[2].value = '4-7';
    row.cells[2].style = mediumStyle;
    row.cells[3].value = 'Средняя точность самооценки';
    row.cells[3].style = mediumStyle;

    row = grid2.rows.add();
    row.cells[0].value = '';
    row.cells[1].value = '20-10%';
    row.cells[2].value = '8-10';
    row.cells[2].style = lowStyle;
    row.cells[3].value = 'Низкая точность самооценки';
    row.cells[3].style = lowStyle;

    grid2.draw(
        page: page4,
        bounds: Rect.fromLTWH(
            0, 270, page4.getClientSize().width, page4.getClientSize().height));

    int sum = ((relax + activation + concentration) / 4).round();
    page4.graphics.drawString(
        "ПСР-СП (суммарный показатель выраженности навыка психической саморегуляции) «$sum»,\n балл",
        regularFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 425, 600, 50));
    int accuracySum =
        ((relaxAccuracy + activationAccuracy + concentrationAccuracy) / 30)
            .round();
    page4.graphics.drawString(
        "Т-СО-СП (суммарный показатель точности самооценки состояний) «$accuracySum»,балл",
        regularFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 455, 600, 50));

    final List<int> bytes = document.saveSync();
    document.dispose();
    File file = File('$path/Output.pdf');
    await file.writeAsBytes(bytes, flush: true);
  }
  final TextStyle regularStyle = const TextStyle(color: Color(0xffa2a6a9), fontSize: 16, fontWeight: FontWeight.normal);
  final TextStyle boldStyle = const TextStyle(color: Color(0xffa2a6a9), fontSize: 16, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    List relaxAccuracyList = getAccuracy(relaxAccuracy, "релаксации");
    List activationAccuracyList = getAccuracy(activationAccuracy, "активации");
    List concentrationAccuracyList = getAccuracy(concentrationAccuracy, "концентрации");
    bool isSaving = false;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 233, 247, 229),
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 246, 246, 246),
            shape:
                const Border(bottom: BorderSide(color: Colors.grey, width: 2)),
            toolbarHeight: 90,
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
          const EdgeInsets.only(left: 50, top: 30, right: 200, bottom: 80),
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
                          key: _cartesianChartKey,
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: NumericAxis(
                              minimum: 0,
                              maximum: 100,
                              interval: 10,
                              labelStyle: const TextStyle(color: Colors.grey)),
                          tooltipBehavior: _tooltipBehavior,
                          legend: Legend(isVisible: true),
                          series: <ChartSeries>[
                            StackedColumnSeries<BarChartData, String>(
                              dataSource: data1,
                              xValueMapper: (BarChartData data, _) => data.name,
                              yValueMapper: (BarChartData data, _) =>
                                  data.relaxAccuracy,
                              name: "Точность релаксации",
                            ),
                            StackedColumnSeries<BarChartData, String>(
                                dataSource: data1,
                                xValueMapper: (BarChartData data, _) =>
                                    data.name,
                                yValueMapper: (BarChartData data, _) =>
                                    data.activationAccuracy,
                                name: "Точность активации"),
                            StackedColumnSeries<BarChartData, String>(
                                dataSource: data1,
                                xValueMapper: (BarChartData data, _) =>
                                    data.name,
                                yValueMapper: (BarChartData data, _) =>
                                    data.concentrationAccuracy,
                                name: "Точность концентрации"),
                          ]),
                    ),
                    Expanded(
                        child: RichText(
                      text: TextSpan(style: regularStyle,children: [
                        TextSpan(text: "Фон_СО", style: boldStyle), TextSpan(text: " – «${PersonMidPoint.personMidPoint.toInt()}»"),
                        TextSpan(text: "\nРелаксация_СО", style: boldStyle), TextSpan(text: " – «${PersonRelaxPoint.personRelaxPoint.toInt()}»"),
                        TextSpan(text: "\nАктивация_СО", style: boldStyle), TextSpan(text: " – «${PersonActivationPoint.personActivationPoint.toInt()}»"),
                        TextSpan(text: "\nКонцентрация_СО", style: boldStyle), TextSpan(text: " – «${PersonConcentrationPoint.personConcentrationPoint.toInt()}»"),
                        TextSpan(text: "\nФон", style: boldStyle), TextSpan(text: " – «${newMid.toInt()}»"),
                        TextSpan(text: "\nРелаксация", style: boldStyle), TextSpan(text: " – «${relax.toInt()}»"),
                        TextSpan(text: "\nАктивация", style: boldStyle), TextSpan(text: " – «${activation.toInt()}»"),
                        TextSpan(text: "\nКонцентрация", style: boldStyle), TextSpan(text: " – «${(concentration * 100).toInt()}»"),
                        TextSpan(text: "\nПо результатам тестирования $descriptionMid(${newMid.toInt()}). При этом $descriptionPersonMid(${PersonMidPoint.personMidPoint.toInt()})"),
                        TextSpan(text: "\n$descriptionRelax(${relax.toInt()}). При этом $descriptionPersonRelax(${PersonRelaxPoint.personRelaxPoint.toInt()}). Таким образом, ${relaxAccuracyList[1]}(${relaxAccuracyList[0]})"),
                        TextSpan(text: "\n$descriptionActivation(${activation.toInt()}). При этом $descriptionPersonActivation(${PersonActivationPoint.personActivationPoint.toInt()}). Таким образом, ${activationAccuracyList[1]}(${activationAccuracyList[0]})"),
                        TextSpan(text: "\n$descriptionConcentration(${(concentration * 100).toInt()}). При этом $descriptionPersonConcentration(${PersonConcentrationPoint.personConcentrationPoint.toInt()}). Таким образом, ${concentrationAccuracyList[1]}(${concentrationAccuracyList[0]})"),
                      ]),
                    ))
                    //Text("Релаксация: $relax \n Активация: $activation \n Концентрация: ${(concentration * 100).toInt()}% \n Релаксация_СО: ${PersonRelaxPoint.personRelaxPoint} \n Активация_СО: ${PersonActivationPoint.personActivationPoint} \n Концентрация_СО: ${PersonConcentrationPoint.personConcentrartionPoint}"))
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
                          if (isSaving != true) {
                            _renderPDF();
                          }
                          isSaving = true;
                        },
                        child: const Text(
                          'СОХРАНИТЬ',
                          style: TextStyle(color: Color(0xff000000)),
                        ),
                      ),
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
  BarChartData(this.name, this.relaxAccuracy, this.activationAccuracy,
      this.concentrationAccuracy);

  final String name;
  final int relaxAccuracy;
  final int activationAccuracy;
  final int concentrationAccuracy;
}
