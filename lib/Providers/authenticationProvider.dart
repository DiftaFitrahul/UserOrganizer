import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Authentication with ChangeNotifier {
  Future<void> signup(String? email, String? password) async {
    final response = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCCaGIERgp8bjWdk2u69Rr7Scrxg9CAR0c'),
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
          "returnSecureToken": true
        }));
    final responseData = jsonDecode(response.body);
    print(responseData["error"]);
    // print(response.body);
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
        print(responseData['error']['message']);
        throw responseData['error']['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
