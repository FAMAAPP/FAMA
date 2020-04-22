import 'package:flutter/foundation.dart';
import 'package:qrscan/qrscan.dart';
class QRtoData with ChangeNotifier {
  String QRScanResult;

  Future<void> analyzeResult() async {
    try{
      QRScanResult = await scan();
      notifyListeners();
    }catch (err) {
      print(err);
    }
  }
}