import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:userorganizer/Providers/userProvider.dart';
import 'package:userorganizer/Screen/addUserScreen.dart';
import 'package:userorganizer/Widget/UsersListview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userList = Provider.of<UserProviders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of User"),
        actions: [
          IconButton(
              onPressed: (() {
                Navigator.of(context).pushNamed(CustomizeUserScreen.routeName);
              }),
              icon: const Icon(Icons.add))
        ],
      ),
      body: GestureDetector(
        child: Consumer<UserProviders>(
            builder: (context, value, child) => (userList.allUsers.isEmpty)
                ? addFirstUser(context)
                : const UserListview()),
      ),
    );
  }

  Widget addFirstUser(context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Empty Data"),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: (() {
                Navigator.of(context).pushNamed(CustomizeUserScreen.routeName);
              }),
              child: const Text("Add Users"))
        ],
      ),
    );
  }
}
