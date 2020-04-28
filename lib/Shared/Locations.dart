import 'package:fama/Provider/TimeSlot.dart';
import 'package:fama/auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fama/Customer/SelectSlot.dart';

class Locations extends StatelessWidget {
  Locations({this.auth, this.customerReq});
  final BaseAuth auth;
  final String customerReq;

  Future<List> _storeViewData() async {
    var notes = new List();
    await Firestore.instance.collection("Stores").getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
//        print(result.data["storeName"]);
//        print(result.documentID);
//        print({"storeName": result.data, "storeId": result.documentID}["storeName"]);
        notes.add({"storeName": result.data["storeName"], "storeId": result.documentID});
      });
    });

    return notes;
  }
  Future<List> _customerViewData() async {
    var notes = new List();
    final storesBatabaseRef = await Firestore.instance.collection("Providers").
    document(await auth.currentUser()).get().then((doc) => doc.data["stores"]);

//    await Firestore.instance.collection("Stores").getDocuments()
//        .then((querySnapshot) {
//      querySnapshot.documents.forEach((result) {
//        print(result.data["storeName"]);
//        print(result.documentID);
//        notes.add(result.data["storeName"]);
//      });
//    });
    for(var i = 0; i < storesBatabaseRef.length; ++i ){
      final store = await storesBatabaseRef[i].get();
      final data = await store.data;
      notes.add(data["storeName"]);
    }

    return notes;
  }

  Future<List> _providerViewData() async {
    var notes = new List();
    final arrayOfStoreSnapshotDocuments = await Firestore.instance.collection("Providers").
    document(await auth.currentUser()).get().then((doc) => doc.data["stores"]);

    for(var i = 0; i <  arrayOfStoreSnapshotDocuments.length; ++i ){
      final store = await arrayOfStoreSnapshotDocuments[i].get();
      final data = await store.data;
      notes.add(data["storeName"]);
    }

    return notes;
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List values = snapshot.data;
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
              title: Text(values[index]["storeName"]),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => auth.userType() == "Providers" ? TimeSlot(): SelectSlot(storeId: values[index]["storeId"],),
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
      future: auth.userType() == "Providers" ?_providerViewData(): _storeViewData(),
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
        title: new Text("Choose a branch"),
      ),
      body: futureBuilder,
    );
  }
}
