import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_booking/pages/model/book_model.dart';
import 'package:travel_booking/repo/booking_repo.dart';
import 'package:travel_booking/widgets/flight_settings.dart';

import '../../../providers/auth_view_model.dart';
import '../../../providers/single_hotel_viewmodel.dart';

class SingleAirlinesScreen extends StatelessWidget {
  String id;
  SingleAirlinesScreen({super.key, required this.id});
  static const String routeName = "/single-airlines";

  @override
  Widget build(BuildContext context) {
    return SingleAirlinesBody(
      id: id,
    );
  }
}

class SingleAirlinesBody extends StatefulWidget {
  String id;
  SingleAirlinesBody({super.key, required this.id});

  @override
  State<SingleAirlinesBody> createState() => _SingleAirlinesBodyState();
}

class _SingleAirlinesBodyState extends State<SingleAirlinesBody> {
  late SingleHotelViewModel _singleProductViewModel;

  late AuthViewModel _authViewModel;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _singleProductViewModel =
          Provider.of<SingleHotelViewModel>(context, listen: false);
      _authViewModel = Provider.of<AuthViewModel>(context, listen: false);

      print("this is args ${widget.id}");
      getData(widget.id);
    });
    super.initState();
  }

  Future<void> getData(String hotelId) async {
    // _ui.loadState(true);
    try {
      // await _authViewModel.getFavoritesUser();
      await _singleProductViewModel.getAirlines(hotelId);
    } catch (e) {}
    // _ui.loadState(false);
  }

  // Future<void> favoritePressed(FavoriteModel? isFavorite, String hotelId) async {
  //   _ui.loadState(true);
  //   try {
  //     await _authViewModel.favoriteAction(isFavorite, hotelId);
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Favorite updated.")));
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text("Something went wrong. Please try again.")));
  //     print(e);
  //   }
  //   _ui.loadState(false);
  // }

  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Consumer2<SingleHotelViewModel, AuthViewModel>(
        builder: (context, singleProductVM, authVm, child) {
      return singleProductVM.airlines == null
          ? Scaffold(
              body: Container(
                child: const Text("Error"),
              ),
            )
          : singleProductVM.airlines!.id == null
              ? Scaffold(
                  body: Center(
                    child: Container(
                      child: const Text("Please wait..."),
                    ),
                  ),
                )
              : Scaffold(
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  floatingActionButton: Container(
                      height: 70,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(width: 1, color: Colors.black12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () {

                            Navigator.of(context).pushNamed(FlightSetting.routeName,arguments: singleProductVM.airlines);

                          },
                          child: const Text(
                            "Book now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
                  appBar: AppBar(),
                  backgroundColor: const Color(0xFFf5f5f4),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network(
                          singleProductVM.airlines!.imageUrl.toString(),
                          height: 400,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset(
                              'assets/images/logo.png',
                              height: 400,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            decoration:
                                const BoxDecoration(color: Colors.white70),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rs. ${singleProductVM.airlines!.price}",
                                  style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w900),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  singleProductVM.airlines!.airlineName
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${singleProductVM.airlines!.destination} - ${singleProductVM.airlines!.arrival}",
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  singleProductVM.airlines!.baggage.toString(),
                                  style: const TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(
                                  height: 100,
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                );
    });
  }
}
