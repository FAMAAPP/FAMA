import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';

class AddPlaceButton extends StatefulWidget {
  @override
  _AddPlaceButton createState() => _AddPlaceButton();
}

class _AddPlaceButton extends State<AddPlaceButton> {
  TextEditingController nameController = TextEditingController();
  TextEditingController newLocation = TextEditingController();
  Map<String, Object> data;

  void addData() async{
    final currentLocation = await Location().getLocation();
    final point = GeoPoint(currentLocation.latitude, currentLocation.longitude);
    data =
    {
      "name" : nameController.text,
      "branchLocation" : point,
      "slots" :
      [
        {
          "day" : "Sun",
          "timeslots" :
          [
            {
              "count": 5,
              "start": "6:00 AM",
              "end": "7:00 AM"
            },
            {
              "count": 5,
              "start": "7:00 AM",
              "end": "8:00 AM"
            },
            {
              "count": 5,
              "start": "8:00 AM",
              "end": "9:00 AM"
            },
            {
              "count": 5,
              "start": "9:00 AM",
              "end": "10:00 AM"
            },
            {
              "count": 5,
              "start": "10:00 AM",
              "end": "11:00 AM"
            },
            {
              "count": 5,
              "start": "11:00 AM",
              "end": "12:00 PM "
            },
          ]
        },
        {
          "day" : "Mon",
          "timeslots" :
          [
            {
              "count": 5,
              "start": "6:00 AM",
              "end": "7:00 AM"
            },
            {
              "count": 5,
              "start": "7:00 AM",
              "end": "8:00 AM"
            },
            {
              "count": 5,
              "start": "8:00 AM",
              "end": "9:00 AM"
            },
            {
              "count": 5,
              "start": "9:00 AM",
              "end": "10:00 AM"
            },
            {
              "count": 5,
              "start": "10:00 AM",
              "end": "11:00 AM"
            },
            {
              "count": 5,
              "start": "11:00 AM",
              "end": "12:00 PM "
            },
          ]
        },
        {
          "day" : "Tues",
          "timeslots" :
          [
            {
              "count": 5,
              "start": "6:00 AM",
              "end": "7:00 AM"
            },
            {
              "count": 5,
              "start": "7:00 AM",
              "end": "8:00 AM"
            },
            {
              "count": 5,
              "start": "8:00 AM",
              "end": "9:00 AM"
            },
            {
              "count": 5,
              "start": "9:00 AM",
              "end": "10:00 AM"
            },
            {
              "count": 5,
              "start": "10:00 AM",
              "end": "11:00 AM"
            },
            {
              "count": 5,
              "start": "11:00 AM",
              "end": "12:00 PM "
            },
          ]
        },
        {
          "day" : "Wed",
          "timeslots" :
          [
            {
              "count": 5,
              "start": "6:00 AM",
              "end": "7:00 AM"
            },
            {
              "count": 5,
              "start": "7:00 AM",
              "end": "8:00 AM"
            },
            {
              "count": 5,
              "start": "8:00 AM",
              "end": "9:00 AM"
            },
            {
              "count": 5,
              "start": "9:00 AM",
              "end": "10:00 AM"
            },
            {
              "count": 5,
              "start": "10:00 AM",
              "end": "11:00 AM"
            },
            {
              "count": 5,
              "start": "11:00 AM",
              "end": "12:00 PM "
            },
          ]
        },
        {
          "day" : "Thu",
          "timeslots" :
          [
            {
              "count": 5,
              "start": "6:00 AM",
              "end": "7:00 AM"
            },
            {
              "count": 5,
              "start": "7:00 AM",
              "end": "8:00 AM"
            },
            {
              "count": 5,
              "start": "8:00 AM",
              "end": "9:00 AM"
            },
            {
              "count": 5,
              "start": "9:00 AM",
              "end": "10:00 AM"
            },
            {
              "count": 5,
              "start": "10:00 AM",
              "end": "11:00 AM"
            },
            {
              "count": 5,
              "start": "11:00 AM",
              "end": "12:00 PM "
            },
          ]
        },
        {
          "day" : "Fri",
          "timeslots" :
          [
            {
              "count": 5,
              "start": "6:00 AM",
              "end": "7:00 AM"
            },
            {
              "count": 5,
              "start": "7:00 AM",
              "end": "8:00 AM"
            },
            {
              "count": 5,
              "start": "8:00 AM",
              "end": "9:00 AM"
            },
            {
              "count": 5,
              "start": "9:00 AM",
              "end": "10:00 AM"
            },
            {
              "count": 5,
              "start": "10:00 AM",
              "end": "11:00 AM"
            },
            {
              "count": 5,
              "start": "11:00 AM",
              "end": "12:00 PM "
            },
          ]
        },
        {
          "day" : "Sat",
          "timeslots" :
          [
            {
              "count": 5,
              "start": "6:00 AM",
              "end": "7:00 AM"
            },
            {
              "count": 5,
              "start": "7:00 AM",
              "end": "8:00 AM"
            },
            {
              "count": 5,
              "start": "8:00 AM",
              "end": "9:00 AM"
            },
            {
              "count": 5,
              "start": "9:00 AM",
              "end": "10:00 AM"
            },
            {
              "count": 5,
              "start": "10:00 AM",
              "end": "11:00 AM"
            },
            {
              "count": 5,
              "start": "11:00 AM",
              "end": "12:00 PM "
            },
          ]
        },
      ]
    };

    var firebaseUser = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection("users").
    document(firebaseUser.email).
    collection("locations").
    document(newLocation.text).
    setData(data, merge : true).
    then((_){print("success!");});

    nameController.text = '';
    newLocation.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Branch', style: GoogleFonts.libreBaskerville(fontSize: 18, fontWeight: FontWeight.w800)),
        backgroundColor: Color(0xFF506A32),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Branch Name',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                controller: newLocation,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Branch Address',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
            ),
            SizedBox(
              width: 230,
              child: new RaisedButton(
                textColor: Colors.white,
                color: Color(0xFF506A32),
                onPressed: addData,
                child: new Text("Add", style: GoogleFonts.libreBaskerville(fontSize: 15)),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(44 / 2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}