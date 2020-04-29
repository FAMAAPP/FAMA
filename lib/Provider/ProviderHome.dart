import 'package:flutter/material.dart';
import '../auth.dart';
import 'AddPlace.dart';
import 'Locations.dart';
import './QRScanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fama/Provider/QRtoData.dart';
import 'package:provider/provider.dart';

class ProviderHomePage extends StatelessWidget {

  ProviderHomePage({this.auth, this.onSignOut});

  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    void _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
      } catch (e) {
        print(e);
      }
    }

    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          backgroundColor: Color(0xFF506A32),
          title: Text("Provider",  style: GoogleFonts.libreBaskerville(fontSize: 18,
              fontWeight: FontWeight.w800)),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            new FlatButton(
                onPressed: _signOut,
                child: new Text('Logout',
                    style: GoogleFonts.libreBaskerville(fontSize: 17.0, color: Colors.white)))
          ],
        ),
        body: new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.asset("assets/images/logo.jpg", height: 280, width: 280,),
              SizedBox(
                width: 230,
                child: new RaisedButton(
                  textColor: Colors.white,
                  color: Color(0xFF506A32),
                  onPressed:  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => new AddPlaceButton(),
                      ),
                    );
                  },
                  child: new Text("Add Branch", style: GoogleFonts.libreBaskerville(fontSize: 15)),
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(44 / 2),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 230,
                child: new RaisedButton(
                  textColor: Colors.white,
                  color: Color(0xFF506A32),
                  onPressed:  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => new Locations(),
                      ),
                    );
                  },
                  child: new Text("View Schedule", style: GoogleFonts.libreBaskerville(fontSize: 15)),
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(44 / 2),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 230,
                child: new RaisedButton(
                  textColor: Colors.white,
                  color: Color(0xFF506A32),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChangeNotifierProvider<QRtoData>(
                          create: (context) => QRtoData(),
                          child: QRScanner(),
                        ),
                        )
                    );
                  },
                  child: new Text("QR Scanner", style: GoogleFonts.libreBaskerville(fontSize: 15)),
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
      ),
    );
  }
}