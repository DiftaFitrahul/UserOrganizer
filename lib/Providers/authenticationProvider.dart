import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Authentication with ChangeNotifier {
  String? _idToken, userId;
  DateTime? _expiryDate;

  String? _tempidToken, tempuserId;
  DateTime? _tempexpiryDate;

  void tempData() {
    _idToken = _tempidToken;
    _expiryDate = _tempexpiryDate;
    userId = tempuserId;
    notifyListeners();
  }

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_idToken != null &&
        _expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _idToken;
    } else {
      return null;
    }
  }

  Future<void> signup(String? email, String? password) async {
    try {
      final response = await http.post(
          Uri.parse(
              'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCCaGIERgp8bjWdk2u69Rr7Scrxg9CAR0c'),
          body: jsonEncode(<String, dynamic>{
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));

      final responseData = jsonDecode(response.body);

      if (responseData['error'] != null) {
        throw responseData['error']['message'];
      }

      _tempidToken = responseData['idToken'];
      tempuserId = responseData['localId'];
      _tempexpiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    } catch (e) {
      rethrow;
    }

    notifyListeners();
  }

  Future<void> signIn(String? email, String? password) async {
    try {
      final response = await http.post(
          Uri.parse(
              'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCCaGIERgp8bjWdk2u69Rr7Scrxg9CAR0c'),
          body: jsonEncode(<String, dynamic>{
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));
      final responseData = jsonDecode(response.body);
      if (responseData['error'] != null) {
        throw responseData['error']['message'];
      }

      _tempidToken = responseData['idToken'];
      tempuserId = responseData['localId'];
      _tempexpiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  void logout() {
    _idToken = null;
    userId = null;
    _expiryDate = null;
    notifyListeners();
  }
}
