import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:kgr_1/manual_page.dart';
import 'package:kgr_1/status_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' show rootBundle;

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
double concentration = 1.0;
var newConcentration = 1;

class _FinalChartPageState extends State<FinalChartPage> {
  List<LiveData> personMidPoint = [];

  List<LiveData> personRelaxPoint = [];
  List<LiveData> personActivationPoint = [];
  double personMid = PersonMidPoint.personMidPoint;
  double personRelax = PersonRelaxPoint.personRelaxPoint;
  double personActivation = PersonActivationPoint.personActivationPoint;
  double mid = data.mid;
  late GlobalKey<SfCartesianChartState> _cartesianChartKey;

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
    if(activation == 0){
      activation = 0;
    }else if (activation > 0 && activation <= 6) {
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
    if (mid <= 1.0) {
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
    print("Person relax: $personRelax");
    if (personRelax == 0) {
      personRelax = mid;
    }else if (personRelax == 1) {
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
    if(personActivation == 0){
      personActivation = _relax;
    }
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
    concentration -= calculateMeanDerivative(data.chartData) * 1.1;
    _cartesianChartKey = GlobalKey();
    super.initState();
  }

  Future<List<int>> _readData(String name) async {
    final ByteData data = await rootBundle.load('assets/fonts/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  Future<List<int>> _readImageData() async {
    final ui.Image data =
        await _cartesianChartKey.currentState!.toImage(pixelRatio: 1.0);
    final ByteData? bytes =
        await data.toByteData(format: ui.ImageByteFormat.png);
    return bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  }

  Future<void> _renderPDF() async {
    final List<int> imageBytes = await _readImageData();
    final PdfBitmap bitmap = PdfBitmap(imageBytes);
    final PdfDocument document = PdfDocument();
    document.pageSettings.margins.left = 40;
    document.pageSettings.margins.top = 45;
    // document.pageSettings.size =
    //     Size(bitmap.width.toDouble(), bitmap.height.toDouble());
    final PdfPage page1 = document.pages.add();
    final Size pageSize = page1.getClientSize();
    PdfFont boldFont = PdfTrueTypeFont(await _readData('ArialBold.ttf'), 16,
        style: PdfFontStyle.bold);
    PdfFont italicFont = PdfTrueTypeFont(await _readData('ArialItalic.ttf'), 16,
        style: PdfFontStyle.italic);
    PdfFont regularFont = PdfTrueTypeFont(
        await _readData('ArialRegular.ttf'), 12,
        style: PdfFontStyle.regular);
    page1.graphics.drawString(
        "РЕЗУЛЬТАТЫ ТЕСТИРОВАНИЯ НАВЫКА ПСИХИЧЕСКОЙ САМОРЕГУЛЯЦИИ", boldFont,
        brush: PdfSolidBrush(PdfColor(47, 98, 189)),
        bounds: const Rect.fromLTWH(0, 0, 600, 50));
    page1.graphics.drawString(fullName, boldFont,
        brush: PdfSolidBrush(PdfColor(47, 98, 189)),
        bounds: const Rect.fromLTWH(0, 70, 600, 50));
    page1.graphics.drawString(
        "Дата и время проведения тестирования: ", boldFont,
        brush: PdfSolidBrush(PdfColor(47, 98, 189)),
        bounds: const Rect.fromLTWH(0, 90, 600, 50));
    DateTime now = DateTime.now();
    page1.graphics.drawString(
        "${now.day}.${now.month}.${now.year} ${now.hour}:${now.minute}.",
        boldFont,
        brush: PdfSolidBrush(PdfColor(47, 98, 189)),
        bounds: const Rect.fromLTWH(330, 90, 600, 50));
    page1.graphics.drawString(
        "Описание научного обоснования использования методики", italicFont,
        brush: PdfSolidBrush(PdfColor(47, 98, 189)),
        bounds: const Rect.fromLTWH(0, 150, 600, 50));
    double paragraphIndent = 30;
    page1.graphics.drawString(
        "Согласно определению профессора Е.П.Ильина, психофизиологическое состояние - это целостная реакция личности на внешние и внутренние стимулы, направленная на достижение полезного результата. Поэтому индивидуализация процесса подготовки спортсменов должна ориентироваться на максимально возможный учет их психофизиологических особенностей, основанный на достоверной информации, полученной с помощью психодиагностических методик. Психодиагностика подразумевает получение объективной информации о психических свойствах спортсмена, его мотивации, психологических установках, межличностных отношениях, психических состояниях, возникающих в процессе спортивной деятельности. ",
        regularFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 170, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify,
            paragraphIndent: paragraphIndent));
    page1.graphics.drawString(
        "К числу наиболее значимых задач относится диагностика психических состояний, развивающихся, с одной стороны, как реакция на физические и психологические нагрузки, так и, с другой стороны, являющихся фоном, от которого зависит качество выполняемой спортсменом работы. ",
        regularFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 294, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify,
            paragraphIndent: paragraphIndent));
    page1.graphics.drawString(
        "Изучение психического состояния в современной спортивной науке обусловлено его значительным влиянием на успешность спортивной деятельности. Применение аппаратных методов диагностики необходимо в качестве обратной связи с целью разработки тактики психокоррекционных воздействий и своевременного и адекватного управления тренировочным процессом. Это в значительной степени приводит к повышению эффективности спортивной деятельности через оптимизацию психических состояний спортсменов. ",
        regularFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 350, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify,
            paragraphIndent: paragraphIndent));
    page1.graphics.drawString(
        "Кожно-гальваническая реакция (КГР) представляет собой системное проявление состояния организма. В характеристиках КГР достаточно полно отражаются особенности управляющих влияний нервной системы на вегетативные процессы, протекающие в организме. КГР, будучи компонентом ориентировочной реакции, отчетливо отражает уровень активации структур центральной нервной системы, связанный как с различными типами нагрузок, так и с индивидуальными особенностями, включая и психологическую сферу - эмоции, потребности, значимость внешних воздействий.",
        regularFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 447, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify,
            paragraphIndent: paragraphIndent));
    page1.graphics.drawString("Описание теста", italicFont,
        brush: PdfSolidBrush(PdfColor(47, 98, 189)),
        bounds: const Rect.fromLTWH(0, 590, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left, paragraphIndent: 0));
    page1.graphics.drawString(
        "Тест «Саморегуляция» направлен на исследование способности человека управлять своим психическим состоянием, произвольно снижать и повышать уровень активации, и сравнение данных субъективной оценки с объективными показателями. Биологическая обратная связь (БОС) осуществляется с помощью регистрации кожно-гальванической реакции (КГР). Продолжительность диагностики составляет 5 минут. Выводы делаются на основании соответствия полученных изменений КГР инструкции, а также сравнении их с данными самооценки (точность). ",
        regularFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 610, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify,
            paragraphIndent: paragraphIndent));
    final PdfPage page2 = document.pages.add();
    page2.graphics.drawString("Диапазоны значений КГР ", italicFont,
        brush: PdfSolidBrush(PdfColor(47, 98, 189)),
        bounds: const Rect.fromLTWH(0, 0, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left, paragraphIndent: 0));

    // Создаем таблицу
    final PdfGrid grid = PdfGrid();
    grid.columns.add(count: 4);

    // Создаем стиль для цветных ячеек
    PdfFont tableFont = PdfTrueTypeFont(await _readData('ArialRegular.ttf'), 10,
        style: PdfFontStyle.regular);
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

    // Добавляем строки и ячейки в таблицу
    grid.headers.add(1);
    PdfGridRow header = grid.headers[0];
    header.cells[0].value = 'Показатель';
    header.cells[1].value = 'Диапазон значений';
    header.cells[2].value = 'Диапазон значений (баллы)';
    header.cells[3].value = 'Характеристика';

    // Добавляем строки для Фон, МкСим
    PdfGridRow row = grid.rows.add();
    //row.cells[0].value = 'Фон, МкСим';
    row.cells[0].style = PdfGridCellStyle(
        borders: PdfBorders(bottom: PdfPen(PdfColor(255, 255, 255))));
    row.cells[1].value = '0-2,5';
    row.cells[2].value = '1-3';
    row.cells[2].style = lowStyle;
    row.cells[3].value = 'Низкий уровень';
    row.cells[3].style = lowStyle;

    row = grid.rows.add();
    row.cells[0].value = 'Фон, МкСим';
    row.cells[0].style = PdfGridCellStyle(
        borders: PdfBorders(
            top: PdfPen(PdfColor(255, 255, 255)),
            bottom: PdfPen(PdfColor(255, 255, 255))));
    row.cells[1].value = '2,6-4,9';
    row.cells[2].value = '4-7';
    row.cells[2].style = mediumStyle;
    row.cells[3].value = 'Средний уровень';
    row.cells[3].style = mediumStyle;

    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
        borders: PdfBorders(
            top: PdfPen(PdfColor(255, 255, 255)),
            bottom: PdfPen(PdfColor(255, 255, 255))));
    row.cells[1].value = '5 и более';
    row.cells[2].value = '8-10';
    row.cells[2].style = highStyle;
    row.cells[3].value = 'Высокий уровень';
    row.cells[3].style = highStyle;
    row = grid.rows.add();
    row.cells[1].style = PdfGridCellStyle(
        borders: PdfBorders(left: PdfPen(PdfColor(255, 255, 255))));
    row.cells[2].style = PdfGridCellStyle(
        borders: PdfBorders(left: PdfPen(PdfColor(255, 255, 255))));
    row.cells[3].style = PdfGridCellStyle(
        borders: PdfBorders(left: PdfPen(PdfColor(255, 255, 255))));

    // Добавляем строки для релаксации
    row = grid.rows.add();

    row.cells[1].value = 'Больше 0';
    row.cells[2].value = '0';
    row.cells[2].style = PdfGridCellStyle(
      font: regularFont,
      backgroundBrush: PdfBrushes.lightGray,
    );
    row.cells[3].value = 'Отсутствует способность к релаксации';
    row.cells[3].style =
        PdfGridCellStyle(backgroundBrush: PdfBrushes.lightGray);

    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
        borders: PdfBorders(
            top: PdfPen(PdfColor(255, 255, 255)),
            bottom: PdfPen(PdfColor(255, 255, 255))));
    row.cells[1].value = '(-1) - (-19)';
    row.cells[2].value = '1-3';
    row.cells[2].style = lowStyle;
    row.cells[3].value = 'Низкая способность к релаксации';
    row.cells[3].style = lowStyle;

    row = grid.rows.add();
    row.cells[0].value = 'Релаксация, %';
    row.cells[0].style = PdfGridCellStyle(
        borders: PdfBorders(
            top: PdfPen(PdfColor(255, 255, 255)),
            bottom: PdfPen(PdfColor(255, 255, 255))));
    row.cells[1].value = '(-20) - (-49)';
    row.cells[2].value = '4-7';
    row.cells[2].style = mediumStyle;
    row.cells[3].value = 'Средняя способность к релаксации';
    row.cells[3].style = mediumStyle;

    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
        borders: PdfBorders(
            top: PdfPen(PdfColor(255, 255, 255)),
            bottom: PdfPen(PdfColor(255, 255, 255))));
    row.cells[1].value = 'Менее (-50)';
    row.cells[2].value = '8-10';
    row.cells[2].style = highStyle;
    row.cells[3].value = 'Высокая способность к релаксации';
    row.cells[3].style = highStyle;
    row = grid.rows.add();
    row.cells[1].style = PdfGridCellStyle(
        borders: PdfBorders(left: PdfPen(PdfColor(255, 255, 255))));
    row.cells[2].style = PdfGridCellStyle(
        borders: PdfBorders(left: PdfPen(PdfColor(255, 255, 255))));
    row.cells[3].style = PdfGridCellStyle(
        borders: PdfBorders(left: PdfPen(PdfColor(255, 255, 255))));

    // Добавляем строки для активации
    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
        borders: PdfBorders(bottom: PdfPen(PdfColor(255, 255, 255))));
    row.cells[1].value = '0-20';
    row.cells[2].value = '1-3';
    row.cells[2].style = lowStyle;
    row.cells[3].value = 'Низкая способность к активации';
    row.cells[3].style = lowStyle;

    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
        borders: PdfBorders(
            top: PdfPen(PdfColor(255, 255, 255)),
            bottom: PdfPen(PdfColor(255, 255, 255))));
    row.cells[0].value = 'Активация, %';
    row.cells[1].value = '20-36';
    row.cells[2].value = '4-7';
    row.cells[2].style = mediumStyle;
    row.cells[3].value = 'Средняя способность к активации';
    row.cells[3].style = mediumStyle;

    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
        borders: PdfBorders(
            top: PdfPen(PdfColor(255, 255, 255)),
            bottom: PdfPen(PdfColor(255, 255, 255))));
    row.cells[1].value = 'Более 37';
    row.cells[2].value = '8-10';
    row.cells[2].style = highStyle;
    row.cells[3].value = 'Высокая способность к активации';
    row.cells[3].style = highStyle;
    row = grid.rows.add();
    row.cells[1].style = PdfGridCellStyle(
        borders: PdfBorders(left: PdfPen(PdfColor(255, 255, 255))));
    row.cells[2].style = PdfGridCellStyle(
        borders: PdfBorders(left: PdfPen(PdfColor(255, 255, 255))));
    row.cells[3].style = PdfGridCellStyle(
        borders: PdfBorders(left: PdfPen(PdfColor(255, 255, 255))));
    // Добавляем строки для концентрации
    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
        borders: PdfBorders(bottom: PdfPen(PdfColor(255, 255, 255))));
    row.cells[1].value = '0-3';
    row.cells[2].value = '1-3';
    row.cells[2].style = lowStyle;
    row.cells[3].value = 'Низкая способность к концентрации';
    row.cells[3].style = lowStyle;

    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
        borders: PdfBorders(
            top: PdfPen(PdfColor(255, 255, 255)),
            bottom: PdfPen(PdfColor(255, 255, 255))));
    row.cells[0].value = 'Концентрация';
    row.cells[1].value = '4-7';
    row.cells[2].value = '4-7';
    row.cells[2].style = mediumStyle;
    row.cells[3].value = 'Средняя способность к концентрации';
    row.cells[3].style = mediumStyle;

    row = grid.rows.add();
    row.cells[0].style = PdfGridCellStyle(
        borders: PdfBorders(top: PdfPen(PdfColor(255, 255, 255))));
    row.cells[1].value = '8-10';
    row.cells[2].value = '8-10';
    row.cells[2].style = highStyle;
    row.cells[3].value = 'Высокая способность к концентрации';
    row.cells[3].style = highStyle;

    grid.style = PdfGridStyle(
        borderOverlapStyle: PdfBorderOverlapStyle.overlap,
        cellPadding: PdfPaddings(left: 1, right: 2, top: 3, bottom: 4),
        backgroundBrush: PdfBrushes.white,
        textBrush: PdfBrushes.black,
        font: tableFont);

    grid.draw(page: page2, bounds: const Rect.fromLTWH(0, 30, 0, 0));
    page2.graphics.drawString(
        "Чем ниже значения показателя Фон, тем ниже психоэмоциональное напряжение. Чем выше значения показателя Фон, тем выше психоэмоциональное напряжение (неблагоприятное состояние). Оптимальными для спортсменов являются средние значения данного показателя, характеризующие состояние оптимального тонуса. ",
        regularFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 520, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify,
            paragraphIndent: paragraphIndent));
    page2.graphics.drawString(
        "Чем меньше значение показателя Релаксация, тем более выражена способность к произвольной релаксации. Это означает, что спортсмен в способен произвольно (в нужный ему момент) снижать уровень психоэмоционального напряжения. Значения показателя Релаксация приближенные к 0 (либо положительные значения) свидетельствуют об отсутствии у человека навыка к произвольной релаксации и неспособности произвольно снижать уровень психоэмоционального напряжения. ",
        regularFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 580, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify,
            paragraphIndent: paragraphIndent));
    page2.graphics.drawString(
        "Чем выше значения показателя Активация, тем выше выражена способность к произвольной активации (мобилизации), что свидетельствует о развитой у человека способности своевременно активизировать все свои силы и войти в необходимое состояние оптимального тонуса (бодрости, оптимальной боевой готовности). Низкие значения показателя Активация свидетельствуют о сниженной способности к произвольной регуляции психоэмоционального состояния. ",
        regularFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 665, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify,
            paragraphIndent: paragraphIndent));
    PdfPage page3 = document.pages.add();
    page3.graphics.drawString(
        "Чем выше значения показателя Концентрация, тем выше выражена способность удерживать внимание без отвлечения на выполнении поставленной задаче. Низкие значения показателя Концентрация свидетельствуют о сниженной способности удерживать внимание без отвлечения на выполнении поставленной задачи. ",
        regularFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 0, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify,
            paragraphIndent: paragraphIndent));
    page3.graphics.drawString("Описание результатов ", italicFont,
        brush: PdfSolidBrush(PdfColor(47, 98, 189)),
        bounds: const Rect.fromLTWH(0, 80, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.left, paragraphIndent: 0));
    PdfFont localFont = PdfTrueTypeFont(await _readData('ArialRegular.ttf'), 12,
        style: PdfFontStyle.regular);
    PdfFont localBoldFont = PdfTrueTypeFont(
        await _readData('ArialBold.ttf'), 12,
        style: PdfFontStyle.bold);
    page3.graphics.drawString("Самооценка состояния", localFont,
        brush: PdfSolidBrush(PdfColor(47, 98, 189)),
        bounds: const Rect.fromLTWH(0, 100, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify, paragraphIndent: 0));
    var characteristicPersonMid = "";
    var descriptionPersonMid = "";
    var scorePersonMid = "";
    if (PersonMidPoint.personMidPoint >= 1 &&
        PersonMidPoint.personMidPoint <= 3) {
      scorePersonMid = "низкая";
      characteristicPersonMid = "Низкий уровень";
      descriptionPersonMid =
          "испытуемый оценил свое исходное психоэмоциональное состояние как спокойное, без напряжения";
    } else if (PersonMidPoint.personMidPoint >= 4 &&
        PersonMidPoint.personMidPoint <= 7) {
      scorePersonMid = "средняя";
      characteristicPersonMid = "Средний уровень";
      descriptionPersonMid =
          "испытуемый оценил свое исходное психоэмоциональное состояние как средне-напряженное";
    } else if (PersonMidPoint.personMidPoint >= 7 &&
        PersonMidPoint.personMidPoint <= 10) {
      scorePersonMid = "высокая";
      characteristicPersonMid = "Высокий уровень";
      descriptionPersonMid =
          "испытуемый оценил свое исходное психоэмоциональное состояние как сильно-напряженное";
    }
    page3.graphics.drawString(
        "Фон_СО – «${PersonMidPoint.personMidPoint.toInt()}»", localBoldFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 120, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify, paragraphIndent: 30));
    var characteristicPersonRelax = "";
    var descriptionPersonRelax = "";
    var scorePersonRelax = "";
    if (PersonRelaxPoint.personRelaxPoint == 0) {
      scorePersonRelax = "низкая";
      characteristicPersonRelax = "Расслабиться не получилось";
      descriptionPersonRelax =
          "испытуемый сообщил, что расслабиться не получилось";
    } else if (PersonRelaxPoint.personRelaxPoint >= 1 &&
        PersonRelaxPoint.personRelaxPoint <= 3) {
      scorePersonRelax = "низкая";
      characteristicPersonRelax = "Расслабился немного";
      descriptionPersonRelax =
          "испытуемый сообщил, что расслабился незначительно";
    } else if (PersonRelaxPoint.personRelaxPoint >= 4 &&
        PersonRelaxPoint.personRelaxPoint <= 7) {
      scorePersonRelax = "средняя";
      characteristicPersonRelax = "Расслабился средне";
      descriptionPersonRelax = "испытуемый сообщил, что расслабился средне";
    } else if (PersonRelaxPoint.personRelaxPoint >= 7 &&
        PersonRelaxPoint.personRelaxPoint <= 10) {
      scorePersonRelax = "высокая";
      characteristicPersonRelax = "Сильно расслабился";
      descriptionPersonRelax = "испытуемый сообщил, что полностью расслабился";
    }
    page3.graphics.drawString(
        "Релаксация_СО – «${PersonRelaxPoint.personRelaxPoint.toInt()}»", localBoldFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 140, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify, paragraphIndent: 30));
    var characteristicPersonActivation = "";
    var descriptionPersonActivation = "";
    var scorePersonActivation = "";
    if (PersonActivationPoint.personActivationPoint == 0) {
      scorePersonActivation = "низкая";
      characteristicPersonActivation = "Активироваться не получилось";
      descriptionPersonActivation =
          "испытуемый сообщил, что активироваться не получилось";
    } else if (PersonActivationPoint.personActivationPoint >= 1 &&
        PersonActivationPoint.personActivationPoint <= 3) {
      scorePersonActivation = "низкая";
      characteristicPersonActivation = "Активировался немного";
      descriptionPersonActivation =
          "испытуемый сообщил, что активировался незначительно";
    } else if (PersonActivationPoint.personActivationPoint >= 4 &&
        PersonActivationPoint.personActivationPoint <= 7) {
      scorePersonActivation = "средняя";
      characteristicPersonActivation = "Активировался средне";
      descriptionPersonActivation = "испытуемый сообщил, что активировался средне";
    } else if (PersonActivationPoint.personActivationPoint >= 7 &&
        PersonActivationPoint.personActivationPoint <= 10) {
      scorePersonActivation = "высокая";
      characteristicPersonActivation = "Активировался полностью";
      descriptionPersonActivation =
          "испытуемый сообщил, что максимально активировался";
    }
    page3.graphics.drawString(
        "Активация_СО – «${PersonActivationPoint.personActivationPoint.toInt()}»",
        localBoldFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 160, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify, paragraphIndent: 30));

    var characteristicPersonConcentration = "";
    var descriptionPersonConcentration = "";
    var scorePersonConcentration = "";
    if (PersonActivationPoint.personActivationPoint == 0) {
      scorePersonConcentration = "низкая";
      characteristicPersonConcentration = "Активироваться не получилось";
      descriptionPersonConcentration =
      "испытуемый сообщил, что не смог сконцентрироваться.";
    } else if (PersonActivationPoint.personActivationPoint >= 1 &&
        PersonActivationPoint.personActivationPoint <= 3) {
      scorePersonConcentration = "низкая";
      characteristicPersonConcentration = "Активировался немного";
      descriptionPersonConcentration =
      "испытуемый сообщил, что немного сконцентрировался.";
    } else if (PersonActivationPoint.personActivationPoint >= 4 &&
        PersonActivationPoint.personActivationPoint <= 7) {
      scorePersonConcentration = "средняя";
      characteristicPersonConcentration = "Активировался средне";
      descriptionPersonConcentration = "испытуемый сообщил, что сконцентрировался средне.";
    } else if (PersonActivationPoint.personActivationPoint >= 7 &&
        PersonActivationPoint.personActivationPoint <= 10) {
      scorePersonConcentration = "высокая";
      characteristicPersonConcentration = "Активировался полностью";
      descriptionPersonConcentration =
      "испытуемый сообщил, что максимально удерживал концентрацию на поставленной задаче.";
    }
    page3.graphics.drawString(
        "Концентрация_СО – «${PersonConcentrationPoint.personConcentrationPoint.toInt()}»",
        localBoldFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 180, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify, paragraphIndent: 30));
    page3.graphics.drawString("Показатели прибора", localFont,
        brush: PdfSolidBrush(PdfColor(47, 98, 189)),
        bounds: const Rect.fromLTWH(0, 200, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify, paragraphIndent: 0));
    var characteristicMid = "";
    var descriptionMid = "";
    var scoreMid = "";
    if (newMid >= 1 && newMid <= 3) {
      scoreMid = "низкая";
      characteristicMid = "Низкий уровень";
      descriptionMid =
          "Зарегистрирован низкий уровень исходного фонового психоэмоционального состояния, напряжение отсутствует";
    } else if (newMid >= 4 && newMid <= 7) {
      scoreMid = "средняя";
      characteristicMid = "Средний уровень";
      descriptionMid =
          "Зарегистрирован средний уровень исходного фонового психоэмоционального состояния. Состояние оптимального тонуса";
    } else if (newMid >= 7 && newMid <= 10) {
      scoreMid = "высокая";
      characteristicMid = "Высокий уровень";
      descriptionMid =
          "Зарегистрирован высокий уровень исходного фонового психоэмоционального состояния, напряжение высокое";
    }
    page3.graphics.drawString(
        "Фон – «${(mid * 100).round() / 100}» ($characteristicMid, балл: «$newMid») ", localBoldFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 220, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify, paragraphIndent: 30));
    var characteristicRelax = "";
    var descriptionRelax = "";
    var scoreRelax = "";
    if (relax == 0) {
      scoreRelax = "низкая";
      characteristicRelax = "Отсутствует способность к релаксации";
      descriptionRelax = "Способность расслабиться не продемонстрирована";
    } else if (relax >= 1 && relax <= 3) {
      scoreRelax = "низкая";
      characteristicRelax = "Низкая способность к релаксации";
      descriptionRelax = "Продемонстрирована низкая способность расслабления";
    } else if (relax >= 4 && relax <= 7) {
      scoreRelax = "средняя";
      characteristicRelax = "Средняя способность к релаксации";
      descriptionRelax = "Продемонстрирована средняя способность расслабления";
    } else if (relax >= 7 && relax <= 10) {
      scoreRelax = "высокая";
      characteristicRelax = "Высокая способность к релаксации";
      descriptionRelax = "Продемонстрирована высокая способность расслабления";
    }
    page3.graphics.drawString(
        "Релаксация – «${(1 - data.chartRelaxPoint[0].relax / data.mid).isNegative ? 0 : ((1 - data.chartRelaxPoint[0].relax / data.mid) * 100).round()}%» ($characteristicRelax, балл: «$relax») ",
        localBoldFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 240, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify, paragraphIndent: 30));
    var characteristicActivation = "";
    var descriptionActivation = "";
    var scoreActivation = "";
    if (activation == 0) {
      scoreActivation = "низкая";
      characteristicActivation = "Отсутствует способность к активации";
      descriptionActivation =
          "Способность активироваться не продемонстрирована";
    } else if (activation >= 1 && activation <= 3) {
      scoreActivation = "низкая";
      characteristicActivation = "Низкая способность к активации";
      descriptionActivation = "Продемонстрирована низкая способность активации";
    } else if (activation >= 4 && activation <= 7) {
      scoreActivation = "средняя";
      characteristicActivation = "Средняя способность к активации";
      descriptionActivation =
          "Продемонстрирована средняя способность активации";
    } else if (activation >= 7 && activation <= 10) {
      scoreActivation = "высокая";
      characteristicActivation = "Высокая способность к активации";
      descriptionActivation =
          "Продемонстрирована высокая способность активации";
    }
    page3.graphics.drawString(
        "Активация – «${(data.chartActivationPoint[0].activation / data.chartRelaxPoint[0].relax - 1).isNegative ? 0 : ((data.chartActivationPoint[0].activation / data.chartRelaxPoint[0].relax - 1) * 100).round()}%» ($characteristicActivation, балл: «$activation») ",
        localBoldFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 260, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify, paragraphIndent: 30));
    var characteristicConcentration = "";
    var descriptionConcentration = "";
    var scoreConcentration = "";
    if (activation == 0) {
      scoreConcentration = "низкая";
      characteristicConcentration = "Отсутствует способность к активации";
      descriptionConcentration =
      "Способность активироваться не продемонстрирована";
    } else if (activation >= 1 && activation <= 3) {
      scoreConcentration = "низкая";
      characteristicConcentration = "Низкая способность концентрации";
      descriptionConcentration = "Продемонстрирована низкая способность концентрации на выполнении поставленной задачи";
    } else if (activation >= 4 && activation <= 7) {
      scoreConcentration = "средняя";
      characteristicConcentration = "Средняя способность концентрации";
      descriptionConcentration =
      "Продемонстрирована средняя способность концентрации на выполнении поставленной задачи";
    } else if (activation >= 7 && activation <= 10) {
      scoreConcentration = "высокая";
      characteristicConcentration = "Высокая способность концентрации";
      descriptionConcentration =
      "Продемонстрирована высокая способность концентрации на выполнении поставленной задачи";
    }
    page3.graphics.drawString(
        "Концентрация – «${(concentration * 100).toInt()}%» (оценка: «????», балл: «????») ",
        localBoldFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 280, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify, paragraphIndent: 30));
    page3.graphics.drawImage(bitmap, const Rect.fromLTWH(0, 300, 500, 250));
    page3.graphics.drawString(
        "По результатам тестирования $descriptionMid($newMid). При этом, $descriptionPersonMid(${PersonMidPoint.personMidPoint}).",
        regularFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 551, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify,
            paragraphIndent: paragraphIndent));
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

    int relaxAccuracy =
        (10 - (relax - PersonRelaxPoint.personRelaxPoint).abs().toInt()) * 10;
    List relaxAccuracyList = getAccuracy(relaxAccuracy, "релаксации");
    page3.graphics.drawString(
        "$descriptionRelax($relax). При этом, $descriptionPersonRelax(${PersonRelaxPoint.personRelaxPoint}). Таким образом, ${relaxAccuracyList[1]}(${relaxAccuracyList[0]})",
        regularFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 611, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify,
            paragraphIndent: paragraphIndent));
    int activationAccuracy =
        (10 - (activation - PersonActivationPoint.personActivationPoint).abs().toInt()) * 10;
    List activationAccuracyList = getAccuracy(activationAccuracy, "активации");
    page3.graphics.drawString(
        "$descriptionActivation($activation). При этом, $descriptionPersonActivation(${PersonActivationPoint.personActivationPoint}). Таким образом, ${activationAccuracyList[1]}(${activationAccuracyList[0]})",
        regularFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 656, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify,
            paragraphIndent: paragraphIndent));
    int concentrationAccuracy =
        (10 - (concentration - PersonConcentrationPoint.personConcentrationPoint).abs().toInt()) * 10;
    List concentrationAccuracyList = getAccuracy(concentrationAccuracy, "концентрации");
    page3.graphics.drawString(
        "$descriptionConcentration(${(concentration * 100).toInt()}%). При этом, $descriptionPersonConcentration(${PersonConcentrationPoint.personConcentrationPoint}). Таким образом, ${concentrationAccuracyList[1]}(${concentrationAccuracyList[0]})",
        regularFont,
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        bounds: const Rect.fromLTWH(0, 700, 500, 300),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.justify,
            paragraphIndent: paragraphIndent));


    final List<int> bytes = document.saveSync();
    document.dispose();
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = directory.path;
    print("PATH: $path");
    File file = File('$path/Output.pdf');
    await file.writeAsBytes(bytes, flush: true);
  }

  @override
  Widget build(BuildContext context) {
    personRelaxPoint = [
      LiveData(0, 0, 0, 0, 0, 0, 0, 1200, personRelax, 0, 0, 0, 0)
    ];
    personActivationPoint = [
      LiveData(0, 0, 0, 0, 0, 0, 0, 0, 0, 1500, personActivation, 0, 0)
    ];
    List<LiveData> personMidPoint = [
      LiveData(0, 0, 0, 0, 0, 300, personMid, 0, 0, 0, 0, 0, 0)
    ];

    differ = Differ(relax, activation, newMid);
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
                          const SizedBox(
                            height: 40,
                          ),
                          const Row(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'ЛАБИЛЬНОСТЬ',
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
                                    '${((maxLability / minLability) * 100).round()}',
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
                                // StackedLineSeries<LiveData, int>(
                                //   width: 2,
                                //   dataSource: data.chartData1,
                                //   color: const Color.fromRGBO(192, 108, 132, 1),
                                //   xValueMapper: (LiveData sales, _) =>
                                //       sales.time,
                                //   yValueMapper: (LiveData sales, _) =>
                                //       sales.mkSimOld,
                                // ),
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
                      _renderPDF();
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

class PersonConcentrationPoint {
  static double personConcentrationPoint = 0;
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
