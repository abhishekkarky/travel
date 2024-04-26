import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';
import '../pages/model/book_model.dart';
import '../providers/flight_setting_provider.dart';
import '../providers/single_hotel_viewmodel.dart';
import '../repo/booking_repo.dart';
import 'custom_chip.dart';
import 'custom_text_button.dart';

class FlightSetting extends StatefulWidget {
  const FlightSetting({super.key});
  static const String routeName = "/flight-setting";

  @override
  State<FlightSetting> createState() => _FlightSettingState();
}

class _FlightSettingState extends State<FlightSetting> {
  TextStyle style = const TextStyle();
  late FlightSettingProvider _flightSettingProvider;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _flightSettingProvider = Provider.of<FlightSettingProvider>(context,listen: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Travellers"),
      ),
      body: Consumer2<FlightSettingProvider,SingleHotelViewModel>(
        builder: (context,flightSettings,singleProductVM,child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 450,
                  height: 35,
                  color: lightGreen2,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(20, 6, 0, 6),
                    child: Text(
                      'Cabin type:',
                    ),
                  ),
                ),
                // SizedBox(height: 16,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: [
                      CustomChip(
                        title: 'Economy',
                        isSelected: flightSettings
                            .economyCabin,
                        onTap: () {
                          flightSettings
                              .setEconomyCabin();
                        },
                      ),
                      CustomChip(
                        title: 'Business',
                        isSelected:flightSettings
                            .businessCabin,
                        onTap: () {
                          flightSettings
                              .setBusinessCabin();
                        },
                      ),
                      CustomChip(
                        title: 'Premium Economy',
                        isSelected: flightSettings
                            .premiumEconomyCabin,
                        onTap: () {
                          flightSettings
                              .setPremiumEconomyCabin();
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 35,
                  color: lightGreen2,
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(20, 6, 0, 6),
                    child: Text(
                      'Travellers',
                    ),
                  ),
                ),

                CustomTextAndButton(
                  title: 'Adults',
                  title_1: '',
                  title_2: flightSettings
                      .adultCount
                      .toString(),
                  onRem: () {
                    if (flightSettings
                        .adultCount >
                        1) {
                      flightSettings
                          .removeAdult();
                    }
                  },
                  onTap: () {
                    flightSettings
                        .addAdult();
                  },
                ),

                CustomTextAndButton(
                  title: 'Children',
                  title_1: '2-11 years old',
                  title_2: flightSettings
                      .childrenCount
                      .toString(),
                  onRem: () {
                    flightSettings
                        .removeChildren();
                  },
                  onTap: () {
                    flightSettings
                        .addChildren();
                  },
                ),
                CustomTextAndButton(
                  title: 'Infant',
                  title_1: 'Below 2 years old',
                  title_2: flightSettings
                      .infantOnLapCount
                      .toString(),
                  onRem: () {
                    flightSettings
                        .removeInfantOnLap();
                  },
                  onTap: () {
                    flightSettings
                        .addInfantOnLap();
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                      "*** Infants must be less or equal than number of Adults"),
                ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(

                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    BookingRepo()
                        .addToCart(BookingModel(
                      bookingName: singleProductVM
                          .airlines?.airlineName ??
                          "",
                      bookingType: "Airlines",
                      imageUrl:
                      singleProductVM.airlines!.imageUrl,
                      price: singleProductVM.airlines!.price,
                      productId: singleProductVM.airlines!.id,
                      adult: flightSettings
                          .adultCount,
                      child: flightSettings
                          .childrenCount,
                    ))
                        .then((value) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                          content:
                          Text("Booking successful")));
                    });
                  },
                  child: const Text("Confirm Booking")),
            ),


                const SizedBox(
                  height: 20,
                ),
                // Center(
                //     child: CustomButton(
                //         width: 335,
                //         height: 48,
                //         buttonName: 'Save',
                //         onClick: () {})),
                const SizedBox(
                  height: 48,
                )
              ],
            ),
          );
        }
      ),
    );
  }
}