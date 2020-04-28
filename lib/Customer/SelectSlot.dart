import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

List _elements = [
  {'day': 'Mon'},
  {'day': 'Thu'},
  {'day': 'Wed'},
  {'day': 'Thu'},
  {'day': 'Fri'},
  {'day': 'Sat'},
  {'day': 'Sun'},
];

class SelectSlot extends StatelessWidget {
  SelectSlot({this.storeId});
  final storeId;

  Future<List> _getStoreData(String storeId) async {
    List toReturn = List();
    final stores = Firestore.instance.collection("Stores").document(storeId);
    final x = await stores.get().then((store) {
      print(store.data["availableSchedule"][0].keys);
      for(var i = 0; i < 7; ++i) {
        toReturn.add({
          "slots": store.data["availableSchedule"][i].keys,
          "cap": store.data["storeCapacityPerSlot"],
          "day": _elements[i]["day"]
        });
      }
    });
//    print(x);
    return toReturn;
  }
  Widget build(BuildContext context) {
    final data = _getStoreData(storeId);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF506A32),
          title: Text('Available Timesolts'),
        ),
        body: FutureBuilder(
          future: _getStoreData(storeId),
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
        )
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
//    print(snapshot.data);
//    return Container();
    return GroupedListView<dynamic, String>(
      groupBy: (days) => days['day'],
      elements: snapshot.data,
      sort: false,
      useStickyGroupSeparators: true,
      groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
      ),
    itemBuilder: (c, element) {
        print(c);
        return Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            child: ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Icon(Icons.access_time),
              title: Text(element['slots'].toString()),
              trailing: Icon(Icons.arrow_forward),
              onTap: (){},
            ),
          ),
        );
      },
    );

  }
}


//    body: GroupedListView<dynamic, String>(
//      groupBy: (element) => element['day'],
//      elements: () async => await _getStoreData(storeId),
//      sort: false,
//      useStickyGroupSeparators: true,
//      groupSeparatorBuilder: (String value) => Padding(
//        padding: const EdgeInsets.all(8.0),
//        child: Center(
//            child: Text(
//              value,
//              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//            )),
//      ),
//
//    ),