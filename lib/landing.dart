import 'package:flutter/material.dart';
import './root_page.dart';
import './auth.dart';

class Landing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Login as"),
        actions: <Widget>[],
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: new RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => new RootPage(auth: new Auth(), loginType: "Customers",),
                    ),
                  );
                },
                child: new Text("Customer"),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(44 / 2),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: new RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => new RootPage(auth: new Auth(), loginType: "Providers",),
                    ),
                  );
                },
                child: new Text("Provider"),
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
