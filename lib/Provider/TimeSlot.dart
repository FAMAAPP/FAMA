import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeSlot extends StatefulWidget {
  final String branch;

  TimeSlot(this.branch);

  @override
  _timeslotState createState() => _timeslotState(this.branch);
}

class _timeslotState extends State<TimeSlot> {
  var _curIndex = 0;
  var contents = "Home";
  final green = Color(0xFF506A32);
  final white = Colors.white;
  final black = Colors.black;
  int currentDay = 0;
  bool slotSelected = false;
  final branch;
  var data;

  _timeslotState(this.branch);

  Future<Map<String, dynamic>> getFutureData() async {
    var id =
        await FirebaseAuth.instance.currentUser().then((value) => value.email);
    Map<String, dynamic> futureData = await Firestore.instance
        .collection("users")
        .document(id)
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

  List<Widget> getContainers(var data) {
    List<Widget> containers = [];

    var timeslots = data['slots'][currentDay]['timeslots'];

    print(timeslots);
    for (var i = 0; i < timeslots.length; i++)
      containers.add(Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              child: Text(
                timeslots[i]['start'] + " to " + timeslots[i]['end'],
                style: GoogleFonts.libreBaskerville(fontSize: 13.0),
              ),
            ),
            Spacer(),
            if (timeslots[i]['count'] == 0)
              Container(
                height: 30,
                width: 80,
                margin: const EdgeInsets.all(3.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: Color(0xFFC13519),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: Text(
                    "Booked",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
          ],
        ),
      ));

    return containers;
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
                Text("${branch} Branch Schedule",
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
                            "9",
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
                            "10",
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
                              "11",
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
                            "12",
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
                            "13",
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
                            "14",
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
                            "15",
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
              child: Column(children: getContainers(data)),
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
