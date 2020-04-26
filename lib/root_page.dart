import 'package:flutter/material.dart';
import './auth.dart';
import 'Login.dart';
import 'Provider/ProviderHome.dart';
import 'Customer/CustomerHome.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final providersDatabaseReference = Firestore.instance.collection("Providers");
final customersDatabaseReference = Firestore.instance.collection("Customers");

class RootPage extends StatefulWidget {
  RootPage({Key key, this.auth, this.loginType}) : super(key: key);
  final BaseAuth auth;
  final String loginType;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus =
        userId != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
      });
    });
  }

  void _updateAuthStatus(AuthStatus status) {
    setState(() {
      authStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginPage(
          title: '',
          type: widget.loginType,
          auth: widget.auth,
          onSignIn: () => _updateAuthStatus(AuthStatus.signedIn),
        );
      case AuthStatus.signedIn:
//        providersDatabaseReference.getDocuments(
        if(widget.auth.userType() =='Providers')
        return new ProviderHomePage(
            auth: widget.auth,
            onSignOut: () => _updateAuthStatus(AuthStatus.notSignedIn),);
        else
          return new CustomerHomePage(
            auth: widget.auth,
            onSignOut: () => _updateAuthStatus(AuthStatus.notSignedIn),);
    }
  }
}
