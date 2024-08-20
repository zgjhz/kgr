import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'chart_page.dart';
import 'final_chart_page.dart';
import 'manual_page.dart';
import 'status_page.dart';
import 'review_page.dart';
import 'package:window_manager/window_manager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Инициализация window_manager
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1920, 1080),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setFullScreen(true);
    await windowManager.show();
    //await windowManager.focus();
  });
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
