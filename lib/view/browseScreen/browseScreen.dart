import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:quicknoms/controller/provider/restaurantProvider/restaurantProvider.dart';
import 'package:quicknoms/model/foodModel.dart';
import 'package:quicknoms/utils/colors.dart';
import 'package:quicknoms/utils/textStyles.dart';
import 'package:quicknoms/view/foodDetailsScreen/foodDetailsScreen.dart';
import 'package:sizer/sizer.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  TextEditingController searchFoodController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(
                100.w,
                12.h,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: TextField(
                  controller: searchFoodController,
                  cursorColor: black,
                  style: AppTextStyles.textFieldTextStyle,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    context
                        .read<RestaurantProvider>()
                        .searchFoodItems(value.trim());
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 2.w),
                    hintText: 'Search Food',
                    hintStyle: AppTextStyles.textFieldHintTextStyle,
                    // filled: true,
                    // fillColor: greyShade3,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: black,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: grey,
                      ),
                    ),
                  ),
                ),
              )),
          body: Consumer<RestaurantProvider>(
              builder: (context, restaurantProvider, child) {
            if (restaurantProvider.searchedFood.isEmpty) {
              return Center(
                child: Text(
                  'Search For Food',
                  style: AppTextStyles.body14Bold.copyWith(color: grey),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: restaurantProvider.searchedFood.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    FoodModel foodData = restaurantProvider.searchedFood[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: FoodDetailsScreen(foodModel: foodData),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 1.5.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 1.h),
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '₹${foodData.discountedPrice}',
                                  style: AppTextStyles.body16Bold,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
          })),
    );
  }
}
