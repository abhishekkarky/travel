import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:travel_booking/constants/app_colors.dart' as appcolors;
import 'package:travel_booking/providers/hotel_view_model.dart';
import 'package:travel_booking/widgets/hotel_card.dart';

import '../../../providers/day_coun_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/custom_slider.dart';
import '../../../widgets/date_formatter.dart';
import '../../../widgets/date_picker.dart';

class Hotel extends StatefulWidget {
  const Hotel({super.key});

  @override
  _HotelState createState() => _HotelState();
}

class _HotelState extends State<Hotel> {
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

  late HotelViewModel _hotelViewModel;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hotelViewModel = Provider.of<HotelViewModel>(context, listen: false);
      _hotelViewModel.getHotels();
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
          title: const Text('Hotels'),
          elevation: 5,
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
          child: Column(
            children: [

              // Row(
              //   children: [
              //     Expanded(
              //       child: CustomDatePicker(
              //         data: 'Check IN',
              //         controller: _checkInDateController,
              //         onTap: () async {
              //           final picked = await selectDate(context,
              //               initialRange: DateTimeRange(
              //                   start: Provider.of<DayCounter>(context,
              //                           listen: false)
              //                       .initialDate!,
              //                   end: Provider.of<DayCounter>(context,
              //                           listen: false)
              //                       .finalDate!));
              //           _checkInDateController.text = picked.start.toString();
              //           _checkOutDateController.text = picked.end.toString();
              //           context.read<DayCounter>().countDate(
              //               _checkInDateController.text,
              //               _checkOutDateController.text);
              //         },
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     Expanded(
              //       child: CustomDatePicker(
              //         data: 'Check Out',
              //         controller: _checkOutDateController,
              //         onTap: () async {
              //           final picked = await selectDate(context,
              //               initialRange: DateTimeRange(
              //                   start: Provider.of<DayCounter>(context,
              //                           listen: false)
              //                       .initialDate!,
              //                   end: Provider.of<DayCounter>(context,
              //                           listen: false)
              //                       .finalDate!));
              //           _checkInDateController.text = picked.start.toString();
              //           _checkOutDateController.text = picked.end.toString();
              //           // firstDate= DateTime.parse(_checkInDateController.text));
              //           context.read<DayCounter>().countDate(
              //               _checkInDateController.text,
              //               _checkOutDateController.text);
              //         },
              //       ),
              //     ),
              //   ],
              // ),
              Consumer<HotelViewModel>(builder: (context, hotels, child) {
                return GridView.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: [
                    ...hotels.hotels.map((e) => HotelCard(
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
