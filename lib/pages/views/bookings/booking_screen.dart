import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:travel_booking/constants/app_colors.dart' as appcolors;
import 'package:travel_booking/pages/Authentication/login.dart';
import 'package:travel_booking/providers/common_view_model.dart';
import 'package:travel_booking/providers/hotel_view_model.dart';
import 'package:travel_booking/repo/booking_repo.dart';
import 'package:travel_booking/widgets/hotel_card.dart';

import '../../../providers/auth_view_model.dart';
import '../../../providers/day_coun_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_date_picker.dart';
import '../../../widgets/custom_slider.dart';
import '../../../widgets/date_formatter.dart';
import '../../../widgets/date_picker.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late CommonViewModel _commonViewModel;
  late AuthViewModel _authViewModel;
  String? productId;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      _commonViewModel = Provider.of<CommonViewModel>(context, listen: false);
      // _commonViewModel.getBookings();
    });
    super.initState();
  }

  Future<List<DocumentSnapshot>> getBooking() async {
    try {
      var instance = FirebaseFirestore.instance.collection('bookings');
      var response = await instance.get();
      var category = response.docs
          .where(
              (doc) => doc['userId'] == FirebaseAuth.instance.currentUser!.uid)
          .toList();
      return category;
    } catch (err) {
      print(err);
      throw err;
    }
  }

  void logout() async{

    try{
      await _authViewModel.logout().then((value){
        Navigator.of(context).pushReplacementNamed(Login.routeName);
      })
          .catchError((e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString())));
      });
    }catch(err){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err.toString())));
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Bookings'),
          actions: [
            InkWell(
                onTap: (){
                  logout();
                },
                child: Icon(Icons.logout))
          ],
          elevation: 5,
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              // Consumer<CommonViewModel>(
              //   builder: (context,common,child) {
              //     return GridView.count(
              //       crossAxisSpacing: 10,
              //       mainAxisSpacing: 10,
              //       childAspectRatio: 0.7,
              //       physics: NeverScrollableScrollPhysics(),
              //       shrinkWrap: true,
              //       crossAxisCount: 2,
              //       children: [
              //         ...common.bookings.map((e) => Card(
              //           child: Column(
              //             children: [
              //               Text(e.bookingType ?? ""),
              //               Text(e.bookingName ?? ""),
              //             ],
              //           ),
              //         ))
              //       ],
              //     );
              //   }
              // ),
              FutureBuilder(
                future: getBooking(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CupertinoActivityIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }else if (snapshot.data!.isEmpty) {
                    return Center(child: Text("Currently no booking found"));
                  }  else {
                    List<DocumentSnapshot> data = snapshot.data!;
                    return ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {

                        Map<String, dynamic> bookingData =
                            data[index].data() as Map<String, dynamic>;
                        // Display your data here
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(
                                  bookingData['bookingType'].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 23),
                                ),
                                    ListTile(
                                      leading: Image.network(bookingData['imageUrl']),
                                      title:  Text(
                                        bookingData['bookingName'].toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600, fontSize: 23),
                                      ),
                                      trailing: InkWell(
                                        onTap: () {
                                          _deleteBooking(data[index].id);
                                        },
                                        child: Icon(Icons.delete,color: Colors.red,),
                                      ),
                                    )
                              ]
                                  // Other widgets to display additional data
                                  ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              )
            ],
          ),
        ));
  }
  Future<void> _deleteBooking(String bookingId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get a reference to the document
      DocumentReference docRef = firestore.collection('bookings').doc(bookingId);

      // Delete the document
      await docRef.delete();

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking deleted successfully')),
      );

      // Reload data
      setState(() {});
    } catch (error) {
      // Show an error message if deletion fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete booking')),
      );
    }
  }
}
