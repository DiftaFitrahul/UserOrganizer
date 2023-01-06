import 'dart:convert';

import '../Models/User.dart';
import 'package:http/http.dart' as http;

class GetData {
  static Future<List<User>> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://userorganizationlearn-default-rtdb.firebaseio.com/users.json'));
      if (response.statusCode == 200) {
        final users = (jsonDecode(response.body)) as List;
        print(users);
        //return users.map((e) => User.fromJson(e)).toList();
      }
    } catch (e) {
      return e;
    }
  }
}
