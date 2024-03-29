import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quicknoms/controller/provider/restaurantProvider/restaurantProvider.dart';
import 'package:quicknoms/model/foodModel.dart';
import 'package:quicknoms/utils/colors.dart';
import 'package:quicknoms/utils/textStyles.dart';
import 'package:quicknoms/view/foodDetailsScreen/foodDetailsScreen.dart';
import 'package:sizer/sizer.dart';

class ParticularRestaurantScreen extends StatefulWidget {
  const ParticularRestaurantScreen(
      {super.key, required this.restaurantUID, required this.restaurantName});
  final String restaurantUID;
  final String restaurantName;

  @override
  State<ParticularRestaurantScreen> createState() =>
      _ParticularRestaurantScreenState();
}

class _ParticularRestaurantScreenState
    extends State<ParticularRestaurantScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<RestaurantProvider>().emptyRestaurantMenu();
      context
          .read<RestaurantProvider>()
          .getRestaurantMenu(widget.restaurantUID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: FaIcon(
            FontAwesomeIcons.arrowLeftLong,
            color: black,
          ),
        ),
        title: Text(
          widget.restaurantName,
          style: AppTextStyles.body16Bold,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, RestaurantProvider, child) {
          if (RestaurantProvider.restaurantMenu.isEmpty) {
            return Center(
              child: Text(
                'Fetching Food Items',
                style: AppTextStyles.body14Bold.copyWith(color: grey),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: RestaurantProvider.restaurantMenu.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                FoodModel foodData = RestaurantProvider.restaurantMenu[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            child: FoodDetailsScreen(
                              foodModel: foodData,
                            ),
                            type: PageTransitionType.rightToLeft));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 1.5.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        5.sp,
                      ),
                      border: Border.all(
                        color: Colors.black12,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.sp),
                            image: DecorationImage(
                                image: NetworkImage(
                                  foodData.foodImageURL,
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          foodData.name,
                          style: AppTextStyles.body14Bold,
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          foodData.description,
                          style: AppTextStyles.small12.copyWith(
                            color: grey,
                          ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${(((int.parse(foodData.actualPrice) - int.parse(foodData.discountedPrice)) / int.parse(foodData.actualPrice)) * 100).round().toString()} %',
                                  style: AppTextStyles.body14Bold,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                FaIcon(
                                  FontAwesomeIcons.tag,
                                  color: success,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '₹${foodData.actualPrice}',
                                  style: AppTextStyles.body14.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: grey,
                                  ),
                                ),
                                Text(
                                  '₹${foodData.discountedPrice}',
                                  style: AppTextStyles.body16Bold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    ));
  }
}
