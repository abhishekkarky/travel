import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_booking/pages/model/hotel_model.dart';

import '../services/firebase_service.dart';

class HotelRepository {
  CollectionReference<HotelModel> hotelRef =
      FirebaseService.db.collection("hotels").withConverter<HotelModel>(
            fromFirestore: (snapshot, _) {
              return HotelModel.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );
  Future<List<QueryDocumentSnapshot<HotelModel>>> getHotels() async {
    try {
      var data = await hotelRef.get();
      bool hasData = data.docs.isNotEmpty;
      if (!hasData) {
        creatHotels().forEach((element) async {
          await hotelRef.add(element);
        });
      }
      final response = await hotelRef.get();
      var category = response.docs;
      return category;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<DocumentSnapshot<HotelModel>> getOneProduct(String id) async {
    try {
      final response = await hotelRef.doc(id).get();
      if (!response.exists) {
        throw Exception("Hotel doesnot exists");
      }
      return response;
    } catch (err) {
      print(err);
      rethrow;
    }
  }
  // Future<DocumentSnapshot<HotelModel>> getCategory(String categoryId) async {
  //   try {
  //     print(categoryId);
  //     final response = await hotelRef.doc(categoryId).get();
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  List<HotelModel> creatHotels() {
    return [
      HotelModel(
          hotelName: "Hyatt Regency Kathmandu",
          location: "Kathmandu",
          desc: "Hyatt Regency Kathmandu is a 5 star luxury hotel and resort in Kathmandu and is set on 37 acres of landscaped grounds, created in the traditional Newari style of Nepalese architecture. This beautiful hotel and resort is located on the road to the Boudhanath Stupa: the most holy of all Tibetan Buddhist shrines outside of Tibet, and a UNESCO World Heritage Site which is 5 minutes walk from the hotel. The hotel is just 4 km (2.4 miles) from the Tribhuvan International Airport and 6 km (3.7 miles) from the city center of Kathmandu.",
          price: 25000,
          ratings: 5,
          rooms: 5,
          imageUrl:
              "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/23/6a/72/1a/exterior.jpg?w=1100&h=1100&s=1"),
      HotelModel(
          hotelName: "Kathmandu Eco Hotel",
          location: "Kathmandu",
          desc: "Kathmandu Eco Hotel is a 2-minute walk from the Thamel Tourist Market. Kathmandu Durbar Square is 1 km from the hotel while Pashupatinath Temple is 5 km away. Tribhuvan International Airport is located 7 km from the hotel. Featuring rooms with a private bathroom, Kathmandu Eco Hotel is located at Thamel, the bustling tourist hub of Kathmandu. A rooftop area with dining tables and chairs and free Wi-Fi is available. Stay in a fan-cooled or air-conditioned room with a flat-screen satellite TV, seating area and electric kettle. ",
          price: 12000,
          ratings: 4,
          rooms: 5,
          imageUrl:
              "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0e/de/f7/c3/standard-room.jpg?w=1200&h=1200&s=1"),
      HotelModel(
          hotelName: "The Soaltee Kathmandu",
          location: "Kathmandu",
          desc: "An exceptional blend of royal and traditional elegance, The Soaltee Kathmandu Nepal’s premier 5 Star hotel is set in lush green 12 acres of landscaped area with a magnificent view of the Himalayas. It’s located in peaceful Tahachal just 8km from the Tribhuvan International Airport and 4km from the city center its finest shopping destinations, cultural attractions, and entertainment options in Kathmandu. Architecturally stunning, authentic Nepali in style the hotel features 285 beautifully appointed heritage & modern rooms, largest casino and spa in the city, wide range of fine dining options including authentic Nepali, Chinese, Indian and Italian with brilliantly designed meeting spaces making it an ideal destination for business, leisure, and all celebration",
          price: 15000,
          ratings: 3,
          rooms: 5,
          imageUrl:
              "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/26/d3/da/0f/club-king.jpg?w=1100&h=1100&s=1"),
      HotelModel(
          hotelName: "Oasis Kathmandu Hotel",
          location: "Kathmandu",
          desc: "Oasis Kathmandu Hotel, situated in the heart of Thamel and attached with the Garden of Dream, is dedicated to providing exceptionally friendly and personalized services. Our amenities are plentiful and the value beyond your imagination, ensuring the most pleasurable and memorable stay. We see our customers as invited guests to a party where we are the hosts. It is our goal to make every day a better experience for you.",
          price: 13000,
          ratings: 2,
          rooms: 5,
          imageUrl:
              "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/10/7e/95/8f/deluxe-twin-room.jpg?w=1200&h=1200&s=1"),
      HotelModel(
          hotelName: "Hotel Friend's Home",
          location: "Kathmandu",
          desc: "Located in the eastern part of Thamel in Kathmandu, Hotel Friends Home offers genuinely friendly accommodation to all kinds of travelers, with a spirit of newness and constant innovation in its services. From the moment you check in at this family-friendly hotel, the amiable staff will readily receive you with the warmth of Nepalese hospitality and dedicate themselves to make your stay as cozy and comfortable as you want it to be",
          price: 8000,
          ratings: 3,
          rooms: 5,
          imageUrl:
              "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/17/38/d6/87/deluxe-family-room.jpg?w=1200&h=1200&s=1"),
      HotelModel(
          hotelName: "Dalai-La Boutique Hotel",
          location: "Kathmandu",
          desc: "25 boutique rooms housed in traditional Nepalese architecture with dining and lounge area spread over expansive premises. Surround yourself in the environs of traditional Nepalese architecture, accentuated with a harmonious balance of Buddhist motifs. From restored 50 years old hand-carved pillars and Dhunge Dhara (hand-carved stone water taps) adorning the courtyard to traditional lattice windows called Tikijhyā and hand-made Dacchi Itta (local terracotta bricks) on the facade of the hotel",
          price: 9000,
          ratings: 2,
          rooms: 5,
          imageUrl:
              "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/10/aa/d3/23/deluxe-room.jpg?w=1200&h=1200&s=1"),


    ];
  }
}
