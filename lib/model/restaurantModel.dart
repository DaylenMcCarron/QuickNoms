// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:quicknoms/model/address.dart';

class RestaurantModel {
  String? restaurantName;
  String? restaurantLicenseNumber;
  String? restaurantUID;
  String? bannerImage1;
  String? bannerImage2;
  String? bannerImage3;
  String? bannerImage4;
  AddressModel? address;
  String? cloudMessagingToken;
  RestaurantModel({
    this.restaurantName,
    this.restaurantLicenseNumber,
    this.restaurantUID,
    this.bannerImage1,
    this.bannerImage2,
    this.bannerImage3,
    this.bannerImage4,
    this.address,
    this.cloudMessagingToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'restaurantName': restaurantName,
      'restaurantLicenseNumber': restaurantLicenseNumber,
      'restaurantUID': restaurantUID,
      'bannerImage1': bannerImage1,
      'bannerImage2': bannerImage2,
      'bannerImage3': bannerImage3,
      'bannerImage4': bannerImage4,
      'address': address?.toMap(),
      'cloudMessagingToken': cloudMessagingToken,
    };
  }

  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      restaurantName: map['restaurantName'] != null
          ? map['restaurantName'] as String
          : null,
      restaurantLicenseNumber: map['restaurantLicenseNumber'] != null
          ? map['restaurantLicenseNumber'] as String
          : null,
      restaurantUID:
          map['restaurantUID'] != null ? map['restaurantUID'] as String : null,
      bannerImage1:
          map['bannerImage1'] != null ? map['bannerImage1'] as String : null,
      bannerImage2:
          map['bannerImage2'] != null ? map['bannerImage2'] as String : null,
      bannerImage3:
          map['bannerImage3'] != null ? map['bannerImage3'] as String : null,
      bannerImage4:
          map['bannerImage4'] != null ? map['bannerImage4'] as String : null,
      address: map['address'] != null
          ? AddressModel.fromMap(map['address'] as Map<String, dynamic>)
          : null,
      cloudMessagingToken: map['cloudMessagingToken'] != null
          ? map['cloudMessagingToken'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantModel.fromJson(String source) =>
      RestaurantModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
