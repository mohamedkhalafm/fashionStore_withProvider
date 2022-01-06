// ignore: must_be_immutable
import 'package:fashion/component/reusable_components.dart';
import 'package:fashion/modules/home_screen.dart';
import 'package:fashion/modules/register_screen.dart';
import 'package:fashion/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const routePass = '/homeScreen';
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> submitdata() async {
      if (formKey.currentState!.validate()) {
        await Provider.of<AuthProvider>(context, listen: false)
            .UserLogin(emailController.text, passwordController.text);
        Navigator.of(context).pushNamed(HomeScreen.routePass);
      }
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: firstColor),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('LOGIN',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.all(Radius.circular(13))),
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
                        controller: passwordController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          label: Text('Password'),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        onFieldSubmitted: (_) {
                        },
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
                          submitdata();
                        },
                        child: const Text('Login',
                            style: TextStyle(color: Colors.black)),
                      ),
                    )),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                        ),
                        Container(
                            color: secondColor,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(RegisterScreen.routePass);
                                },
                                child: const Text('Register Now'))),
                      ],
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
