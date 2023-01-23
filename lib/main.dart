import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userorganizer/Providers/userProvider.dart';
import 'package:userorganizer/Screen/EditUserScreen.dart';
import 'package:userorganizer/Screen/LoginPage.dart';
import 'package:userorganizer/Screen/addUserScreen.dart';

import 'package:userorganizer/Screen/HomeScreen.dart';
import 'package:userorganizer/Widget/UsersListview.dart';

import 'Providers/authenticationProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProviders()),
        ChangeNotifierProvider(create: (context) => Authentication())
      ],
      child: Consumer<Authentication>(
        builder: (context, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'List of User',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                  .copyWith(secondary: Colors.teal)),
          home: auth.isAuth ? const HomeScreen() : const LoginScreen(),
          routes: {
            CustomizeUserScreen.routeName: (context) => CustomizeUserScreen(),
            EditUserScreen.routeName: (context) => EditUserScreen()
          },
        ),
      ),
    );
  }
}
