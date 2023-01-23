import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:userorganizer/Providers/userProvider.dart';

import '../Models/User.dart';

class DeleteData {
  String token = "";
  deleteUser(String id, BuildContext context) async {
    final userData = Provider.of<UserProviders>(context, listen: false);
    try {
      final response = await http.delete(
          Uri.parse(
              'https://userorganizationlearn-default-rtdb.firebaseio.com/users/$id.json?auth=$token'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if (response.statusCode == 200) {
        userData.deleteUser(id);
      } else {
        throw response.statusCode;
      }
    } catch (e) {
      rethrow;
    }
  }
}
