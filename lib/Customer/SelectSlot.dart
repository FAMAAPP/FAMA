/*
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:google_fonts/google_fonts.dart';

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
        title: Text('Available Timesolts', style: GoogleFonts.libreBaskerville()),
      ),
      body: GroupedListView<dynamic, String>(
        groupBy: (element) => element['day'],
        elements: _elements,
        sort: false,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) =>
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                    value,
                    style: GoogleFonts.libreBaskerville(fontSize: 22),
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
                title: Text(element['slot'], style: GoogleFonts.libreBaskerville()),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './QRGenerator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectSlot extends StatefulWidget {
  String market;
  String branch;
  String account;

  SelectSlot(this.market, this.branch, this.account);

  @override
  _SelectSlot createState() =>
      _SelectSlot(this.market, this.branch, this.account);
}

class _SelectSlot extends State<SelectSlot> {
  var contents = "Home";
  final green = Color(0xFF506A32);
  final white = Colors.white;
  final black = Colors.black;
  int currentDay = 0;
  bool slotSelected = false;
  var data;

  String market;
  String branch;
  String account;

  _SelectSlot(market, branch, account) {
    this.market = market;
    this.branch = branch;
    this.account = account;
  }

  Future<Map<String, dynamic>> getFutureData() async {
    Map<String, dynamic> futureData = await Firestore.instance
        .collection("users")
        .document(account)
        .collection('locations')
        .document(branch)
        .get()
        .then((value) => value.data);
    return futureData;
  }

  void dayPressed(int n) {
    setState(() {
      currentDay = n;
    });
  }

  Widget getContainers(var data) {
    var timeslots = data['slots'][currentDay]['timeslots'];
    return new ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: timeslots.length,
      itemBuilder: (BuildContext context, int i) {
        return Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            child: timeslots[i]['count'] > 0
                ? ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Icon(Icons.access_time),
                    title: Text(
                      timeslots[i]['start'] + " to " + timeslots[i]['end'],
                      style: GoogleFonts.libreBaskerville(fontSize: 13.0),
                    ),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => new QRGenerator(
                            data['slots'][currentDay]['day'],
                            timeslots[i]['start'],
                            timeslots[i]['end'],
                            account,
                            market,
                            branch,
                            currentDay,
                            i,
                          ),
                        ),
                      );
                    },
                  )
                : null,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: getFutureData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return creatTimeViewer(context, snapshot);
        }
      },
    );
    return Scaffold(
      body: futureBuilder,
    );
  }

  Widget creatTimeViewer(BuildContext context, AsyncSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data;
    return new SafeArea(
      child: ListView(
        children: <Widget>[
          Container(
            color: Color(0xFF506A32),
            height: 50,
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                SizedBox(width: 24),
                Text("Select your preferred timeslot",
                    style: GoogleFonts.libreBaskerville(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
          ),
          Container(
            child: Card(
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(8)),
                  SizedBox(
                    width: 3,
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(2),
                      color: currentDay == 0 ? green : white,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Sun",
                            style: GoogleFonts.libreBaskerville(
                                fontSize: 15,
                                color: currentDay == 0 ? white : black),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "26",
                            style: GoogleFonts.libreBaskerville(
                                fontSize: 15,
                                color: currentDay == 0 ? white : black),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      dayPressed(0);
                    },
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(2),
                      color: currentDay == 1 ? green : white,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Mon",
                            style: GoogleFonts.libreBaskerville(
                                fontSize: 15,
                                color: currentDay == 1 ? white : black),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "27",
                            style: GoogleFonts.libreBaskerville(
                                fontSize: 15,
                                color: currentDay == 1 ? white : black),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      dayPressed(1);
                    },
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  InkWell(
                      child: Container(
                        padding: EdgeInsets.all(2),
                        color: currentDay == 2 ? green : white,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Tues",
                              style: GoogleFonts.libreBaskerville(
                                  fontSize: 15,
                                  color: currentDay == 2 ? white : black),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "28",
                              style: GoogleFonts.libreBaskerville(
                                  fontSize: 15,
                                  color: currentDay == 2 ? white : black),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        dayPressed(2);
                      }),
                  SizedBox(
                    width: 18,
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(2),
                      color: currentDay == 3 ? green : white,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Wed",
                            style: GoogleFonts.libreBaskerville(
                                fontSize: 15,
                                color: currentDay == 3 ? white : black),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "29",
                            style: GoogleFonts.libreBaskerville(
                                fontSize: 15,
                                color: currentDay == 3 ? white : black),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      dayPressed(3);
                    },
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(2),
                      color: currentDay == 4 ? green : white,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Thu",
                            style: GoogleFonts.libreBaskerville(
                                fontSize: 15,
                                color: currentDay == 4 ? white : black),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "30",
                            style: GoogleFonts.libreBaskerville(
                                fontSize: 15,
                                color: currentDay == 4 ? white : black),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      dayPressed(4);
                    },
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(2),
                      color: currentDay == 5 ? green : white,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Fri",
                            style: GoogleFonts.libreBaskerville(
                                fontSize: 15,
                                color: currentDay == 5 ? white : black),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "1",
                            style: GoogleFonts.libreBaskerville(
                                fontSize: 15,
                                color: currentDay == 5 ? white : black),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      dayPressed(5);
                    },
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(2),
                      color: currentDay == 6 ? green : white,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Sat",
                            style: GoogleFonts.libreBaskerville(
                                fontSize: 15,
                                color: currentDay == 6 ? white : black),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "2",
                            style: GoogleFonts.libreBaskerville(
                                fontSize: 15,
                                color: currentDay == 6 ? white : black),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      dayPressed(6);
                    },
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: getContainers(data),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50.0,
            child: Padding(
              padding: EdgeInsets.only(left: 00.0, right: 00.0),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: 150,
            height: 50,
            child: Padding(
              padding: EdgeInsets.only(left: 60, right: 60),
            ),
          )
        ],
      ),
    );
  }
}
