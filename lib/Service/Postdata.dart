import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../Providers/userProvider.dart';

import '../Models/User.dart';

class PostData {
  static createUser(String name, String major, String studyAt,
      String imageProfil, BuildContext context) async {
    final userData = Provider.of<UserProviders>(context, listen: false);
    try {
      final response = await http.post(
          Uri.parse(
              'https://userorganizationlearn-default-rtdb.firebaseio.com/users.json'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(<String, dynamic>{
            'name': name,
            'major': major,
            'studyAt': studyAt,
            'imageProfil': imageProfil,
          }));

      if (response.statusCode == 200) {
        userData.addUser(
            idUser: jsonDecode(response.body)['name'].toString(),
            nameUser: name,
            majorUser: major,
            studyAtUser: studyAt,
            imageProfileUser: imageProfil);
      } else {
        throw (response.statusCode);
      }
    } catch (e) {
      rethrow;
    }
  }
}
