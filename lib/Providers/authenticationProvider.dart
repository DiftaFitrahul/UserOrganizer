import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Authentication with ChangeNotifier {
  Timer? _timeToExit;
  String? _idToken, userId;
  DateTime? _expiryDate;

  String? _tempidToken, tempuserId;
  DateTime? _tempexpiryDate;

  void tempData() {
    _idToken = _tempidToken;
    _expiryDate = _tempexpiryDate;
    userId = tempuserId;
    _autoLogOut();
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
  }

  void logout() {
    _idToken = null;
    userId = null;
    _expiryDate = null;
    //why we do this conditional, cause we want to cancel _timeToExit if that variable is not null
    //the case when we do not implement this conditional, when we sign up or sign in we call _autoLogout function
    //then when we press logout button direct the timer will not cancelled and still call callback (that the reason), it cause the function still run in memory and thats not good
    if (_timeToExit != null) {
      _timeToExit?.cancel();
    }
    notifyListeners();
  }

  void _autoLogOut() {
    final timeToExpire = _tempexpiryDate!.difference(DateTime.now()).inSeconds;
    print(timeToExpire);
    _timeToExit = Timer(Duration(seconds: timeToExpire), () {
      logout();
    });
  }
}
