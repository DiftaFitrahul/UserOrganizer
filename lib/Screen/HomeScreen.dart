import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../Providers/authenticationProvider.dart';
import '../Providers/userProvider.dart';
import '../Screen/addUserScreen.dart';
import '../Widget/users_listview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> data;
  bool isInit = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    if (isInit) {
      isLoading = true;
      data = Provider.of<UserProviders>(context, listen: false)
          .getUsers(context)
          .then((value) {
        setState(() {
          isLoading = false;
        });
      });

      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Provider.of<Authentication>(context, listen: false).logout();
            },
            icon: const Icon(Icons.logout)),
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
          child: FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 0.8,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error),
                  Text(snapshot.error.toString())
                ],
              ),
            );
          } else {
            return Consumer<UserProviders>(
                builder: (context, userList, child) =>
                    (userList.allUsers.isEmpty)
                        ? addFirstUser(context)
                        : const UserListview());
          }
        },
      )),
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

/*

 



*/