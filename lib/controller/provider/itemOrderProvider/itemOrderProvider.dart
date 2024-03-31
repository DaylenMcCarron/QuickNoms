import 'package:flutter/foundation.dart';
import 'package:quicknoms/controller/services/foodOrderServices/foodOrderServices.dart';
import 'package:quicknoms/model/foodModel.dart';

class ItemOrderProvider extends ChangeNotifier {
  List<FoodModel> cartItems = [];

  fetchCartItems() async {
    cartItems = await FoodOrderServices.fetchCartData();
    notifyListeners();
  }
}
