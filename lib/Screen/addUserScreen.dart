import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:userorganizer/Providers/userProvider.dart';

class CustomizeUserScreen extends StatefulWidget {
  static const routeName = '/Users-list';
  const CustomizeUserScreen({Key key}) : super(key: key);

  @override
  State<CustomizeUserScreen> createState() => _CustomizeUserScreenState();
}

class _CustomizeUserScreenState extends State<CustomizeUserScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController _majorController;
  TextEditingController _studyAtController;
  TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _majorController = TextEditingController();
    _studyAtController = TextEditingController();
    _imageController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _majorController.dispose();
    _studyAtController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userList = Provider.of<UserProviders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User List"),
      ),
      body: Center(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(hintText: 'Full name'),
                      validator: ((value) {
                        return validatorInput(value, "Name");
                      }),
                    ),
                    TextFormField(
                      controller: _majorController,
                      decoration: const InputDecoration(hintText: 'Major'),
                      validator: ((value) {
                        return validatorInput(value, "Major");
                      }),
                    ),
                    TextFormField(
                      controller: _studyAtController,
                      decoration: const InputDecoration(hintText: 'University'),
                      validator: ((value) {
                        return validatorInput(value, "University");
                      }),
                    ),
                    TextFormField(
                      controller: _imageController,
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
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          userList.addUser(
                              nameUser: _nameController.text,
                              majorUser: _majorController.text,
                              studyAtUser: _studyAtController.text,
                              imageProfileUser: _imageController.text);
                          print(userList.allUsers[0].name);
                          Navigator.pop(context);
                        },
                        child: const Text("Submit"))
                  ],
                ),
              ))),
    );
  }

  String validatorInput(value, inputName) {
    String result;
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
