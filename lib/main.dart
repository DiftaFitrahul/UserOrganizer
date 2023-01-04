import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userorganizer/Providers/userProvider.dart';
import 'package:userorganizer/Screen/addUserScreen.dart';

import 'package:userorganizer/Screen/HomeScreen.dart';
import 'package:userorganizer/Widget/UsersListview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProviders())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'List of User',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                .copyWith(secondary: Colors.teal)),
        home: const HomeScreen(),
        routes: {
          CustomizeUserScreen.routeName: (context) =>
              const CustomizeUserScreen()
        },
      ),
    );
  }
}
