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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Travellers"),
      ),
      body: SingleChildScrollView(
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
                    isSelected: Provider.of<FlightSettingProvider>(context)
                        .economyCabin,
                    onTap: () {
                      Provider.of<FlightSettingProvider>(context,
                              listen: false)
                          .setEconomyCabin();
                    },
                  ),
                  CustomChip(
                    title: 'Business',
                    isSelected: Provider.of<FlightSettingProvider>(context)
                        .businessCabin,
                    onTap: () {
                      Provider.of<FlightSettingProvider>(context,
                              listen: false)
                          .setBusinessCabin();
                    },
                  ),
                  CustomChip(
                    title: 'Premium Economy',
                    isSelected: Provider.of<FlightSettingProvider>(context)
                        .premiumEconomyCabin,
                    onTap: () {
                      Provider.of<FlightSettingProvider>(context,
                              listen: false)
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
              title_2: Provider.of<FlightSettingProvider>(context)
                  .adultCount
                  .toString(),
              onRem: () {
                if (Provider.of<FlightSettingProvider>(context, listen: false)
                        .adultCount >
                    1) {
                  Provider.of<FlightSettingProvider>(context, listen: false)
                      .removeAdult();
                }
              },
              onTap: () {
                Provider.of<FlightSettingProvider>(context, listen: false)
                    .addAdult();
              },
            ),
        
            CustomTextAndButton(
              title: 'Children',
              title_1: '2-11 years old',
              title_2: Provider.of<FlightSettingProvider>(context)
                  .childrenCount
                  .toString(),
              onRem: () {
                Provider.of<FlightSettingProvider>(context, listen: false)
                    .removeChildren();
              },
              onTap: () {
                Provider.of<FlightSettingProvider>(context, listen: false)
                    .addChildren();
              },
            ),
            CustomTextAndButton(
              title: 'Infant',
              title_1: 'Below 2 years old',
              title_2: Provider.of<FlightSettingProvider>(context)
                  .infantOnLapCount
                  .toString(),
              onRem: () {
                Provider.of<FlightSettingProvider>(context, listen: false)
                    .removeInfantOnLap();
              },
              onTap: () {
                Provider.of<FlightSettingProvider>(context, listen: false)
                    .addInfantOnLap();
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                  "*** Infants must be less or equal than number of Adults"),
            ),
            Consumer<SingleHotelViewModel>(
                builder: (context, singleProductVM, child) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("No")),
                              TextButton(
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
                                      adult: Provider.of<FlightSettingProvider>(
                                              context)
                                          .adultCount,
                                      child: Provider.of<FlightSettingProvider>(
                                              context)
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
                                  child: const Text("Yes"))
                            ],
                            title: const Text("Confirm "),
                            content: const Text(
                              "Are you sure you want to book",
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text("Confirm Booking")),
              );
            }),
            // CustomTextAndButton(
            //   title: 'Toddler in own seat',
            //   title_1: 'Under 2',
            //   title_2: Provider.of<FlightSettingProvider>(context)
            //       .infantOnSeatCount
            //       .toString(),
            //   onRem: () {
            //     Provider.of<FlightSettingProvider>(context, listen: false)
            //         .removeInfantOnSeat();
            //   },
            //   onTap: () {
            //     Provider.of<FlightSettingProvider>(context, listen: false)
            //         .addInfantOnSeat();
            //   },
            // ),
        
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
      ),
    );
  }
}
