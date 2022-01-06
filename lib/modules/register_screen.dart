// ignore: must_be_immutable
import 'package:fashion/component/reusable_components.dart';
import 'package:fashion/modules/home_screen.dart';
import 'package:fashion/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  static const routePass = '/registerScreen';
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmationController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> submitData() async {
      if (formKey.currentState!.validate()) {
        await Provider.of<AuthProvider>(context, listen: false).UserRegister(
            emailController.text,
            passwordController.text,
            nameController.text,
            passwordConfirmationController.text);
        Navigator.of(context).pushNamed(HomeScreen.routePass);
      } else {}
    }

    return Scaffold(
      backgroundColor: firstColor,
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Register',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(13))),
                      child: TextFormField(
                        //initialValue: inaiteValue['price'],
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          label: Text('Email'),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (_) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email must not be empty';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          formKey.currentState!.validate();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(13))),
                      child: TextFormField(
                        //initialValue: inaiteValue['price'],
                        controller: passwordController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          label: Text('Password'),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        onFieldSubmitted: (_) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password must not be empty';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          formKey.currentState!.validate();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(13))),
                      child: TextFormField(
                        controller: passwordConfirmationController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          label: Text('Password Confirmation'),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        onFieldSubmitted: (_) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password must not be empty';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          formKey.currentState!.validate();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Center(
                      child: Container(
                          color: secondColor,
                          child: TextButton(
                              onPressed: () {
                                submitData();
                              },
                              child: const Text(
                                'Register Now',
                                style: TextStyle(color: Colors.black),
                              ))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
