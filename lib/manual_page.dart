import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kgr_1/status_page.dart';
import 'text_sources.dart';

class ManualPage extends StatefulWidget {
  const ManualPage({Key? key}) : super(key: key);

  @override
  State<ManualPage> createState() => _ManualPageState();
}

class _ManualPageState extends State<ManualPage> {
  @override
  Widget build(BuildContext context) {
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
            //Expanded(
            /*child:*/ SingleChildScrollView(
              scrollDirection: Axis.vertical,
              dragStartBehavior: DragStartBehavior.start,
              child: Text(
                getManual(),
                style: const TextStyle(height: 2.5, fontSize: 12),
              ),
            ),
            //),
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
                        child: const Text('Выйти')),
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
                          Navigator.of(context).pushReplacementNamed(
                              '/statusPage',
                              arguments: ScreenArguments(
                                  'САМООЦЕНКА ТЕКУЩЕГО СОСТОЯНИЯ ТЕСТИРУЕМОГО ПЕРЕД ТЕСТИРОВАНИЕМ'));
                        },
                        child: const Text('Вперед')),
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
