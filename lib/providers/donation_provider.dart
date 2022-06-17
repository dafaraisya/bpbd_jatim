import 'package:flutter/foundation.dart';

class DonationProvider extends ChangeNotifier {
  int _donationIndex = 0;
  String _accountId = '';
  String _accountName = '';
  String _disasterName = '';
  int _donationAmount = 0;
  String _note = '';

  int get donationIndex => _donationIndex;
  String get accountId => _accountId;
  String get accountName => _accountName;
  String get disasterName => _disasterName;
  int get donationAmount => _donationAmount;
  String get note => _note;
  
  void changeIndex(int index) {
    _donationIndex = index;
    notifyListeners();
  }

  void changeAccountId(String value) {
    _accountId = value;
    notifyListeners();
  }
  
  void changeAccountName(String value) {
    _accountName = value;
    notifyListeners();
  }

  void changeDisasterName(String value) {
    _disasterName = value;
    notifyListeners();
  }

  void changeDonationAmount(int value) {
    _donationAmount = value;
    notifyListeners();
  }

  void changeNote(String value) {
    _note = value;
    notifyListeners();
  }

}
