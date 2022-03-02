import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/home.dart';

void main() {
  runApp(MyApp());
  GestureBinding.instance.resamplingEnabled = true;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          //brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              toolbarTextStyle: TextStyle(fontSize: 18),
              titleTextStyle: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 18))),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.black87,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            centerTitle: true,
            toolbarTextStyle: TextStyle(fontSize: 18),
            titleTextStyle: TextStyle(color: Colors.white24, fontWeight: FontWeight.w600, fontSize: 18),
          )),
      home: HomePage(),
    );
  }
}
