import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/userProvider.dart';
import '../Service/update_data.dart';

class EditUserScreen extends StatelessWidget {
  EditUserScreen({Key? key}) : super(key: key);
  static const routeName = '/EditUser-screen';
  UpdateData updateData = UpdateData();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final idx = ModalRoute.of(context)?.settings.arguments as int;
    final userList = Provider.of<UserProviders>(context, listen: false);
    TextEditingController nameController =
        TextEditingController(text: userList.allUsers[idx].name);
    TextEditingController majorController =
        TextEditingController(text: userList.allUsers[idx].major);
    TextEditingController studyAtController =
        TextEditingController(text: userList.allUsers[idx].studyAt);
    TextEditingController imageController =
        TextEditingController(text: userList.allUsers[idx].imageProfil);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User List"),
      ),
      body: Center(
          child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Consumer<UserProviders>(
                        builder: (context, value, child) => ClipRRect(
                              borderRadius: BorderRadius.circular(150),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: value.allUsers[idx].imageProfil,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Image.network(
                                          'https://www.seekpng.com/png/detail/847-8474751_download-empty-profile.png'),
                                ),
                              ),
                            )),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: 'Full name'),
                      validator: ((value) {
                        return validatorInput(value, "Name");
                      }),
                    ),
                    TextFormField(
                      controller: majorController,
                      decoration: const InputDecoration(hintText: 'Major'),
                      validator: ((value) {
                        return validatorInput(value, "Major");
                      }),
                    ),
                    TextFormField(
                      controller: studyAtController,
                      decoration: const InputDecoration(hintText: 'University'),
                      validator: ((value) {
                        return validatorInput(value, "University");
                      }),
                    ),
                    TextFormField(
                      controller: imageController,
                      decoration:
                          const InputDecoration(hintText: 'Image Profile Link'),
                      validator: ((value) {
                        return validatorInput(value, "Image Profile Link");
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          updateData.updateUser(
                                  nameController.text,
                                  majorController.text,
                                  studyAtController.text,
                                  imageController.text,
                                  userList.allUsers[idx].id,
                                  context)
                              .then((value) {
                            Navigator.pop(context);
                          }).catchError((error) => showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text('Error $error happen'),
                                        content:
                                            const Text("Cannot edit data user"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Okay'))
                                        ],
                                      )));
                        },
                        child: const Text("Edit"))
                  ],
                ),
              ))),
    );
  }

  String? validatorInput(value, inputName) {
    String? result;
    if (value.isNotEmpty && value.length > 2) {
      result = null;
    } else if (value.isNotEmpty && value.length <= 2) {
      result = "$inputName is too short";
    } else {
      result = 'Please enter your $inputName';
    }
    return result;
  }
}
