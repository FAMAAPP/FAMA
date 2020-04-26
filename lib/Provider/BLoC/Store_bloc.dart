import 'dart:async';
import 'package:fama/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final storesDatabaseReference = Firestore.instance.collection("Stores");
final providersDatabaseReference = Firestore.instance.collection("Providers");

class StoreBLoC {
  final _storeName = BehaviorSubject<String>();
  final _storeAddress = BehaviorSubject<String>();
  final _storeZipCode = BehaviorSubject<String>();
  final _storeCity = BehaviorSubject<String>();
  final _storeCountry = BehaviorSubject<String>();
  final _storePhoneNumber = BehaviorSubject<String>();

  Stream<String> get storeName => _storeName.stream.transform(validateStoreName);
  Stream<String> get storeAddress => _storeAddress.stream.transform(validateStoreAddress);
  Stream<String> get storeCity => _storeCity.stream.transform(validateStoreCity);
  Stream<String> get storeCountry => _storeCountry.stream.transform(validateStoreCountry);
  Stream<int> get storeZipCode => _storeZipCode.stream.transform(validateStoreZipCode);
  Stream<int> get storePhoneNumber => _storePhoneNumber.stream.transform(validateStorePhoneNumber);
  Stream<bool> get validStoreInfo => Rx.combineLatest6(
      storeName, storeAddress, storeCity,
      storeZipCode, storeCountry, storePhoneNumber,
      (storeName,storeAddress,storeCity,
          storeZipCode,storeCountry,storePhoneNumber) => true);

  Function(String) get changeStoreName => _storeName.sink.add;
  Function(String) get changeStoreAddress => _storeAddress.sink.add;
  Function(String) get changeStoreCity => _storeCity.sink.add;
  Function(String) get changeStoreCountry => _storeCountry.sink.add;
  Function(String) get changeStoreZipCode => _storeZipCode.sink.add;
  Function(String) get changeStorePhoneNumber => _storePhoneNumber.sink.add;


  dispose() {
    _storeAddress.close();
    _storeName.close();
    _storeZipCode.close();
    _storeCity.close();
    _storeCountry.close();
    _storePhoneNumber.close();
  }

  final validateStoreName = validateStringString(length: 5, fieldName: "Name");
  final validateStoreAddress = validateStringString(length: 8, fieldName: "Address");
  final validateStoreCity = validateStringString(length: 3, fieldName: "City");
  final validateStoreCountry = validateStringString(length: 3, fieldName: "Country");
  final validateStoreZipCode = validateStringInt(length: 5, fieldName: "Zipcode");
  final validateStorePhoneNumber = validateStringInt(length: 9, fieldName: "Phone number");

  static StreamTransformer validateStringInt({String fieldName, int length }){
    return StreamTransformer<String, int>.fromHandlers(
    handleData: (userInput, sink) {
      try {
        if (userInput.length != length) {
          sink.addError("$fieldName must be at equal $length numbers");
        } else {
          sink.add(int.parse(userInput));
        }
      } catch(err) {
        sink.addError("$fieldName must be a number");
      }
    }
    );
  }

  static StreamTransformer validateStringString({String fieldName, int length }){
    return StreamTransformer<String, String>.fromHandlers(
    handleData: (userInput, sink) {
      if (userInput.length < length) {
        sink.addError("$fieldName must be at least $length letters");
      } else {
        sink.add(userInput);
      }
    }
    );
  }

  submitStoreInfo(String id) async {
    DocumentReference storeRef = await storesDatabaseReference.document();

    await storeRef.setData({
      "storeName": _storeName.value,
      "storeAddress": _storeAddress.value,
      "storeCity": _storeCity.value,
      "storeCountry": _storeCountry.value,
      "storeZipcode": _storeZipCode.value,
      "storePhoneNumber": _storePhoneNumber.value,
      "availableSchedule": {
        "9:00 AM to 10:00 AM": [],
        "10:00 AM to 11:00 AM": [],
        "11:00 AM to 12:00 PM": [],
        "12:00 PM to 1:00 PM": [],
        "1:00 PM to 2:00 PM": [],
        "2:00 PM to 3:00 PM": [],
        "3:00 PM to 4:00 PM": [],
        "3:00 PM to 4:00 PM": [],
      },
    });

    await providersDatabaseReference.document(id).updateData({"stores": FieldValue.arrayUnion([storeRef])});
    print("Store Added to Provider's list");

  }
}

