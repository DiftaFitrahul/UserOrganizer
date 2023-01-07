import 'dart:convert';
import 'dart:math';

import '../Models/User.dart';
import 'package:http/http.dart' as http;

class GetData {
  static Future<List<User>> fetchData() async {
    List<User> dataUsers = [];
    try {
      final response = await http.get(Uri.parse(
          'https://userorganizationlearn-default-rtdb.firebaseio.com/users.json'));
      if (response.statusCode == 200) {
        final users = jsonDecode(response.body) as Map<String, dynamic>;
        if (users != null) {
          users.forEach((key, value) {
            dataUsers.add(User(
                id: key,
                name: value['name'],
                major: value['major'],
                studyAt: value['studyAt'],
                imageProfil: value['imageProfil']));
          });
        } else {
          dataUsers = [];
        }
      }
    } catch (e) {
      return e;
    }

    return dataUsers;
  }
}
