import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quicknoms/controller/provider/restaurantProvider/restaurantProvider.dart';
import 'package:quicknoms/model/restaurantModel.dart';
import 'package:quicknoms/utils/colors.dart';
import 'package:quicknoms/utils/textStyles.dart';
import 'package:quicknoms/view/particularRestaurantMenuScreen/particularRestaurantMenuScreen.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List categories = [
    ['assets/categories/asian.png', 'Asian'],
    ['assets/categories/burger.png', 'Burger'],
    ['assets/categories/carrebian.png', 'Carrebian'],
    ['assets/categories/chinese.png', 'Chinese'],
  ];

  BannerImages(RestaurantModel restaurant) {
    List<String> bannerImages = [];
    if (restaurant.bannerImage1 != null) {
      bannerImages.add(restaurant.bannerImage1!);
    }
    if (restaurant.bannerImage2 != null) {
      bannerImages.add(restaurant.bannerImage2!);
    }
    if (restaurant.bannerImage3 != null) {
      bannerImages.add(restaurant.bannerImage3!);
    }
    if (restaurant.bannerImage4 != null) {
      bannerImages.add(restaurant.bannerImage4!);
    }
    log(bannerImages.toString());
    return bannerImages;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.h),
          children: [
            SizedBox(
              height: 2.h,
            ),
            Text(
              "Current Location",
              style: AppTextStyles.body16Bold,
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.sp),
                      color: greyShade3,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'American',
                          style: AppTextStyles.small12Bold,
                        ),
                        const Image(
                            image: AssetImage('assets/categories/american.png'))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.sp),
                      color: greyShade3,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Grocery',
                          style: AppTextStyles.small12Bold,
                        ),
                        const Image(
                            image: AssetImage('assets/categories/grocery.png'))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: categories
                  .map(
                    (e) => Column(
                      children: [
                        Container(
                          height: 22.w,
                          width: 22.w,
                          decoration: BoxDecoration(
                            color: greyShade3,
                            borderRadius: BorderRadius.circular(5.sp),
                          ),
                          child: Image(
                            image: AssetImage(e[0]),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          e[1],
                          style: AppTextStyles.small10,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
            SizedBox(
              height: 2.h,
            ),
            Divider(
              thickness: 1.h,
              color: greyShade2,
            ),
            SizedBox(
              height: 2.h,
            ),
            Consumer<RestaurantProvider>(
                builder: (context, RestaurantProvider, child) {
              if (RestaurantProvider.restaurants.isEmpty) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 20.h,
                        width: 94.w,
                        margin: EdgeInsets.symmetric(vertical: 1.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.sp),
                            color: greyShade3),
                      );
                    });
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: RestaurantProvider.restaurants.length,
                    itemBuilder: (context, index) {
                      CarouselController controller = CarouselController();
                      RestaurantModel restaurant =
                          RestaurantProvider.restaurants[index];
                      List<String> bannerImages = BannerImages(restaurant);
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: ParticularRestaurantScreen(
                                restaurantUID: restaurant.restaurantUID!,
                                restaurantName: restaurant.restaurantName!,
                              ),
                              type: PageTransitionType.rightToLeft,
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 2.h),
                          margin: EdgeInsets.symmetric(
                            vertical: 1.5.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5.sp,
                            ),
                            border: Border.all(
                              color: black87,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 23.h,
                                width: 94.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      5.sp,
                                    ),
                                    border: Border.all(color: greyShade3)),
                                child: CarouselSlider(
                                  carouselController: controller,
                                  options: CarouselOptions(
                                    height: 23.h,
                                    autoPlay: true,
                                    viewportFraction: 1,
                                  ),
                                  items: bannerImages
                                      .map(
                                        (image) => Container(
                                          width: 94.w,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                restaurant.restaurantName!,
                                style: AppTextStyles.body16Bold,
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }
            }),
          ],
        ),
      ),
    );
  }
}
