import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class QRGenerator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF506A32),
        title: Text("Your Ticket"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 1,),
            Container(
                child: Column(
                  children: <Widget>[
                    Text("Please Show this to the store employee"),
                    Text("Store: Danube"),
                    Text("Address: Hayat Mall"),
                    Text("Time: 9:00 AM to 10:00 PM"),
                    Text("Date: April 16, 2020"),
                  ],
                ),
            ),
            QrImage(
              data: "Reservation verified!\n\nTime 9:00 AM to 10:00 PM\nDate: April 16, 2020",
              version: QrVersions.auto,
              size: 320,
              gapless: false,
              errorStateBuilder: (cxt, err) {
                return Container(
                  child: Center(
                    child: Text(
                      "Uh oh! Something went wrong...",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 5,),
          ],
        ),
      ),
    );
  }
}
