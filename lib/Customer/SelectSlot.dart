import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

List _elements = [
  {'slot': '10 - 11', 'day': 'Sun'},
  {'slot': '11 - 12', 'day': 'Sun'},
  {'slot': '1 - 2', 'day': 'Mon'},
  {'slot': '2 - 3', 'day': 'Mon'},
  {'slot': '3 - 4', 'day': 'Tues'},
  {'slot': '4 - 5', 'day': 'Tues'},
];

class SelectSlot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF506A32),
          title: Text('Available Timesolts'),
        ),
        body: GroupedListView<dynamic, String>(
          groupBy: (element) => element['day'],
          elements: _elements,
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
            return Card(
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                child: ListTile(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Icon(Icons.access_time),
                  title: Text(element['slot']),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: (){},
                ),
              ),
            );
          },
        ),
      );
  }
}