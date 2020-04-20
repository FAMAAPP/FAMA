import 'package:flutter/material.dart';
import './root_page.dart';
import './auth.dart';


class FirstTab extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new RootPage(auth: new Auth()),
    );
  }
}