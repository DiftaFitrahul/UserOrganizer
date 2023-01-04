import 'package:flutter/cupertino.dart';

import '../Models/User.dart';

class UserProviders with ChangeNotifier {
  List<User> _allUsers = [];

  List<User> get allUsers => _allUsers;

  int get usersLength => _allUsers.length;

  void addUser(
      {String nameUser,
      String majorUser,
      String studyAtUser,
      String imageProfileUser}) {
    _allUsers.add(User(
        name: nameUser,
        major: majorUser,
        studyAt: studyAtUser,
        imageProfil: imageProfileUser));
    notifyListeners();
  }
}
