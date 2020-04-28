import 'package:flutter/material.dart';
import '../auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';
import '../Customer/SelectSlot.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geodesy/geodesy.dart';
import 'package:location/location.dart';

class CustomerHomePage extends StatelessWidget {
  static Future<List<String>> _ids() async {
    List<String> ids = [];
    await Firestore.instance.collection("users").getDocuments().then((value) {
      value.documents.forEach((element) async {
        ids.add(element.documentID);
      });
    });
    return ids;
  }

  CustomerHomePage({this.auth, this.onSignOut});

  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    Future<List<Tuple4<String, String, double, String>>> _viewData() async {
      final db = Firestore.instance;
      final List<String> ids = await CustomerHomePage._ids();
      final locationData = await Location().getLocation();
      final currentPoint =
          LatLng(locationData.latitude, locationData.longitude);
      var notes = new List<Tuple4<String, String, double, String>>();
      ;

      for (String i in ids) {
        await db
            .collection("users")
            .document(i)
            .collection("locations")
            .getDocuments()
            .then((querySnapshot) {
          querySnapshot.documents.forEach((result) async {
            final branchPoint = LatLng(result.data['branchLocation'].latitude,
                result.data['branchLocation'].longitude);

            var dist = (Geodesy()
                    .distanceBetweenTwoGeoPoints(currentPoint, branchPoint) /
                1000.0);

            notes.add(Tuple4<String, String, double, String>(
                result.data['name'].toString(), result.documentID, dist, i));
          });
        });
      }
      notes.sort((a, b) => a.item3.compareTo(b.item3));
      return notes;
    }

    Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
      List<Tuple4<String, String, double, String>> values = snapshot.data;
      return new ListView.builder(
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Icon(Icons.store_mall_directory),
                title: Text(
                    values[index].item1 +
                        ', branch: ' +
                        values[index].item2 +
                        '\n' +
                        values[index].item3.toStringAsFixed(3) +
                        ' KM',
                    style: GoogleFonts.libreBaskerville()),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => new SelectSlot(
                          values[index].item1.toString(),
                          values[index].item2.toString(),
                          values[index].item4.toString()),

                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    }

    void _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
      } catch (e) {
        print(e);
      }
    }

    var futureBuilder = new FutureBuilder(
      future: _viewData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );

    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xFF506A32),
          title: Text("Customer", style: GoogleFonts.libreBaskerville()),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            new FlatButton(
              onPressed: _signOut,
              child: new Text(
                'Logout',
                style: GoogleFonts.libreBaskerville(color: Colors.white),
              ),
            )
          ],
        ),
        body: Scaffold(
          appBar: new AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFF506A32),
            title: new Text(" Select your preferred location",
                style: GoogleFonts.libreBaskerville()),
          ),
          body: futureBuilder,
        ),
      ),
    );
  }
}
