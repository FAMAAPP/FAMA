import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'primary_button.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './landing.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title, this.auth, this.onSignIn}) : super(key: key);

  final String title;
  final BaseAuth auth;
  final VoidCallback onSignIn;

  final Firestore db = Firestore.instance;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  var formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;
  String _authHint = '';

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {

        FirebaseUser user = _formType == FormType.login
            ? await widget.auth.signIn(_email, _password)
            : await widget.auth.createUser(_email, _password);

        try {

          var test = await widget.db
              .collection('users')
              .document(user.email)
              .get()
              .then((value) {
            return value.data['accountType'];
          });

          if (test != Landing.accountType) {
            widget.auth.signOut();
            setState(() {
              _authHint = 'Please sign in as $test';
            });
            return;
          }

        } catch (e) {
          setState(() {
            _authHint = 'Sign In Error\n\n${e.toString()}';
          });
          print(e);
        }

        setState(() {
          _authHint = 'Signed In\n\nUser id: $user.uid';
        });
        widget.onSignIn();

      } catch (e) {
        setState(() {
          _authHint = 'Sign In Error\n\n${e.toString()}';
        });
        print(e);
      }
    } else {
      setState(() {
        _authHint = '';
      });
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
      _authHint = '';
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
      _authHint = '';
    });
  }

  List<Widget> usernameAndPassword() {
    return [
      padded(
          child: new TextFormField(
            key: new Key('email'),
            decoration: new InputDecoration(labelText: 'Email'),
            autocorrect: false,
            validator: (val) => val.isEmpty ? 'Email can\'t be empty.' : null,
            onSaved: (val) => _email = val,
          )),
      padded(
          child: new TextFormField(
            key: new Key('password'),
            decoration: new InputDecoration(labelText: 'Password'),
            obscureText: true,
            autocorrect: false,
            validator: (val) => val.isEmpty ? 'Password can\'t be empty.' : null,
            onSaved: (val) => _password = val,
          )),
    ];
  }

  List<Widget> submitWidgets() {
    switch (_formType) {
      case FormType.login:
        return [
          new PrimaryButton(
              key: new Key('login'),
              text: 'Login',
              height: 44.0,
              onPressed: validateAndSubmit),
          new FlatButton(
              key: new Key('need-account'),
              child: new Text("Need an account? Sign up"),
              onPressed: moveToRegister),
        ];
      case FormType.register:
        return [
          new PrimaryButton(
              key: new Key('register'),
              text: 'Sign up',
              height: 44.0,
              onPressed: validateAndSubmit),
          new FlatButton(
              key: new Key('need-login'),
              child: new Text("Have an account? Login"),
              onPressed: moveToLogin),
        ];
    }
    return null;
  }

  Widget hintText() {
    return new Container(
      //height: 80.0,
        padding: const EdgeInsets.all(32.0),
        child: new Text(_authHint,
            key: new Key('hint'),
            style: new TextStyle(fontSize: 18.0, color: Colors.grey),
            textAlign: TextAlign.center));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF506A32), title: Text("FAMA",
          style: GoogleFonts.libreBaskerville(
              fontSize: 18,fontWeight: FontWeight.w800),),
        ),
        backgroundColor: Colors.white,
        body: new SingleChildScrollView(
            child: new Container(
                padding: const EdgeInsets.all(16.0),
                child: new Column(children: [
                  new Icon(Icons.account_circle,size: 120,),
                  new Card(
                      child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Container(
                                padding: const EdgeInsets.all(16.0),
                                child: new Form(
                                    key: formKey,
                                    child: new Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      children:
                                      usernameAndPassword() + submitWidgets(),
                                    ))),
                          ])),
                  hintText()
                ]))));
  }

  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }
}