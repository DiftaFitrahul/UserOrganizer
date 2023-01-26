import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:userorganizer/Service/Getdata.dart';
import 'package:userorganizer/Service/Updatedata.dart';

import '../Models/User.dart';

class UserProviders with ChangeNotifier {
  List<User> _allUsers = [];
  GetData getdata = GetData();

  List<User> get allUsers => _allUsers;

  int get usersLength => _allUsers.length;

  Future<void> getUsers(BuildContext context) async {
    try {
      _allUsers = await getdata.fetchData(context);
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  void addUser(
      {required String idUser,
      required String nameUser,
      required String majorUser,
      required String studyAtUser,
      required String imageProfileUser}) {
    _allUsers.add(User(
        id: idUser,
        name: nameUser,
        major: majorUser,
        studyAt: studyAtUser,
        imageProfil: imageProfileUser));
    notifyListeners();
  }

  void updateUser(
      {required String nameUser,
      required String majorUser,
      required String studyAtUser,
      required String imageProfileUser,
      required String idx}) {
    _allUsers[_allUsers.indexWhere((element) => element.id == idx)] = User(
        id: idx,
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
