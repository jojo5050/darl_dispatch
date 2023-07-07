import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  bool _shouldAddLocation = false;

  bool get shouldAddLocation => _shouldAddLocation;

  void toggleLocation(bool value) {
    _shouldAddLocation = value;
    notifyListeners();
  }
}