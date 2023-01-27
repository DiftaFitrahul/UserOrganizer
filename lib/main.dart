import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userorganizer/Providers/user_provider.dart';
import 'package:userorganizer/Screen/edit_user_screen.dart';
import 'package:userorganizer/Screen/login_page.dart';
import 'package:userorganizer/Screen/add_user_screen.dart';

import 'package:userorganizer/Screen/home_screen.dart';

import 'Providers/authentication_provider.dart';

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
        ChangeNotifierProvider(create: (context) => Authentication()),
      ],
      child: Consumer<Authentication>(
        builder: (context, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'List of User',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                  .copyWith(secondary: Colors.teal)),
          home: auth.isAuth
              ? const HomeScreen()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 0.8,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return const LoginScreen();
                  },
                ),
          routes: {
            CustomizeUserScreen.routeName: (context) => CustomizeUserScreen(),
            EditUserScreen.routeName: (context) => EditUserScreen()
          },
        ),
      ),
    );
  }
}
