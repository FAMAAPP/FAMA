import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QRGenerator extends StatefulWidget {
  var day, start, end, account, branch, market, currentDay, index;

  QRGenerator(this.day, this.start, this.end, this.account, this.market,
      this.branch, this.currentDay, this.index);

  @override
  _QRGeneratorState createState() => _QRGeneratorState(
      day, start, end, account, market, branch, currentDay, index);
}

class _QRGeneratorState extends State<QRGenerator> {
  var day, start, end, account, branch, market, currentDay, index;
  bool confirmed = false;

  _QRGeneratorState(
      day, start, end, account, market, branch, currentDay, index) {
    this.day = day;
    this.start = start;
    this.end = end;
    this.market = market;
    this.branch = branch;
    this.account = account;
    this.currentDay = currentDay;
    this.index = index;
  }

  Widget getConf() {
    if (confirmed) {
      return QrImage(
        data: '{}',
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
      );
    }
    return Spacer();
  }

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
            SizedBox(
              height: 1,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text("Please show this to the store employee"),
                  Text("Day: $day"),
                  Text("Time: from $start to $end"),
                  Text("Location: $branch, $market"),
                  Text("Press Confirm to get your QR code"),
                ],
              ),
            ),
            confirmed
                ? QrImage(
                    data: '{}',
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
                  )
                : Container(),
            SizedBox(
              width: 200,
              child: new RaisedButton(
                textColor: Colors.white,
                color: Color(0xFF506A32),
                onPressed: () async {
                  setState(() {
                    confirmed = true;
                  });

                  var data = await Firestore.instance
                      .collection("users")
                      .document(account)
                      .collection("locations")
                      .document(branch)
                      .get()
                      .then((value) => value.data);

                  int count =
                      data['slots'][currentDay]['timeslots'][index]['count'];
                  if (count <= 0)
                    return;
                  else {
                    count = data['slots'][currentDay]['timeslots'][index]
                            ['count'] -
                        1;
                    data['slots'][currentDay]['timeslots'][index]['count'] =
                        count;
                    var updatedData = data;
                    print(updatedData);
                    await Firestore.instance
                        .collection("users")
                        .document(account)
                        .collection("locations")
                        .document(branch)
                        .updateData(updatedData);
                  }
                },
                child:
                    new Text("Confirm", style: GoogleFonts.libreBaskerville()),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(22 / 2),
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
