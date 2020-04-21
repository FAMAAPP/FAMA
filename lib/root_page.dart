import 'package:flutter/material.dart';
import './auth.dart';
import 'Login.dart';
import 'Provider/ProviderHome.dart';
import 'Customer/CustomerHome.dart';
import 'package:flutter/foundation.dart';

class RootPage extends StatefulWidget {
  RootPage({Key key, this.auth, this.loginType}) : super(key: key);
  final BaseAuth auth;
  String loginType;

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
          auth: widget.auth,
          onSignIn: () => _updateAuthStatus(AuthStatus.signedIn),
        );
      case AuthStatus.signedIn:
        if(widget.loginType=='Provider')
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
