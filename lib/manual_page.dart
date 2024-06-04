import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:kgr_1/status_page.dart';
import 'text_sources.dart';

class ManualPage extends StatefulWidget {
  const ManualPage({Key? key}) : super(key: key);

  @override
  State<ManualPage> createState() => _ManualPageState();
}

List<String> availablePorts = ["COM1"];
String selectedComPort = "";

class _ManualPageState extends State<ManualPage> {
  @override
  void initState() {
    availablePorts = SerialPort.availablePorts.isEmpty
        ? ["COM1"]
        : SerialPort.availablePorts;
    selectedComPort = availablePorts[0];
    print(availablePorts);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String selectedComPort = availablePorts.first;
    double spanSpace = 20;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 247, 254),
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 246, 246, 246),
          shape: const Border(bottom: BorderSide(color: Colors.grey, width: 2)),
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
            const EdgeInsets.only(left: 150, top: 60, right: 250, bottom: 80),
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: const Text(
                'ИНСТРУКЦИЯ ПО ПРОВЕДЕНИЮ ТЕСТИРОВАНИЯ',
                style: TextStyle(
                    fontSize: 28,
                    color: Color(0xff2389b1),
                    fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  dragStartBehavior: DragStartBehavior.start,
                  child: RichText(
                      text: TextSpan(
                          style: const TextStyle(color: Color(0xffa2a6a9)),
                          children: [
                        const TextSpan(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            text: "Шаг 1. "),
                        TextSpan(
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                            text: getStep1()),
                        WidgetSpan(
                          child: SizedBox(width: spanSpace),
                        ),
                        const TextSpan(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            text: "\nШаг 2. "),
                        TextSpan(
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                            text: getStep2()),
                        WidgetSpan(
                          child: SizedBox(width: spanSpace),
                        ),
                        const TextSpan(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            text: "\nШаг 3. "),
                        TextSpan(
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                            text: getStep3()),
                        WidgetSpan(
                          child: SizedBox(width: spanSpace),
                        ),
                        const TextSpan(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            text: "\nШаг 4. "),
                        TextSpan(
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                            text: getStep4()),
                        WidgetSpan(
                          child: SizedBox(width: spanSpace),
                        ),
                        const TextSpan(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            text: "\nШаг 5. "),
                        TextSpan(
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                            text: getStep5()),
                        WidgetSpan(
                          child: SizedBox(width: spanSpace),
                        ),
                        const TextSpan(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            text: "\nШаг 6. "),
                        TextSpan(
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                            text: getStep6()),
                        WidgetSpan(
                          child: SizedBox(width: spanSpace),
                        ),
                        const TextSpan(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            text: "\nШаг 7. "),
                        TextSpan(
                            style:
                                const TextStyle(fontWeight: FontWeight.normal),
                            text: getStep7()),
                      ]))),
            ),
            const SizedBox(
              height: 20,
            ),
            /*Expanded(
                child:*/
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisSize: MainAxisSize.max,
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
                          exit(0);
                        },
                        child: const Text('ВЫЙТИ',
                            style: TextStyle(color: Color(0xff000000)))),
                  ),
                  const Text("Выбор устройства: "),
                  const SizedBox(
                      height: 40, width: 300, child: DropdownMenuExample()),
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
                          'ВПЕРЁД',
                          style: TextStyle(color: Color(0xff000000)),
                        )),
                  )
                ],
              ),
            ) //)
          ]),
        ),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = availablePorts.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: availablePorts.first,
      onSelected: (String? value) {
        selectedComPort = value!;
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries:
          availablePorts.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
