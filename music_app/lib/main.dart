import 'package:flutter/material.dart';
import 'package:music_app/api/log_status.dart';
import 'package:music_app/screens/home.dart';
import 'package:music_app/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget initialPage = Login();

  @override
  void initState() {
    super.initState();

    LogStatus().getToken().then(
      (value) {
        if (value.isNotEmpty) {
          LogStatus.token = value;
          setState(() {
            initialPage = Home();
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Laila-Medium",
      ),
      debugShowCheckedModeBanner: false,
      title: 'Music App',
      home: initialPage,
      routes: {
        "/login": (context) => Login(),
        "/home": (context) => Home(),
      },
    );
  }
}
