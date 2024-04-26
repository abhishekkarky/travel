import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:travel_booking/pages/model/book_model.dart';
import 'package:travel_booking/repo/booking_repo.dart';

import '../../../providers/auth_view_model.dart';
import '../../../providers/single_hotel_viewmodel.dart';

class SingleHotelScreen extends StatelessWidget {
  String id;
  SingleHotelScreen({super.key, required this.id});
  static const String routeName = "/single-hotel";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SingleHotelViewModel>(
        create: (_) => SingleHotelViewModel(),
        child: SingleProductBody(
          id: id,
        ));
  }
}

class SingleProductBody extends StatefulWidget {
  String id;
  SingleProductBody({super.key, required this.id});

  @override
  State<SingleProductBody> createState() => _SingleProductBodyState();
}

class _SingleProductBodyState extends State<SingleProductBody> {
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
      await _singleProductViewModel.getProducts(hotelId);
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
      return singleProductVM.hotel == null
          ? Scaffold(
              body: Container(
                child: const Text("Error"),
              ),
            )
          : singleProductVM.hotel!.id == null
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
                                                .hotel!.hotelName,
                                            bookingType: "Hotel",
                                            imageUrl:
                                                singleProductVM.hotel!.imageUrl,
                                            price: singleProductVM.hotel!.price,
                                            productId:
                                                singleProductVM.hotel!.id,
                                          ))
                                              .then((value) {
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Booking successful")));
                                          });
                                        },
                                        child: const Text("Yes"))
                                  ],
                                  title: const Text("Confirm"),
                                  content: Text(
                                    "Are you sure you want to book ${singleProductVM.hotel!.hotelName}",
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                );
                              },
                            );
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
                          singleProductVM.hotel!.imageUrl.toString(),
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
                                  "Rs. ${singleProductVM.hotel!.price}",
                                  style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.green,
                                      fontWeight: FontWeight.w900),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  singleProductVM.hotel!.hotelName.toString(),
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  singleProductVM.hotel!.desc.toString(),
                                  style: const TextStyle(
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: FlutterMap(
                                    options: MapOptions(
                                      initialCenter: LatLng(
                                        singleProductVM.hotel!.lat as double,
                                        singleProductVM.hotel!.lon as double,
                                      ),
                                      initialZoom: 16,
                                    ),
                                    children: [
                                      TileLayer(
                                        urlTemplate:
                                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                        userAgentPackageName: 'com.example.app',
                                      ),
                                    ],
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
