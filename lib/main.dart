import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:travel_booking/pages/Authentication/login.dart';
import 'package:travel_booking/pages/views/airline.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const OverlaySupport.global(
      child: MaterialApp(
        title: 'Travel Booking',
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}
