import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:userorganizer/Providers/user_provider.dart';
import 'package:userorganizer/Screen/edit_user_screen.dart';
import 'package:userorganizer/Service/delete_data.dart';

class UserListview extends StatefulWidget {
  const UserListview({Key? key}) : super(key: key);

  @override
  State<UserListview> createState() => _UserListviewState();
}

class _UserListviewState extends State<UserListview> {
  DeleteData delete = DeleteData();
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
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: value.allUsers[index].imageProfil,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Image.network(
                                  'https://www.seekpng.com/png/detail/847-8474751_download-empty-profile.png'),
                            ),
                          ),
                        ),
                        title: Text(userList.allUsers[index].name),
                        subtitle: Text(
                            "${userList.allUsers[index].major} in ${userList.allUsers[index].studyAt}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: (() {
                            delete
                                .deleteUser(value.allUsers[index].id, context)
                                .catchError((error) => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text('Error $error happen'),
                                          content: const Text(
                                              "Cannot delete data user"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Okay'))
                                          ],
                                        )));
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
