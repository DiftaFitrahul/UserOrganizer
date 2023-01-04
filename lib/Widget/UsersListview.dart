import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:userorganizer/Providers/userProvider.dart';

class UserListview extends StatelessWidget {
  const UserListview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userList = Provider.of<UserProviders>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Consumer<UserProviders>(
            builder: (context, value, child) => Expanded(
                child: ListView.builder(
                    itemCount: userList.usersLength,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Image.network(
                            userList.allUsers[index].imageProfil,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                          ),
                        ),
                        title: Text(userList.allUsers[index].name),
                        subtitle: Text(
                            "${userList.allUsers[index].major} in ${userList.allUsers[index].studyAt}"),
                        onTap: () {},
                      );
                    }))),
      ],
    );
  }
}
