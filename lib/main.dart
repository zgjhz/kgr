import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'chart_page.dart';
import 'final_chart_page.dart';
import 'manual_page.dart';
import 'status_page.dart';
import 'review_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //setWindowTitle('My App');
  //setWindowMaxSize(const Size(2400, 1500));
  //setWindowMinSize(const Size(1820, 1080));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/': (context) => const ManualPage(),
        '/statusPage': (context) => const StatusPage(),
        '/chartPage': (context) => const MyHomePage(title: 'График'),
        '/finalChartPage': (context) => const FinalChartPage(),
        '/reviewPage': (context) => const ReviewPage()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
