import 'package:fama/Provider/TimeSlot.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class Locations extends StatelessWidget {

  Future<List<String>> _viewData() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    var notes = new List<String>();
    await Firestore.instance
        .collection("users")
        .document(firebaseUser.email)
        .collection("locations")
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        notes.add(result.documentID);
      });
    });
    return notes;
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<String> values = snapshot.data;
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
              title: Text(values[index], style: GoogleFonts.libreBaskerville()),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => new TimeSlot(values[index]),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFF506A32),
        title: new Text("Choose a branch", style: GoogleFonts.libreBaskerville()),
      ),
      body: futureBuilder,
    );
  }
}
