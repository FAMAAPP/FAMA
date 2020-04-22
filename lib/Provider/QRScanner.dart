import 'dart:typed_data';

import 'QRtoData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart';

class QRScanner extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final userData = Provider.of<QRtoData>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QR Scanner',
          style: TextStyle(
            fontSize: 23,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 10),
            Consumer<QRtoData>(
              builder: (_, data, __) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Text(
                    '${data.QRScanResult != null? data.QRScanResult : ""}',
                    style: TextStyle(
                      fontSize: 28,
                      letterSpacing: 2,
                    ),
                ),
            ),
              ),
            ),
            SizedBox(height: 28),
            RaisedButton.icon(
              onPressed: () => userData.analyzeResult(),
              icon: Icon(Icons.camera_alt),
              label: Text("Scan QR Code"),
            ),
          ],
        ),
      ),
    );
  }
}
