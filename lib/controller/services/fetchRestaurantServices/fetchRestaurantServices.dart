import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:quicknoms/constant/constant.dart';
import 'package:quicknoms/controller/provider/restaurantProvider/restaurantProvider.dart';
import 'package:quicknoms/controller/services/locationServices/locationServices.dart';
import 'package:quicknoms/model/foodModel.dart';
import 'package:quicknoms/model/restaurantIDAndLocationModel.dart';
import 'package:quicknoms/model/restaurantModel.dart';

class RestaurantServices {
  static getNearbyRestaurants(BuildContext context) async {
    //Geofire.initialize('Restaurants');
    Position currentPosition = await LocationServices.getCurrentLocation();
    GeoFirePoint center = geo.point(
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude);

    var collectionReference = firestore.collection('location');
    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: collectionReference)
        .within(center: center, radius: 20, field: 'position');
    stream.listen((List<DocumentSnapshot> documentList) {
      documentList.forEach((DocumentSnapshot snapshot) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          // Extract restaurantUID
          String restaurantUID = data['restaurantUID'];

          // Extract latitude and longitude from the GeoPoint object
          GeoPoint positionData = data['position']['geopoint'];

          // Do something with the extracted data
          log('Restaurant UID: $restaurantUID');
          RestaurantIDAndLocationModel model = RestaurantIDAndLocationModel(
              id: data['restaurantUID'],
              latitude: positionData.latitude,
              longitude: positionData.longitude);
          log(model.toJson().toString());
          context.read<RestaurantProvider>().addRestaurants(model.id);
          context.read<RestaurantProvider>().addFoods(model.id);
        }
      });
    });
  }

  static fetchRestaurantData(String restaurantID) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('Restaurant').doc(restaurantID).get();

      RestaurantModel data = RestaurantModel.fromMap(snapshot.data()!);
      return data;
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  static fetchFoodData(String restaurantID) async {
    List<FoodModel> foodData = [];
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('Food')
          .orderBy('uploadTime', descending: true)
          .where('restaurantUID', isEqualTo: restaurantID)
          .get();
      snapshot.docs.forEach((element) {
        foodData.add(FoodModel.fromMap(element.data()));
      });
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
    return foodData;
  }
}
