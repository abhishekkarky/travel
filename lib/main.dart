import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:travel_booking/firebase_options.dart';
import 'package:travel_booking/pages/splash.dart';
import 'package:travel_booking/providers/airline_view_model.dart';
import 'package:travel_booking/providers/auth_view_model.dart';
import 'package:travel_booking/providers/common_view_model.dart';
import 'package:travel_booking/providers/day_coun_provider.dart';
import 'package:travel_booking/providers/flight_setting_provider.dart';
import 'package:travel_booking/providers/holiday_package_view_model.dart';
import 'package:travel_booking/providers/hotel_view_model.dart';
import 'package:travel_booking/providers/single_hotel_viewmodel.dart';
import 'package:travel_booking/routes/route_generator.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<CommonViewModel>(
              create: (_) => CommonViewModel()),
          ChangeNotifierProvider<FlightSettingProvider>(
              create: (_) => FlightSettingProvider()),
          ChangeNotifierProvider<DayCounter>(create: (_) => DayCounter()),
          ChangeNotifierProvider<SingleHotelViewModel>(create: (_) => SingleHotelViewModel()),
          ChangeNotifierProvider<HotelViewModel>(
              create: (_) => HotelViewModel()),
          ChangeNotifierProvider<HolidayPackageViewModel>(
              create: (_) => HolidayPackageViewModel()),
          ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
          ChangeNotifierProvider<AirLineViewModel>(
              create: (_) => AirLineViewModel())
        ],
        child: const MaterialApp(
          title: 'Travel Booking',
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.routeName,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
