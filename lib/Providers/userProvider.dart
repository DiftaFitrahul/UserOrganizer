import 'package:flutter/cupertino.dart';
import 'package:userorganizer/Service/Getdata.dart';

import '../Models/User.dart';

class UserProviders with ChangeNotifier {
  List<User> _allUsers = [];

  List<User> get allUsers => _allUsers;

  int get usersLength => _allUsers.length;

  bool isLoading = false;

  Future<void> getUsers() async {
    isLoading = true;
    GetData.fetchData();
    isLoading = false;
    notifyListeners();
  }

  void addUser(
      {String idUser,
      String nameUser,
      String majorUser,
      String studyAtUser,
      String imageProfileUser}) {
    _allUsers.add(User(
        id: idUser,
        name: nameUser,
        major: majorUser,
        studyAt: studyAtUser,
        imageProfil: imageProfileUser));
    notifyListeners();
  }

  void updateUser(
      {String nameUser,
      String majorUser,
      String studyAtUser,
      String imageProfileUser,
      int idx}) {
    _allUsers[idx] = User(
        name: nameUser,
        major: majorUser,
        studyAt: studyAtUser,
        imageProfil: imageProfileUser);
    notifyListeners();
  }

  void deleteUser(idx) {
    _allUsers.removeWhere((element) => element.id == idx);
    notifyListeners();
  }
}
