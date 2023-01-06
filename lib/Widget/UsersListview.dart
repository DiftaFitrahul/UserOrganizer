import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:userorganizer/Providers/userProvider.dart';
import 'package:userorganizer/Screen/EditUserScreen.dart';
import 'package:userorganizer/Service/Deletedata.dart';

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
                          foregroundImage: NetworkImage(
                              userList.allUsers[index].imageProfil),
                        ),
                        title: Text(userList.allUsers[index].name),
                        subtitle: Text(
                            "${userList.allUsers[index].major} in ${userList.allUsers[index].studyAt}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: (() {
                            // DeleteData.deleteUser(
                            //     value.allUsers[index].id, context);
                          }),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              EditUserScreen.routeName,
                              arguments: index);
                        },
                      );
                    }))),
      ],
    );
  }
}
