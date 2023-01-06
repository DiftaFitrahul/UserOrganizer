import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../Providers/userProvider.dart';
import '../Screen/addUserScreen.dart';
import '../Widget/UsersListview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<UserProviders>(context, listen: false).getUsers();
  // }

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
        child: Consumer<UserProviders>(builder: (context, value, child) {
          // if (value.isLoading) {
          //   return SizedBox(
          //     height: MediaQuery.of(context).size.height / 0.8,
          //     child: const Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   );
          // }
          return (userList.allUsers.isEmpty)
              ? addFirstUser(context)
              : const UserListview();
        }),
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
