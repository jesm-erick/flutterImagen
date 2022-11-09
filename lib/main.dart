import 'package:app_upeu/login/login_google.dart';
import 'package:app_upeu/theme/AppTheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO; Implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Upeu",
        theme: AppTheme.themeData,
        home: MainLogin());
  }
}
