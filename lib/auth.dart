import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final providersDatabaseReference = Firestore.instance.collection("Providers");
final customersDatabaseReference = Firestore.instance.collection("Customers");

abstract class BaseAuth {

  Future<String> currentUser();
  Future<String> signIn(String email, String password, String type);
  Future<String> createUser(String email, String password, String type);
  String userType();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _userId;
  String _type;


  Future<String> signIn(String email, String password, String type) async {
    if (type != "Providers" && type != "Customers"){
      return "Failed";
    }
    FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password)).user;
    if (type == "Providers" &&
        await providersDatabaseReference.document(user.uid).get().then((
            doc) => doc.exists)) {
      _userId = user.uid;
      _type = type;
    } else
    if (type == "Customers" && await customersDatabaseReference.document(user.uid).get().then((
        doc) => doc.exists)) {
      _userId = user.uid;
      _type = type;
    } else {
      return "Failed";
    }
    return user.uid;

  }

  Future<String> createUser(String email, String password, String type) async {

    if (type != "Providers" && type != "Customers"){
      return "Failed";
    }

    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    if (type == "Providers"){
      providersDatabaseReference.document(user.uid).setData({
        'stores':[],
      });
    } else {
      customersDatabaseReference.document(user.uid).setData({
        'reservations': [], //{"storeId": ref, "bookedSlot": ref}
      });
    }

    this._type = type;
    _userId = user.uid;

    return user.uid;
  }

  String userType() {
    return _type;
  }

  Future<String> currentUser() async {
    print(_userId);
    FirebaseUser user = await _firebaseAuth.currentUser();
    print(user.uid);
    return user != null && _userId == user.uid ? user.uid : null;
  }

  Future<void> signOut() async {
    _userId = null;
    _type = null;
    return _firebaseAuth.signOut();
  }

}