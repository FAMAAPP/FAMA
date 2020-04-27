import 'package:flutter/material.dart';
import '../auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tuple/tuple.dart';
import '../Customer/SelectSlot.dart';
import 'package:google_fonts/google_fonts.dart';

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
    Future<List<Tuple2<String, String>>> _viewData() async {
      var db = Firestore.instance;
      var notes = new List<Tuple2<String, String>>();
      List<String> ids = await CustomerHomePage._ids();

      print(ids);
      // print("here");
      for (String i in ids) {
        await db
            .collection("users")
            .document(i)
            .collection("locations")
            .getDocuments()
            .then((querySnapshot) {
          querySnapshot.documents.forEach((result) async {
            notes.add(Tuple2<String, String>(
                result.data['name'].toString(), result.documentID));
            print(Tuple2<String, String>(
                result.data['name'].toString(), result.documentID));
          });
        });
      }
      return notes;
    }

    Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
      List<Tuple2<String, String>> values = snapshot.data;
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
                    values[index].item1 + ', branch: ' + values[index].item2,
                    style: GoogleFonts.libreBaskerville()),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => new SelectSlot(),
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
