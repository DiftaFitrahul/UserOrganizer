import 'package:flutter/widgets.dart';

class Product with ChangeNotifier {
  String _token = "";
  void updateData(updateToken) {
    _token = updateToken;
    notifyListeners();
  }

  String get token => _token;
}
