import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TimeSlot extends StatefulWidget {
  @override
  _timeslotState createState() => _timeslotState();
}

class _timeslotState extends State<TimeSlot> {
  var _curIndex = 0;
  var contents = "Home";
  var green = Color(0xFF506A32);
  var white = Colors.white;
  var black = Colors.black;
  int currentDay = 1;
  bool slotSelected = false;

  dayPressed(int n) {
    setState(() {
      currentDay = n;
    });
  }

  Widget _indexBottom() => BottomNavigationBar(
        backgroundColor: Color(0xFFFFFFFF),
        items: [
          BottomNavigationBarItem(
            title: Text(
              "Address",
              style: TextStyle(color: Colors.black),
            ),
            icon: Icon(
              Icons.check_circle,
              color: Color(0xFF506A32),
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              "Timeslot",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            icon: Icon(
              Icons.check_circle,
              color: Color(0xFF506A32),
              size: 30,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              "Complete",
            ),
            icon: Icon(
              Icons.check_circle_outline,
              size: 30,
            ),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _curIndex,
      );

  /* List<String> date = ['1', '2 ', '3', '4', '5', '6', '7'];
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  Text(
                    "Select Timeslot",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            _indexBottom(),
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
                        color: currentDay == 1 ? green : white,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Sun",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: currentDay == 1 ? white : black),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "9",
                              style: TextStyle(
                                  fontSize: 17,
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
                              "Mon",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: currentDay == 2 ? white : black),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "10",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: currentDay == 2 ? white : black),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        dayPressed(2);
                      },
                    ),
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
                                "Tues",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: currentDay == 3 ? white : black),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "11",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: currentDay == 3 ? white : black),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          dayPressed(3);
                        }),
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
                              "Wed",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: currentDay == 4 ? white : black),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "12",
                              style: TextStyle(
                                  fontSize: 17,
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
                              "Thu",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: currentDay == 5 ? white : black),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "13",
                              style: TextStyle(
                                  fontSize: 17,
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
                              "Fri",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: currentDay == 6 ? white : black),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "14",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: currentDay == 6 ? white : black),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        dayPressed(6);
                      },
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.all(2),
                        color: currentDay == 7 ? green : white,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Sat",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: currentDay == 7 ? white : black),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "15",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: currentDay == 7 ? white : black),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        dayPressed(7);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    if (currentDay == 1)
                      for (var i = 1; i <= 5; i++)
                        InkWell(
                          onTap: () {
                            setState(() {
                              slotSelected = true;
                            });
                          },
                          child: slotSelected
                              ? Container(
                                  /*margin: const EdgeInsets.all(5.0),*/
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      color: Color(0xFFb58a0b)),
                                  //       <--- BoxDecoration here
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "09.00 AM - 01.00 PM   SELECT TIMESLOT",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  //margin: const EdgeInsets.all(5.0),
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                  //       <--- BoxDecoration here
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "09.00 AM - 01.00 PM",
                                        style: TextStyle(fontSize: 13.0),
                                      ),
                                      Spacer(),
                                      Container(
                                        height: 30,
                                        width: 80,
                                        margin: const EdgeInsets.all(3.0),
                                        padding: const EdgeInsets.all(3.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFC13519),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Booked",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                        )
                    else if (currentDay == 2)
                      for (var i = 1; i <= 2; i++)
                        Container(
                          //margin: const EdgeInsets.all(5.0),
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          //       <--- BoxDecoration here
                          child: Row(
                            children: <Widget>[
                              Text(
                                "09.00 AM - 01.00 PM",
                                style: TextStyle(fontSize: 13.0),
                              ),
                              Spacer(),
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
                        )
                    else if (currentDay == 3)
                      for (var i = 1; i <= 3; i++)
                        Container(
                          /*margin: const EdgeInsets.all(5.0),*/
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Color(0xFFb58a0b)),
                          //       <--- BoxDecoration here
                          child: Row(
                            children: <Widget>[
                              Text(
                                "09.00 AM - 01.00 PM   SELECT TIMESLOT",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                              Spacer(),
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        )
                    else if (currentDay == 4)
                      for (var i = 1; i <= 2; i++)
                        Container(
                          //margin: const EdgeInsets.all(5.0),
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          //       <--- BoxDecoration here
                          child: Row(
                            children: <Widget>[
                              Text(
                                "09.00 AM - 01.00 PM",
                                style: TextStyle(fontSize: 13.0),
                              ),
                              Spacer(),
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
                        )
                    else if (currentDay == 5)
                      for (var i = 1; i <= 2; i++)
                        Container(
                          //margin: const EdgeInsets.all(5.0),
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          //       <--- BoxDecoration here
                          child: Row(
                            children: <Widget>[
                              Text(
                                "09.00 AM - 01.00 PM",
                                style: TextStyle(fontSize: 13.0),
                              ),
                              Spacer(),
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
                        )
                    else if (currentDay == 6)
                      for (var i = 1; i <= 3; i++)
                        Container(
                          /*margin: const EdgeInsets.all(5.0),*/
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Color(0xFFb58a0b)),
                          //       <--- BoxDecoration here
                          child: Row(
                            children: <Widget>[
                              Text(
                                "09.00 AM - 01.00 PM   SELECT TIMESLOT",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                              Spacer(),
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        )
                    else
                      for (var i = 1; i <= 3; i++)
                        Container(
                          /*margin: const EdgeInsets.all(5.0),*/
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Color(0xFFb58a0b)),
                          //       <--- BoxDecoration here
                          child: Row(
                            children: <Widget>[
                              Text(
                                "09.00 AM - 01.00 PM   SELECT TIMESLOT",
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                              Spacer(),
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 30,
                              ),
                            ],
                          ),
                        )
                  ],
                ),
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
      ),
    );
  }
}
