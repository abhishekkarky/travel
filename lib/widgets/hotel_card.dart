import 'package:flutter/material.dart';
import 'package:travel_booking/pages/model/hotel_model.dart';
import 'package:travel_booking/pages/views/hotel/single_hotel.dart';

class HotelCard extends StatelessWidget {
  HotelModel e;
  HotelCard({super.key,required this.e});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // print(e.id);
        Navigator.of(context).pushNamed(SingleHotelScreen.routeName, arguments: e.id);
      },
      child: Container(
        width: 250,
        child: Card(
          elevation: 5,
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    e.imageUrl.toString(),
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            e.hotelName.toString(),
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                          Text(
                            "Rs. ${e.price}",
                            style: const TextStyle(fontSize: 15, color: Colors.green),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
