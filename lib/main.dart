import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './landing.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'FAMA',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Landing(),
    );
  }
}