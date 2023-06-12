import 'package:chat/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_failed.dart';
import 'chat_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  String? email;
  String? password;
  static String id = 'LoginPage';

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SafeArea(
                  child: const SizedBox(
                height: 50,
              )),
              Image.asset(
                'assets/images/scholar.png',
                fit: BoxFit.fitHeight,
                width: 150,
                height: 180,
              ),
              const SizedBox(
                height: 5,
              ),
              const Center(
                child: Text(
                  "Scholar Chat",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontFamily: 'Pacifico'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: const [
                  Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                type: TextInputType.emailAddress,
                labelText: 'Email',
                onChanged: (data) {
                  email = data;
                },
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                type: TextInputType.visiblePassword,
                onChanged: (data) {
                  password = data;
                },
                labelText: 'password',
                prefixIcon: Icon(
                  Icons.password_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                txt: 'Login',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      await loginUser(context);
                      Navigator.pushNamed(context, ChatPage.id,arguments:email );
                    } on FirebaseAuthException catch (exx) {
                      showSnackError(context, exx);
                    } catch (err) {
                      print(err.toString());
                    }
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'don\'t have an account ?',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterPage.id);
                    },
                    child: const Text(
                      ' Register',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackError(BuildContext context, FirebaseAuthException exx) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        closeIconColor: Colors.white,
        showCloseIcon: true,
        content: Center(child: Text(exx.code.toString())),
      ),
    );
  }

  Future<void> loginUser(BuildContext context) async {
    var auth = FirebaseAuth.instance;

    UserCredential user = await auth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        backgroundColor: Colors.green,
        closeIconColor: Colors.white,
        content: Center(child: Text('Success')),
      ),
    );
  }
}
