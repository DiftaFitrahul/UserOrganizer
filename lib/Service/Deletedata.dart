import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:userorganizer/Providers/userProvider.dart';

import '../Models/User.dart';

class DeleteData {
  static Future<User> deleteUser(String id, BuildContext context) async {
    final userData = Provider.of<UserProviders>(context, listen: false);
    final response = await http.delete(
        Uri.parse(
            'https://userorganizationlearn-default-rtdb.firebaseio.com/users/$id.json'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      userData.deleteUser(id);
    }
  }
}
