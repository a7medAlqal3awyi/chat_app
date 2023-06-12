import 'package:chat/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constant/colors.dart';
import '../widgets/custom_button.dart';

import '../widgets/custom_text_failed.dart';
import 'chat_page.dart';

class RegisterPage extends StatefulWidget {
  static String id='RegisterPage' ;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;

    GlobalKey<FormState>formKey=GlobalKey();
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              SafeArea(
                  child: const SizedBox(
                    height: 50,
                  )),
              Image.asset(
                'assets/images/scholar.png',
                width: 150,
                height: 180,
                fit: BoxFit.fitHeight,
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Scholar Chat",
                  style: TextStyle(
                      color: Colors.white, fontSize: 32, fontFamily: 'Pacifico'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children:const [
                   Text("Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),)
                ],
              ),

              // CustomTextFormField(
              //   labelText: 'Name',
              //   type: TextInputType.name,
              //
              //   prefixIcon: Icon(
              //     Icons.drive_file_rename_outline,
              //     color: Colors.white,
              //   ),
              // ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                onChanged: (data) {
                  email = data;
                },
                labelText: 'Email',
                type: TextInputType.emailAddress,
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // CustomTextFormField(
              //   type: TextInputType.phone,
              //
              //   labelText: 'Phone',
              //   prefixIcon: Icon(
              //     Icons.phone,
              //     color: Colors.white,
              //   ),
              // ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                onChanged: (data) {
                  password = data;
                },
                type: TextInputType.visiblePassword,
                labelText: 'Password',
                prefixIcon:const Icon(
                  Icons.password_outlined,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                txt: 'Register',
                onTap: () async {
                 if(formKey.currentState!.validate()) {

                   try {
                      await registerUser(email, password, context);
                      Navigator.pushNamed(context,ChatPage.id);

                   }
                    //if failed  to create an acc new or wrong password
                    on FirebaseAuthException catch (ex) {
                      showSnackBar(context, ex);
                    } catch (err) {
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                       content: Text(err.toString()),
                     ),);
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
                  Text(
                    'aready have an account ',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, LoginPage.id);
                    },
                    child: Text(
                      'Login now',
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

  void showSnackBar(BuildContext context, FirebaseAuthException ex) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(child: Text(ex.code.toString())),
      backgroundColor: Colors.red,
      showCloseIcon: true,
      closeIconColor: Colors.white,

    ));
  }

  Future<void> registerUser(String? email, String? password, BuildContext context) async {
     var auth = FirebaseAuth.instance;
    UserCredential user =
    await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
                //if success to create an acc new
                      {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Center(child: Text("Success")),
                      backgroundColor: Colors.green,
                      showCloseIcon: true,
                      closeIconColor: Colors.white,
                      ));
                      }
  }
}
