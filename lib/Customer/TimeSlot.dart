import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class TimeSlot extends StatefulWidget {
  @override
  _timeslotState createState() => _timeslotState();
}

class _timeslotState extends State<TimeSlot> {
  var _curIndex = 0;
  var contents = "Home";

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
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE6D7C3),
              child: Row(
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10.0)),
                  Image.asset(
                    "assets/tracking.png",
                    height: 35,
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "Standard  Delivery Time 9.30 AM to 9.30 PM ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFFFFFFFF),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Delivery Slots Between",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
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
                    Column(
                      children: <Widget>[
                        Text(
                          "Sun",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "09",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.all(2),
                        color: Color(0xFF506A32),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Mon",
                              style: TextStyle(fontSize: 17, color: Colors.white),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "10",
                              style: TextStyle(fontSize: 17, color: Colors.white),
                            ),
                          ],
                        ),
                      ),onTap: (){

                    },
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Tue",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "11",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Wed",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "12",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Thu",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "13",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Fri",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "14",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Sat",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "15",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
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
                    Container(
                      /*margin: const EdgeInsets.all(5.0),
         */
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                      //       <--- BoxDecoration here
                      child: Row(
                        children: <Widget>[
                          Text(
                            "09.00 AM - 01.00 PM",
                            style: TextStyle(fontSize: 13.0),
                          ),
                          Spacer(),
                          Container(
                            /*      color: Color(0xFFC13519),
  */
                            height: 30,
                            width: 80,
                            margin: const EdgeInsets.all(3.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(

                              color: Color(0xFFC13519),
                              borderRadius: BorderRadius.circular(7),),
                            child: Center(
                              child: Text(
                                "Booked",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      /*margin: const EdgeInsets.all(5.0),*/
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          border: Border(

                            left: BorderSide(width: 1,color: Colors.grey),
                            right: BorderSide(width: 1,color: Colors.grey),)),
                      //       <--- BoxDecoration here
                      child: Row(
                        children: <Widget>[
                          Text(
                            "01.00 PM - 05.00 PM",
                            style: TextStyle(fontSize: 13.0),
                          ),
                          Spacer(),
                          Container(
                            /*      color: Color(0xFFC13519),
  */
                            height: 30,
                            width: 80,
                            margin: const EdgeInsets.all(3.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(

                                color: Color(0xFFC13519),
                                borderRadius: BorderRadius.circular(7)),
                            child: Center(
                              child: Text(
                                "Booked",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      /*margin: const EdgeInsets.all(5.0),*/
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey
                          ),
                          color: Color(0xFFb58a0b)),
                      //       <--- BoxDecoration here
                      child: Row(
                        children: <Widget>[
                          Text(
                            "09.00 AM - 01.00 PM   SELECT TIMESLOT",
                            style:
                            TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                          Spacer(),
                          Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
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
                child: RaisedButton(
                  onPressed: () {
                    /* Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => otp()),
        );*/
                  },
                  color: Color(0xFF506A32),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            "1 Item (s)   :   Total : ₹1620",
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                child: RaisedButton(
                  onPressed: () {},
                  color: Color(0xFF506A32),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          "CHECKOUT",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
