import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../primary_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPlaceButton extends StatefulWidget {
  @override
  _AddPlaceButton createState() => _AddPlaceButton();
}

class _AddPlaceButton extends State<AddPlaceButton> {
  TextEditingController nameController = TextEditingController();
  TextEditingController newLocation = TextEditingController();
  Map<String, Object> data;

  void addData() async{
    data =
    {
      "name" : nameController.text,
        "slots":
        [
          {

            "day": "Sun",
            "timeslots":
            [
              {
                "count": 5,
                "start": "6 AM",
                "end": "7 AM"
              },
              {
                "start": "7 AM",
                "end": "8 AM"
              },
              {
                "start": "8 AM",
                "end": "9 AM"
              },
              {
                "start": "9 AM",
                "end": "10 AM"
              },
              {
                "start": "10 AM",
                "end": "11 AM"
              },
              {
                "start": "11 AM",
                "end": "12 PM"
              },
            ]
          },
          {
            "count": 5,
            "day": "Mon",
            "timeslots":
            [
              {
                "start": "6 AM",
                "end": "7 AM"
              },
              {
                "start": "7 AM",
                "end": "8 AM"
              },
              {
                "start": "8 AM",
                "end": "9 AM"
              },
              {
                "start": "9 AM",
                "end": "10 AM"
              },
              {
                "start": "10 AM",
                "end": "11 AM"
              },
              {
                "start": "11 AM",
                "end": "12 PM"
              },
            ]
          },
          {
            "count": 5,
            "day": "Tues",
            "timeslots":
            [
              {
                "start": "6 AM",
                "end": "7 AM"
              },
              {
                "start": "7 AM",
                "end": "8 AM"
              },
              {
                "start": "8 AM",
                "end": "9 AM"
              },
              {
                "start": "9 AM",
                "end": "10 AM"
              },
              {
                "start": "10 AM",
                "end": "11 AM"
              },
              {
                "start": "11 AM",
                "end": "12 PM"
              },
            ]
          },
          {
            "count": 5,
            "day": "Wed",
            "timeslots":
            [
              {
                "start": "6 AM",
                "end": "7 AM"
              },
              {
                "start": "7 AM",
                "end": "8 AM"
              },
              {
                "start": "8 AM",
                "end": "9 AM"
              },
              {
                "start": "9 AM",
                "end": "10 AM"
              },
              {
                "start": "10 AM",
                "end": "11 AM"
              },
              {
                "start": "11 AM",
                "end": "12 PM"
              },
            ]
          },
          {
            "count": 5,
            "day": "Thu",
            "timeslots":
            [
              {
                "start": "6 AM",
                "end": "7 AM"
              },
              {
                "start": "7 AM",
                "end": "8 AM"
              },
              {
                "start": "8 AM",
                "end": "9 AM"
              },
              {
                "start": "9 AM",
                "end": "10 AM"
              },
              {
                "start": "10 AM",
                "end": "11 AM"
              },
              {
                "start": "11 AM",
                "end": "12 PM"
              },
            ]
          },
          {
            "count": 5,
            "day": "Fri",
            "timeslots":
            [
              {
                "start": "6 AM",
                "end": "7 AM"
              },
              {
                "start": "7 AM",
                "end": "8 AM"
              },
              {
                "start": "8 AM",
                "end": "9 AM"
              },
              {
                "start": "9 AM",
                "end": "10 AM"
              },
              {
                "start": "10 AM",
                "end": "11 AM"
              },
              {
                "start": "11 AM",
                "end": "12 PM"
              },
            ]
          },
          {
            "count": 5,
            "day": "Sat",
            "timeslots":
            [
              {
                "start": "6 AM",
                "end": "7 AM"
              },
              {
                "start": "7 AM",
                "end": "8 AM"
              },
              {
                "start": "8 AM",
                "end": "9 AM"
              },
              {
                "start": "9 AM",
                "end": "10 AM"
              },
              {
                "start": "10 AM",
                "end": "11 AM"
              },
              {
                "start": "11 AM",
                "end": "12 PM"
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
          title: Text('Add Place'),
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
              PrimaryButton(
                  key: new Key('Add'),
                  text: 'Add',
                  height: 44.0,
                  onPressed: addData,
                  ),
            ],
          ),
        ),
      );
  }
}
