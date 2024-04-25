import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:travel_booking/constants/app_colors.dart' as appcolors;
import 'package:travel_booking/providers/holiday_package_view_model.dart';
import 'package:travel_booking/providers/hotel_view_model.dart';
import 'package:travel_booking/widgets/airline_card.dart';
import 'package:travel_booking/widgets/hotel_card.dart';
import 'package:travel_booking/widgets/package_card.dart';

import '../../../providers/airline_view_model.dart';
import '../../../providers/day_coun_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/custom_slider.dart';
import '../../../widgets/date_formatter.dart';
import '../../../widgets/date_picker.dart';

class AirlineScreen extends StatefulWidget {
  const AirlineScreen({super.key});

  @override
  _AirlineScreenState createState() => _AirlineScreenState();
}

class _AirlineScreenState extends State<AirlineScreen> {
  final TextEditingController _checkInDateController = TextEditingController();
  final TextEditingController _checkOutDateController = TextEditingController();
  String? initialDate, finalDate;

  dayCountProvider() async {
    _checkInDateController.text = dateFormatter(
        Provider.of<DayCounter>(context, listen: false).initialDate!);
    _checkOutDateController.text = dateFormatter(
        Provider.of<DayCounter>(context, listen: false).finalDate!);

    finalDate = _checkOutDateController.text;
    initialDate = _checkInDateController.text;
  }

  late AirLineViewModel _airLineViewModel;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _airLineViewModel = Provider.of<AirLineViewModel>(context, listen: false);
      _airLineViewModel.getAirlines();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    dayCountProvider();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Airlines'),
          elevation: 5,
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
          child: Column(
            children: [


              Consumer<AirLineViewModel>(builder: (context ,airlines, child) {
                return GridView.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: [
                    ...airlines.holidayPackage.map((e) => AirlineCard(
                      e: e,
                    ))
                  ],
                );
              }),
            ],
          ),
        ));
  }
}
