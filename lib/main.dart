import 'package:flutter/material.dart';
import 'package:universo_marvel/utils/constants.dart';

import 'app/app_settings.dart';
import 'app/application.dart';
import 'di/dependecy_injection.dart';
import 'home/view/home_page.dart';

void main() {

  final AppSettings appSettings = AppSettings(
    url: Constants.url,
  );
  Application().appSettings = appSettings;
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'home',
      routes: <String, WidgetBuilder>{
        'home': (BuildContext context) => const HomePage(),
      },
    );
  }
}

