import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:quicknoms/controller/services/fetchRestaurantServices/fetchRestaurantServices.dart';
import 'package:quicknoms/model/foodModel.dart';
import 'package:quicknoms/model/restaurantModel.dart';

class RestaurantProvider extends ChangeNotifier {
  List<RestaurantModel> restaurants = [];
  List<FoodModel> foods = [];
  List<FoodModel> restaurantMenu = [];
  List<FoodModel> searchedFood = [];

  addRestaurants(String restaurantID) async {
    RestaurantModel data =
        await RestaurantServices.fetchRestaurantData(restaurantID);
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

  getRestaurantMenu(String restaurantID) {
    for (var data in foods) {
      if (data.restaurantUID == restaurantID) {
        restaurantMenu.add(data);
      }
    }
    notifyListeners();
  }

  emptyRestaurantMenu() {
    restaurantMenu = [];
    notifyListeners();
  }

  defaultSearchedFood() {
    searchedFood = foods;
    notifyListeners();
  }

  searchFoodItems(String foodName) {
    searchedFood = [];
    notifyListeners();
    for (var data in foods) {
      if (data.name.toLowerCase().contains(foodName.toLowerCase())) {
        searchedFood.add(data);
      }
    }
    notifyListeners();
  }
}
