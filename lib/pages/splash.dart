import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:travel_booking/pages/Authentication/login.dart';
import 'package:travel_booking/pages/Navbar/navbar.dart';

import '../providers/auth_view_model.dart';
import '../services/notification_service.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = "/splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthViewModel _authViewModel;

  void checkLogin() async{
    String? token = await FirebaseMessaging.instance.getToken();

    await Future.delayed(Duration(seconds: 3));
    // check for user detail first
    try{
      await _authViewModel.checkLogin(token);
      if(_authViewModel.user==null){
        Navigator.of(context).pushReplacementNamed(Login.routeName);
      }else{
        NotificationService.display(
          title: "Welcome back",
          body: "Hello ${_authViewModel.loggedInUser?.name},\n We have been waiting for you.",
        );
        Navigator.of(context).pushReplacementNamed(Navbar.routeName);
      }
    }catch(e){
      Navigator.of(context).pushReplacementNamed(Login.routeName);
    }

  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    });
    checkLogin();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60,),
              Image.asset("assets/images/travel.jpg"),
              const SizedBox(height: 30,),
              const Text("Travel Booking", style: TextStyle(
                  fontSize: 22
              ),),
              const SizedBox(height: 30,),
              const CupertinoActivityIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
