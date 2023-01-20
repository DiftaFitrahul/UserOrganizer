import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Authentication with ChangeNotifier {
  void signup(String? email, String? password) async {
    final response = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCCaGIERgp8bjWdk2u69Rr7Scrxg9CAR0c'),
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
          "returnSecureToken": true
        }));
    print(response.statusCode);
    print(response.body);
  }
}
