import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:userorganizer/Providers/userProvider.dart';

import '../Models/User.dart';

class UpdateData {
  static updateUser(String name, String major, String studyAt,
      String imageProfil, String id, BuildContext context) async {
    final userData = Provider.of<UserProviders>(context, listen: false);
    try {
      final response = await http.put(
          Uri.parse(
              'https://userorganizationlearn-default-rtdb.firebaseio.com/users/$id.json'),
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
        userData.updateUser(
            idx: id,
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
