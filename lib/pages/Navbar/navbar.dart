import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_booking/pages/views/airlines/airlines_screen.dart';
import 'package:travel_booking/pages/views/bookings/booking_screen.dart';
import 'package:travel_booking/pages/views/home.dart';
import 'package:travel_booking/pages/views/hotel/hotel.dart';
import 'package:travel_booking/providers/hotel_view_model.dart';

import '../views/holiday/holiday_package.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});
  static const String routeName = "/nav-bar";

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const Hotel(),
    const AirlineScreen(),
    const HolidayPackageScreen(),
    const BookingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
   showUnselectedLabels: true,
        unselectedItemColor: Colors.grey.shade600,
        unselectedLabelStyle: TextStyle(color: Colors.grey.shade600),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.hotel),
            label: 'Hotel',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket_sharp),
            label: 'Airlines',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.backpack),
            label: 'Packages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books),
            label: 'Bookings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[600],
        backgroundColor: Colors.white.withOpacity(0.9),
        onTap: _onItemTapped,
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Navbar(),
  ));
}
