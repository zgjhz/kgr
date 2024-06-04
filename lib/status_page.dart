import 'package:flutter/material.dart';
import 'package:kgr_1/final_chart_page.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  List<bool> pressAttention = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    double buttonWidth = MediaQuery.of(context).size.width / 16;
    double buttonHeight = buttonWidth;
    const double buttonSpacing = 5;
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
            const EdgeInsets.only(left: 150, top: 50, right: 150, bottom: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                args.title,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff2389b1)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: const TextSpan(
                    text: 'Спросите испытуемого: \n',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    children: [
                      TextSpan(
                          text:
                              '"Как Вы оцениваете сейчас свое состояние по шкале от 0 до 10?"',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal))
                    ]),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Совершенно спокоен, почти засыпаю',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Нахожусь в максимальном напряжении',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: buttonHeight,
                      width: buttonWidth,
                      child: ElevatedButton(
                          onPressed: () {
                            if (args.title ==
                                'САМООЦЕНКА ТЕКУЩЕГО СОСТОЯНИЯ ТЕСТИРУЕМОГО ПЕРЕД ТЕСТИРОВАНИЕМ') {
                              PersonMidPoint.personMidPoint = 0;
                            } else if (args.title == 'САМООЦЕНКА РЕЛАКСАЦИИ') {
                              PersonRelaxPoint.personRelaxPoint = 10;
                            } else if (args.title == 'САМООЦЕНКА АКТИВАЦИИ') {
                              PersonActivationPoint.personActivationPoint = 0;
                            } else if (args.title ==
                                'САМООЦЕНКА КОНЦЕНТРАЦИИ') {
                              PersonConcentrationPoint
                                  .personConcentrartionPoint = 0;
                            }
                            setState(() {
                              pressAttention[0] = !pressAttention[0];
                              pressAttention[1] = false;
                              pressAttention[2] = false;
                              pressAttention[3] = false;
                              pressAttention[4] = false;
                              pressAttention[5] = false;
                              pressAttention[6] = false;
                              pressAttention[7] = false;
                              pressAttention[8] = false;
                              pressAttention[9] = false;
                              pressAttention[10] = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            backgroundColor:
                                pressAttention[0] ? Colors.grey : Colors.white,
                          ),
                          child: const Text('')),
                    ),
                    const SizedBox(
                      height: buttonSpacing,
                    ),
                    const Text(
                      '0',
                      style: TextStyle(
                          color: Color.fromARGB(255, 87, 68, 87),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: buttonHeight,
                      width: buttonWidth,
                      child: ElevatedButton(
                          onPressed: () {
                            if (args.title ==
                                'САМООЦЕНКА ТЕКУЩЕГО СОСТОЯНИЯ ТЕСТИРУЕМОГО ПЕРЕД ТЕСТИРОВАНИЕМ') {
                              PersonMidPoint.personMidPoint = 1;
                            } else if (args.title == 'САМООЦЕНКА РЕЛАКСАЦИИ') {
                              PersonRelaxPoint.personRelaxPoint = 9;
                            } else if (args.title == 'САМООЦЕНКА АКТИВАЦИИ') {
                              PersonActivationPoint.personActivationPoint = 1;
                            } else if (args.title ==
                                'САМООЦЕНКА КОНЦЕНТРАЦИИ') {
                              PersonConcentrationPoint
                                  .personConcentrartionPoint = 1;
                            }
                            setState(() {
                              pressAttention[0] = false;
                              pressAttention[1] = !pressAttention[1];
                              pressAttention[2] = false;
                              pressAttention[3] = false;
                              pressAttention[4] = false;
                              pressAttention[5] = false;
                              pressAttention[6] = false;
                              pressAttention[7] = false;
                              pressAttention[8] = false;
                              pressAttention[9] = false;
                              pressAttention[10] = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            backgroundColor: pressAttention[1]
                                ? Colors.grey
                                : const Color(0xfffdeded),
                          ),
                          child: const Text('')),
                    ),
                    const SizedBox(
                      height: buttonSpacing,
                    ),
                    const Text(
                      '1',
                      style: TextStyle(
                          color: Color.fromARGB(255, 87, 68, 87),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: buttonHeight,
                      width: buttonWidth,
                      child: ElevatedButton(
                          onPressed: () {
                            if (args.title ==
                                'САМООЦЕНКА ТЕКУЩЕГО СОСТОЯНИЯ ТЕСТИРУЕМОГО ПЕРЕД ТЕСТИРОВАНИЕМ') {
                              PersonMidPoint.personMidPoint = 2;
                            } else if (args.title == 'САМООЦЕНКА РЕЛАКСАЦИИ') {
                              PersonRelaxPoint.personRelaxPoint = 8;
                            } else if (args.title == 'САМООЦЕНКА АКТИВАЦИИ') {
                              PersonActivationPoint.personActivationPoint = 2;
                            } else if (args.title ==
                                'САМООЦЕНКА КОНЦЕНТРАЦИИ') {
                              PersonConcentrationPoint
                                  .personConcentrartionPoint = 2;
                            }
                            setState(() {
                              pressAttention[0] = false;
                              pressAttention[1] = false;
                              pressAttention[2] = !pressAttention[2];
                              pressAttention[3] = false;
                              pressAttention[4] = false;
                              pressAttention[5] = false;
                              pressAttention[6] = false;
                              pressAttention[7] = false;
                              pressAttention[8] = false;
                              pressAttention[9] = false;
                              pressAttention[10] = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            backgroundColor: pressAttention[2]
                                ? Colors.grey
                                : const Color(0xfffbdbdc),
                          ),
                          child: const Text('')),
                    ),
                    const SizedBox(
                      height: buttonSpacing,
                    ),
                    const Text(
                      '2',
                      style: TextStyle(
                          color: Color.fromARGB(255, 87, 68, 87),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: buttonHeight,
                      width: buttonWidth,
                      child: ElevatedButton(
                          onPressed: () {
                            if (args.title ==
                                'САМООЦЕНКА ТЕКУЩЕГО СОСТОЯНИЯ ТЕСТИРУЕМОГО ПЕРЕД ТЕСТИРОВАНИЕМ') {
                              PersonMidPoint.personMidPoint = 3;
                            } else if (args.title == 'САМООЦЕНКА РЕЛАКСАЦИИ') {
                              PersonRelaxPoint.personRelaxPoint = 7;
                            } else if (args.title == 'САМООЦЕНКА АКТИВАЦИИ') {
                              PersonActivationPoint.personActivationPoint = 3;
                            } else if (args.title ==
                                'САМООЦЕНКА КОНЦЕНТРАЦИИ') {
                              PersonConcentrationPoint
                                  .personConcentrartionPoint = 3;
                            }
                            setState(() {
                              pressAttention[0] = false;
                              pressAttention[1] = false;
                              pressAttention[2] = false;
                              pressAttention[3] = !pressAttention[3];
                              pressAttention[4] = false;
                              pressAttention[5] = false;
                              pressAttention[6] = false;
                              pressAttention[7] = false;
                              pressAttention[8] = false;
                              pressAttention[9] = false;
                              pressAttention[10] = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            backgroundColor: pressAttention[3]
                                ? Colors.grey
                                : const Color(0xfff9c7c0),
                          ),
                          child: const Text('')),
                    ),
                    const SizedBox(
                      height: buttonSpacing,
                    ),
                    const Text(
                      '3',
                      style: TextStyle(
                          color: Color.fromARGB(255, 87, 68, 87),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: buttonHeight,
                      width: buttonWidth,
                      child: ElevatedButton(
                          onPressed: () {
                            if (args.title ==
                                'САМООЦЕНКА ТЕКУЩЕГО СОСТОЯНИЯ ТЕСТИРУЕМОГО ПЕРЕД ТЕСТИРОВАНИЕМ') {
                              PersonMidPoint.personMidPoint = 4;
                            } else if (args.title == 'САМООЦЕНКА РЕЛАКСАЦИИ') {
                              PersonRelaxPoint.personRelaxPoint = 6;
                            } else if (args.title == 'САМООЦЕНКА АКТИВАЦИИ') {
                              PersonActivationPoint.personActivationPoint = 4;
                            } else if (args.title ==
                                'САМООЦЕНКА КОНЦЕНТРАЦИИ') {
                              PersonConcentrationPoint
                                  .personConcentrartionPoint = 4;
                            }
                            setState(() {
                              pressAttention[0] = false;
                              pressAttention[1] = false;
                              pressAttention[2] = false;
                              pressAttention[3] = false;
                              pressAttention[4] = !pressAttention[4];
                              pressAttention[5] = false;
                              pressAttention[6] = false;
                              pressAttention[7] = false;
                              pressAttention[8] = false;
                              pressAttention[9] = false;
                              pressAttention[10] = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            backgroundColor: pressAttention[4]
                                ? Colors.grey
                                : const Color(0xfff5b1a6),
                          ),
                          child: const Text('')),
                    ),
                    const SizedBox(
                      height: buttonSpacing,
                    ),
                    const Text(
                      '4',
                      style: TextStyle(
                          color: Color.fromARGB(255, 87, 68, 87),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: buttonHeight,
                      width: buttonWidth,
                      child: ElevatedButton(
                          onPressed: () {
                            if (args.title ==
                                'САМООЦЕНКА ТЕКУЩЕГО СОСТОЯНИЯ ТЕСТИРУЕМОГО ПЕРЕД ТЕСТИРОВАНИЕМ') {
                              PersonMidPoint.personMidPoint = 5;
                            } else if (args.title == 'САМООЦЕНКА РЕЛАКСАЦИИ') {
                              PersonRelaxPoint.personRelaxPoint = 5;
                            } else if (args.title == 'САМООЦЕНКА АКТИВАЦИИ') {
                              PersonActivationPoint.personActivationPoint = 5;
                            } else if (args.title ==
                                'САМООЦЕНКА КОНЦЕНТРАЦИИ') {
                              PersonConcentrationPoint
                                  .personConcentrartionPoint = 5;
                            }
                            setState(() {
                              pressAttention[0] = false;
                              pressAttention[1] = false;
                              pressAttention[2] = false;
                              pressAttention[3] = false;
                              pressAttention[4] = false;
                              pressAttention[5] = !pressAttention[5];
                              pressAttention[6] = false;
                              pressAttention[7] = false;
                              pressAttention[8] = false;
                              pressAttention[9] = false;
                              pressAttention[10] = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            backgroundColor: pressAttention[5]
                                ? Colors.grey
                                : const Color(0xfff39a8c),
                          ),
                          child: const Text('')),
                    ),
                    const SizedBox(
                      height: buttonSpacing,
                    ),
                    const Text(
                      '5',
                      style: TextStyle(
                          color: Color.fromARGB(255, 87, 68, 87),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: buttonHeight,
                      width: buttonWidth,
                      child: ElevatedButton(
                          onPressed: () {
                            if (args.title ==
                                'САМООЦЕНКА ТЕКУЩЕГО СОСТОЯНИЯ ТЕСТИРУЕМОГО ПЕРЕД ТЕСТИРОВАНИЕМ') {
                              PersonMidPoint.personMidPoint = 6;
                            } else if (args.title == 'САМООЦЕНКА РЕЛАКСАЦИИ') {
                              PersonRelaxPoint.personRelaxPoint = 4;
                            } else if (args.title == 'САМООЦЕНКА АКТИВАЦИИ') {
                              PersonActivationPoint.personActivationPoint = 6;
                            } else if (args.title ==
                                'САМООЦЕНКА КОНЦЕНТРАЦИИ') {
                              PersonConcentrationPoint
                                  .personConcentrartionPoint = 6;
                            }
                            setState(() {
                              pressAttention[0] = false;
                              pressAttention[1] = false;
                              pressAttention[2] = false;
                              pressAttention[3] = false;
                              pressAttention[4] = false;
                              pressAttention[5] = false;
                              pressAttention[6] = !pressAttention[6];
                              pressAttention[7] = false;
                              pressAttention[8] = false;
                              pressAttention[9] = false;
                              pressAttention[10] = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            backgroundColor: pressAttention[6]
                                ? Colors.grey
                                : const Color(0xfff18372),
                          ),
                          child: const Text('')),
                    ),
                    const SizedBox(
                      height: buttonSpacing,
                    ),
                    const Text(
                      '6',
                      style: TextStyle(
                          color: Color.fromARGB(255, 87, 68, 87),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: buttonHeight,
                      width: buttonWidth,
                      child: ElevatedButton(
                          onPressed: () {
                            if (args.title ==
                                'САМООЦЕНКА ТЕКУЩЕГО СОСТОЯНИЯ ТЕСТИРУЕМОГО ПЕРЕД ТЕСТИРОВАНИЕМ') {
                              PersonMidPoint.personMidPoint = 7;
                            } else if (args.title == 'САМООЦЕНКА РЕЛАКСАЦИИ') {
                              PersonRelaxPoint.personRelaxPoint = 3;
                            } else if (args.title == 'САМООЦЕНКА АКТИВАЦИИ') {
                              PersonActivationPoint.personActivationPoint = 7;
                            } else if (args.title ==
                                'САМООЦЕНКА КОНЦЕНТРАЦИИ') {
                              PersonConcentrationPoint
                                  .personConcentrartionPoint = 7;
                            }
                            setState(() {
                              pressAttention[0] = false;
                              pressAttention[1] = false;
                              pressAttention[2] = false;
                              pressAttention[3] = false;
                              pressAttention[4] = false;
                              pressAttention[5] = false;
                              pressAttention[6] = false;
                              pressAttention[7] = !pressAttention[7];
                              pressAttention[8] = false;
                              pressAttention[9] = false;
                              pressAttention[10] = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            backgroundColor: pressAttention[7]
                                ? Colors.grey
                                : const Color(0xffee6a5b),
                          ),
                          child: const Text('')),
                    ),
                    const SizedBox(
                      height: buttonSpacing,
                    ),
                    const Text(
                      '7',
                      style: TextStyle(
                          color: Color.fromARGB(255, 87, 68, 87),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: buttonHeight,
                      width: buttonWidth,
                      child: ElevatedButton(
                          onPressed: () {
                            if (args.title ==
                                'САМООЦЕНКА ТЕКУЩЕГО СОСТОЯНИЯ ТЕСТИРУЕМОГО ПЕРЕД ТЕСТИРОВАНИЕМ') {
                              PersonMidPoint.personMidPoint = 8;
                            } else if (args.title == 'САМООЦЕНКА РЕЛАКСАЦИИ') {
                              PersonRelaxPoint.personRelaxPoint = 2;
                            } else if (args.title == 'САМООЦЕНКА АКТИВАЦИИ') {
                              PersonActivationPoint.personActivationPoint = 8;
                            } else if (args.title ==
                                'САМООЦЕНКА КОНЦЕНТРАЦИИ') {
                              PersonConcentrationPoint
                                  .personConcentrartionPoint = 8;
                            }
                            setState(() {
                              pressAttention[0] = false;
                              pressAttention[1] = false;
                              pressAttention[2] = false;
                              pressAttention[3] = false;
                              pressAttention[4] = false;
                              pressAttention[5] = false;
                              pressAttention[6] = false;
                              pressAttention[7] = false;
                              pressAttention[8] = !pressAttention[8];
                              pressAttention[9] = false;
                              pressAttention[10] = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(),
                            backgroundColor: pressAttention[8]
                                ? Colors.grey
                                : const Color(0xffea5046),
                          ),
                          child: const Text('')),
                    ),
                    const SizedBox(
                      height: buttonSpacing,
                    ),
                    const Text(
                      '8',
                      style: TextStyle(
                          color: Color.fromARGB(255, 87, 68, 87),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: buttonHeight,
                      width: buttonWidth,
                      child: ElevatedButton(
                          onPressed: () {
                            if (args.title ==
                                'САМООЦЕНКА ТЕКУЩЕГО СОСТОЯНИЯ ТЕСТИРУЕМОГО ПЕРЕД ТЕСТИРОВАНИЕМ') {
                              PersonMidPoint.personMidPoint = 9;
                            } else if (args.title == 'САМООЦЕНКА РЕЛАКСАЦИИ') {
                              PersonRelaxPoint.personRelaxPoint = 1;
                            } else if (args.title == 'САМООЦЕНКА АКТИВАЦИИ') {
                              PersonActivationPoint.personActivationPoint = 9;
                            } else if (args.title ==
                                'САМООЦЕНКА КОНЦЕНТРАЦИИ') {
                              PersonConcentrationPoint
                                  .personConcentrartionPoint = 9;
                            }
                            setState(() {
                              pressAttention[0] = false;
                              pressAttention[1] = false;
                              pressAttention[2] = false;
                              pressAttention[3] = false;
                              pressAttention[4] = false;
                              pressAttention[5] = false;
                              pressAttention[6] = false;
                              pressAttention[7] = false;
                              pressAttention[8] = false;
                              pressAttention[9] = !pressAttention[9];
                              pressAttention[10] = false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              backgroundColor: pressAttention[9]
                                  ? Colors.grey
                                  : const Color(0xffc8192a)),
                          child: const Text('')),
                    ),
                    const SizedBox(
                      height: buttonSpacing,
                    ),
                    const Text(
                      '9',
                      style: TextStyle(
                          color: Color.fromARGB(255, 87, 68, 87),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: buttonHeight,
                      width: buttonWidth,
                      child: ElevatedButton(
                          onPressed: () {
                            if (args.title ==
                                'САМООЦЕНКА ТЕКУЩЕГО СОСТОЯНИЯ ТЕСТИРУЕМОГО ПЕРЕД ТЕСТИРОВАНИЕМ') {
                              PersonMidPoint.personMidPoint = 10;
                            } else if (args.title == 'САМООЦЕНКА РЕЛАКСАЦИИ') {
                              PersonRelaxPoint.personRelaxPoint = 0;
                            } else if (args.title == 'САМООЦЕНКА АКТИВАЦИИ') {
                              PersonActivationPoint.personActivationPoint = 10;
                            } else if (args.title ==
                                'САМООЦЕНКА КОНЦЕНТРАЦИИ') {
                              PersonConcentrationPoint
                                  .personConcentrartionPoint = 10;
                            }
                            setState(() {
                              pressAttention[0] = false;
                              pressAttention[1] = false;
                              pressAttention[2] = false;
                              pressAttention[3] = false;
                              pressAttention[4] = false;
                              pressAttention[5] = false;
                              pressAttention[6] = false;
                              pressAttention[7] = false;
                              pressAttention[8] = false;
                              pressAttention[9] = false;
                              pressAttention[10] = !pressAttention[10];
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const RoundedRectangleBorder(),
                              backgroundColor: pressAttention[10]
                                  ? Colors.grey
                                  : const Color(0xffae0e16)),
                          child: const Text('')),
                    ),
                    const SizedBox(
                      height: buttonSpacing,
                    ),
                    const Text(
                      '10',
                      style: TextStyle(
                          color: Color.fromARGB(255, 87, 68, 87),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            Expanded(
                child: Align(
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
                          Navigator.of(context).pushNamed('/');
                        },
                        child: const Text('Назад')),
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
                          if (args.title ==
                              'САМООЦЕНКА ТЕКУЩЕГО СОСТОЯНИЯ ТЕСТИРУЕМОГО ПЕРЕД ТЕСТИРОВАНИЕМ') {
                            Navigator.of(context).pushNamed('/chartPage');
                          } else if (args.title == 'САМООЦЕНКА РЕЛАКСАЦИИ') {
                            Navigator.of(context).pushReplacementNamed(
                                '/statusPage',
                                arguments:
                                    ScreenArguments('САМООЦЕНКА АКТИВАЦИИ'));
                          } else if (args.title == 'САМООЦЕНКА АКТИВАЦИИ') {
                            Navigator.of(context).pushReplacementNamed(
                                '/statusPage',
                                arguments:
                                    ScreenArguments('САМООЦЕНКА КОНЦЕНТРАЦИИ'));
                          } else if (args.title == 'САМООЦЕНКА КОНЦЕНТРАЦИИ') {
                            Navigator.of(context).pushNamed('/finalChartPage');
                          }
                        },
                        child: const Text('Вперёд')),
                  )
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.of(context).pushNamed('/statusPage');
                  //     },
                  //     child: const Text('Вперед'))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class ScreenArguments {
  final String title;

  ScreenArguments(this.title);
}
