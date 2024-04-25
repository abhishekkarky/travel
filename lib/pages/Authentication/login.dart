import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:travel_booking/pages/Authentication/firebase_auth_service.dart';
import 'package:travel_booking/pages/Authentication/register.dart';
import 'package:travel_booking/pages/Navbar/navbar.dart';
import 'package:travel_booking/providers/auth_view_model.dart';

import '../../services/notification_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const String routeName = "/login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final key = GlobalKey<FormState>();
  late AuthViewModel _authViewModel;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _authViewModel = Provider.of<AuthViewModel>(context,listen: false);
      // checkLogin();
    });

    super.initState();
  }

  // void checkLogin() async{
  //   String? token = await FirebaseMessaging.instance.getToken();
  //
  //   await Future.delayed(const Duration(seconds: 2));
  //   // check for user detail first
  //   try{
  //     await _authViewModel.checkLogin(token);
  //     if(_authViewModel.user==null){
  //       Navigator.of(context).pushReplacementNamed(Login.routeName);
  //     }else{
  //       NotificationService.display(
  //         title: "Welcome back",
  //         body: "Hello ${_authViewModel.loggedInUser?.name},\n We have been waiting for you.",
  //       );
  //       Navigator.of(context).pushReplacementNamed(Navbar.routeName);
  //     }
  //   }catch(e){
  //     Navigator.of(context).pushReplacementNamed(Login.routeName);
  //   }
  //
  // }
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Login here',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Email',
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Password',
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: '********',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: Colors.black,
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (key.currentState!.validate()) {
                              _signIn();
                            }
                          },
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black),
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.white),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Register(),
                                ),
                              );
                            },
                            child: const Text(
                              'Signup?',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _signIn() async {
  //   String email = emailController.text;
  //   String password = passwordController.text;
  //
  //   User? user = await _auth.signInWithEmailAndPassword(email, password);
  //
  //   if (user != null) {
  //     showSimpleNotification(const Text('Welcome'),
  //         background: Colors.green, position: NotificationPosition.bottom);
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const Navbar(),
  //       ),
  //     );
  //   } else {
  //     showSimpleNotification(const Text('Invalid username or password'),
  //         background: Colors.red, position: NotificationPosition.bottom);
  //   }
  // }
void _signIn() async{
  try {
    await _authViewModel
        .login(emailController.text, passwordController.text)
        .then((value) {
      NotificationService.display(
        title: "Welcome back",
        body:
        "Hello ${_authViewModel.loggedInUser?.name},\n Hope you are having a wonderful day.",
      );
      Navigator.of(context).pushReplacementNamed(Navbar.routeName);
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    });
  } catch (err) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(err.toString())));
  }
}
}
