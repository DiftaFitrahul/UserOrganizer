import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Authentication with ChangeNotifier {
  String? _idToken, userId;
  DateTime? _expiryDate;

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

      _idToken = responseData['idToken'];
      userId = responseData['localId'];
      _expiryDate = DateTime.now()
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
      _idToken = responseData['idToken'];
      if (responseData['error'] != null) {
        throw responseData['error']['message'];
      }

      _idToken = responseData['idToken'];
      userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}
