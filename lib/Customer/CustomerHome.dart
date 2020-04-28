//color: Color(0xFF506A32),
//onPressed: () {
//Navigator.push(
//context,
//MaterialPageRoute(builder: (context) => QRGenerator(),
//)
//);},
//            title: new Text(" Select your preferred location"),


import 'package:fama/Customer/QRGenerator.dart';
import 'package:fama/Provider/AddStore.dart';
import 'package:fama/Provider/BLoC/Store_bloc.dart';
import 'package:flutter/material.dart';
import '../auth.dart';
import 'package:provider/provider.dart';
import '../Shared/Locations.dart';

class CustomerHomePage extends StatelessWidget {

  CustomerHomePage({this.auth, this.onSignOut});

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
        appBar: new AppBar(
          backgroundColor: Color(0xFF506A32),
          title: Text("Customer"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            new FlatButton(
                onPressed: _signOut,
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)))
          ],
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
                  onPressed:  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => new Locations(auth: this.auth),
                      ),
                    );
                  },
                  child: new Text("Book a Timeslot"),
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
                  onPressed:  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QRGenerator()//new Locations(auth: this.auth),
                      ),
                    );
                    },
                  child: new Text("View Reservation"),
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
