import 'package:flutter/material.dart';
import './root_page.dart';
import './auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Landing extends StatelessWidget {

  static String accountType = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Login as", style: GoogleFonts.libreBaskerville(),),
        actions: <Widget>[],
        backgroundColor: Color(0xFF506A32),
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: new RaisedButton(
                textColor: Colors.white,
                color: Color(0xFF506A32),
                onPressed: () {
                  accountType = "Customer";
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => new RootPage(auth: new Auth(),),
                    ),
                  );
                },
                child: new Text("Customer", style: GoogleFonts.libreBaskerville()),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(44 / 2),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: new RaisedButton(
                textColor: Colors.white,
                color: Color(0xFF506A32),
                onPressed: () {
                  accountType = "Provider";
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => new RootPage(auth: new Auth(),),
                    ),
                  );
                },
                child: new Text("Provider", style: GoogleFonts.libreBaskerville()),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(44 / 2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}