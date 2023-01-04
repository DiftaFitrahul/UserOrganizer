import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:userorganizer/Providers/userProvider.dart';

class CustomizeUserScreen extends StatelessWidget {
  const CustomizeUserScreen({Key key}) : super(key: key);
  static const routeName = '/User-list';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final userList = Provider.of<UserProviders>(context, listen: false);
    TextEditingController nameController = TextEditingController();
    TextEditingController majorController = TextEditingController();
    TextEditingController studyAtController = TextEditingController();
    TextEditingController imageController = TextEditingController();
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
                          if (!formKey.currentState.validate()) {
                            return;
                          }
                          userList.addUser(
                              nameUser: nameController.text,
                              majorUser: majorController.text,
                              studyAtUser: studyAtController.text,
                              imageProfileUser: imageController.text);

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

/*


    
*/
