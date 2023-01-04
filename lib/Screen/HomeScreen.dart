import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:userorganizer/Providers/userProvider.dart';
import 'package:userorganizer/Widget/UsersListview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userList = Provider.of<UserProviders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text("List of User")),
      body: Expanded(
          child: (userList.allUsers.isEmpty)
              ? addFirstUser()
              : const UserListview()),
    );
  }

  Widget addFirstUser() {
    return Center(
      child: Column(
        children: [
          const Text("Empty Data"),
          ElevatedButton(onPressed: ((){}), child: const Text("Add Users"))
        ],
      ),
    );
  }
}
