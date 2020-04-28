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
                "start": "6 AM",
                "end": "7 AM"
              },
              {
                "count": 5,
                "start": "7 AM",
                "end": "8 AM"
              },
              {
                "count": 5,
                "start": "8 AM",
                "end": "9 AM"
              },
              {
                "count": 5,
                "start": "9 AM",
                "end": "10 AM"
              },
              {
                "count": 5,
                "start": "10 AM",
                "end": "11 AM"
              },
              {
                "count": 5,
                "start": "11 AM",
                "end": "12 PM "
              },
            ]
          },
          {
            "day" : "Mon",
            "timeslots" :
            [
              {
                "count": 5,
                "start": "6 AM",
                "end": "7 AM"
              },
              {
                "count": 5,
                "start": "7 AM",
                "end": "8 AM"
              },
              {
                "count": 5,
                "start": "8 AM",
                "end": "9 AM"
              },
              {
                "count": 5,
                "start": "9 AM",
                "end": "10 AM"
              },
              {
                "count": 5,
                "start": "10 AM",
                "end": "11 AM"
              },
              {
                "count": 5,
                "start": "11 AM",
                "end": "12 PM "
              },
            ]
          },
          {
            "day" : "Tues",
            "timeslots" :
            [
              {
                "count": 5,
                "start": "6 AM",
                "end": "7 AM"
              },
              {
                "count": 5,
                "start": "7 AM",
                "end": "8 AM"
              },
              {
                "count": 5,
                "start": "8 AM",
                "end": "9 AM"
              },
              {
                "count": 5,
                "start": "9 AM",
                "end": "10 AM"
              },
              {
                "count": 5,
                "start": "10 AM",
                "end": "11 AM"
              },
              {
                "count": 5,
                "start": "11 AM",
                "end": "12 PM "
              },
            ]
          },
          {
            "day" : "Wed",
            "timeslots" :
            [
              {
                "count": 5,
                "start": "6 AM",
                "end": "7 AM"
              },
              {
                "count": 5,
                "start": "7 AM",
                "end": "8 AM"
              },
              {
                "count": 5,
                "start": "8 AM",
                "end": "9 AM"
              },
              {
                "count": 5,
                "start": "9 AM",
                "end": "10 AM"
              },
              {
                "count": 5,
                "start": "10 AM",
                "end": "11 AM"
              },
              {
                "count": 5,
                "start": "11 AM",
                "end": "12 PM "
              },
            ]
          },
          {
            "day" : "Thu",
            "timeslots" :
            [
              {
                "count": 5,
                "start": "6 AM",
                "end": "7 AM"
              },
              {
                "count": 5,
                "start": "7 AM",
                "end": "8 AM"
              },
              {
                "count": 5,
                "start": "8 AM",
                "end": "9 AM"
              },
              {
                "count": 5,
                "start": "9 AM",
                "end": "10 AM"
              },
              {
                "count": 5,
                "start": "10 AM",
                "end": "11 AM"
              },
              {
                "count": 5,
                "start": "11 AM",
                "end": "12 PM "
              },
            ]
          },
          {
            "day" : "Fri",
            "timeslots" :
            [
              {
                "count": 5,
                "start": "6 AM",
                "end": "7 AM"
              },
              {
                "count": 5,
                "start": "7 AM",
                "end": "8 AM"
              },
              {
                "count": 5,
                "start": "8 AM",
                "end": "9 AM"
              },
              {
                "count": 5,
                "start": "9 AM",
                "end": "10 AM"
              },
              {
                "count": 5,
                "start": "10 AM",
                "end": "11 AM"
              },
              {
                "count": 5,
                "start": "11 AM",
                "end": "12 PM "
              },
            ]
          },
          {
            "day" : "Sat",
            "timeslots" :
            [
              {
                "count": 5,
                "start": "6 AM",
                "end": "7 AM"
              },
              {
                "count": 5,
                "start": "7 AM",
                "end": "8 AM"
              },
              {
                "count": 5,
                "start": "8 AM",
                "end": "9 AM"
              },
              {
                "count": 5,
                "start": "9 AM",
                "end": "10 AM"
              },
              {
                "count": 5,
                "start": "10 AM",
                "end": "11 AM"
              },
              {
                "count": 5,
                "start": "11 AM",
                "end": "12 PM "
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
          title: Text('Add Place', style: GoogleFonts.libreBaskerville()),
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
                    labelText: 'Name',
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
                    labelText: 'Address',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
              ),
              SizedBox(
                width: 200,
                child: new RaisedButton(
                  textColor: Colors.white,
                  color: Color(0xFF506A32),
                  onPressed: addData,
                  child: new Text("Add", style: GoogleFonts.libreBaskerville()),
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
