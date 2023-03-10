import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:userorganizer/Providers/authentication_provider.dart';

import '../Models/user_model.dart';
import 'package:http/http.dart' as http;

class GetData with ChangeNotifier {
  Future<List<User>> fetchData(BuildContext context) async {
    final token = Provider.of<Authentication>(context).token;
    final userId = Provider.of<Authentication>(context, listen: false).userId;
    List<User> dataUsers = [];
    try {
      final response = await http.get(Uri.parse(
          'https://userorganizationlearn-default-rtdb.firebaseio.com/users.json?auth=$token&orderBy="userId"&equalTo="$userId"'));
      if (response.statusCode == 200) {
        final users = jsonDecode(response.body) as Map<String, dynamic>;

        users.forEach((key, value) {
          dataUsers.add(User(
              id: key,
              name: value['name'],
              major: value['major'],
              studyAt: value['studyAt'],
              imageProfil: value['imageProfil']));
        });
      } else {
        throw response.statusCode;
      }
    } catch (e) {
      rethrow;
    }

    return dataUsers;
  }
}
