import 'dart:async';

import 'package:fama/Provider/BLoC/Store_bloc.dart';
import 'package:fama/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class AddStore extends StatelessWidget {
  AddStore({Key key, this.auth }) : super(key: key);
  final BaseAuth auth;
  final kGoogleApiKey = DotEnv().env['GOOGLE_API_KEY'];
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<StoreBLoC>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Store Form",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              storeStringEntryWidget(label: "Store Name", streamData: bloc.storeName,
                  onChange: bloc.changeStoreName, icon: Icon(Icons.person)),
              storeStringEntryWidget(label: "Store Address", streamData: bloc.storeAddress,
                  onChange: bloc.changeStoreAddress, icon: Icon(Icons.business)),
              storeStringEntryWidget(label: "City", streamData: bloc.storeCity,
                  onChange: bloc.changeStoreCity, icon: Icon(Icons.location_city)),
              storeStringEntryWidget(label: "Country", streamData: bloc.storeCountry,
                  onChange: bloc.changeStoreCountry, icon: Icon(Icons.room)),
              storeIntEntryWidget(label: "Zipcode", streamData: bloc.storeZipCode,
                  onChange: bloc.changeStoreZipCode, icon: Icon(Icons.edit)),
              storeIntEntryWidget(label: "Phone Number", streamData: bloc.storePhoneNumber,
                  onChange: bloc.changeStorePhoneNumber, icon: Icon(Icons.contact_phone)),
              SizedBox(height: 15,),
              saveButton(bloc),
            ],
          ),
        ),
      ),
    );
  }

  Widget storeStringEntryWidget({Function onChange, Stream streamData, String label, Icon icon}) {
    return StreamBuilder<String>(
      stream: streamData,
      builder: (context, snapshot) {
        return TextField(
          decoration: InputDecoration(
            icon: icon,
            labelText: label,
            errorText: snapshot.error,
          ),
          onChanged: onChange,
        );
      }
    );
  }


  Widget storeIntEntryWidget({Function onChange, Stream streamData, String label, Icon icon}) {
    return StreamBuilder<int>(
        stream: streamData,
        builder: (context, snapshot) {
          return TextField(
            decoration: InputDecoration(
              icon: icon,
              labelText: label,
              errorText: snapshot.error,
            ),
            onChanged: onChange,
          );
        }
    );
  }

  Widget saveButton(StoreBLoC bloc) {
    return StreamBuilder<bool>(
      stream: bloc.validStoreInfo,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text("Add Store"),
          onPressed: () async {
            if(!snapshot.hasData){
              return null;
            } else {
              bloc.submitStoreInfo(await auth.currentUser());
              return Navigator.pop(context);
            }
          },
        );
      }
    );
  }

}
