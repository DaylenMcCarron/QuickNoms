import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:quicknoms/controller/services/fetchRestaurantServices/fetchRestaurantServices.dart';
import 'package:quicknoms/model/foodModel.dart';
import 'package:quicknoms/model/restaurantModel.dart';

class RestaurantProvider extends ChangeNotifier {
  List<RestaurantModel> restaurants = [];
  List<FoodModel> foods = [];

  addRestaurants(String restaurantID) async {
    RestaurantModel data =
        await RestaurantServices.fetchRestrauntData(restaurantID);
    restaurants.add(data);
    notifyListeners();
    log("Total Restaurant fetched are: ");
    log(restaurants.length.toString());
  }

  addFoods(String restaurantID) async {
    List<FoodModel> foodData =
        await RestaurantServices.fetchFoodData(restaurantID);
    foods.addAll(foodData);
    notifyListeners();
    log("Total Foods fetched are: ");
    log(foods.length.toString());
  }
}
