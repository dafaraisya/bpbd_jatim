import 'package:flutter/foundation.dart';

class DonationProvider extends ChangeNotifier {
  int _donationIndex = 0;
  int get donationIndex => _donationIndex;
  void changeIndex(int index) {
    _donationIndex = index;
    notifyListeners();
  }
}
