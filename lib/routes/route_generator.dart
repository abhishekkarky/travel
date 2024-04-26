import 'package:flutter/material.dart';
import 'package:travel_booking/pages/Authentication/login.dart';
import 'package:travel_booking/pages/Navbar/navbar.dart';
import 'package:travel_booking/pages/model/airline_repo.dart';
import 'package:travel_booking/pages/splash.dart';
import 'package:travel_booking/pages/views/holiday/single_holiday.dart';
import 'package:travel_booking/pages/views/home.dart';

import '../pages/views/airlines/single_airlines.dart';
import '../pages/views/hotel/single_hotel.dart';
import '../widgets/flight_settings.dart';

class RouteGenerator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName, {Object? args}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  static Future<dynamic> replacePage(String routeName, {Object? args}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: args);
  }

  static goBack() {
    return navigatorKey.currentState?.pop();
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Home.routeName:
        return MaterialPageRoute(builder: (_) => const Home());

      case Login.routeName:
        return MaterialPageRoute(builder: (_) => const Login());
      case FlightSetting.routeName:
        return MaterialPageRoute(builder: (_) => FlightSetting(data: args as AirlineModel,));

      case Navbar.routeName:
        return MaterialPageRoute(builder: (_) => const Navbar());
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case SingleHotelScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => SingleHotelScreen(
                  id: args as String,
                ));
      case SingleHolidayScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => SingleHolidayScreen(
                  id: args as String,
                ));
      case SingleAirlinesScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => SingleAirlinesScreen(
                  id: args as String,
                ));

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
