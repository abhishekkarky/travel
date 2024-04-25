import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:travel_booking/constants/app_colors.dart' as appcolors;
import 'package:travel_booking/providers/holiday_package_view_model.dart';
import 'package:travel_booking/providers/hotel_view_model.dart';
import 'package:travel_booking/widgets/hotel_card.dart';
import 'package:travel_booking/widgets/package_card.dart';

import '../../../providers/day_coun_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/custom_slider.dart';
import '../../../widgets/date_formatter.dart';
import '../../../widgets/date_picker.dart';

class HolidayPackageScreen extends StatefulWidget {
  const HolidayPackageScreen({super.key});

  @override
  _HolidayPackageScreenState createState() => _HolidayPackageScreenState();
}

class _HolidayPackageScreenState extends State<HolidayPackageScreen> {
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

  late HolidayPackageViewModel _holidayPackageViewModel;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _holidayPackageViewModel = Provider.of<HolidayPackageViewModel>(context, listen: false);
      _holidayPackageViewModel.getHolidayPackage();
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
          title: const Text('Holiday Package'),
          elevation: 5,
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
          child: Column(
            children: [


              Consumer<HolidayPackageViewModel>(builder: (context, packages, child) {
                return GridView.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: [
                    ...packages.holidayPackage.map((e) => HolidayPackageCard(
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
