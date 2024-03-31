import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quicknoms/constant/constant.dart';
import 'package:quicknoms/controller/provider/itemOrderProvider/itemOrderProvider.dart';
import 'package:quicknoms/controller/services/foodOrderServices/foodOrderServices.dart';
import 'package:quicknoms/model/foodModel.dart';
import 'package:quicknoms/utils/colors.dart';
import 'package:quicknoms/utils/textStyles.dart';
import 'package:quicknoms/widgets/commonElevatedButton.dart';
import 'package:quicknoms/widgets/toastService.dart';
import 'package:sizer/sizer.dart';

class FoodDetailsScreen extends StatefulWidget {
  const FoodDetailsScreen({super.key, required this.foodModel});
  final FoodModel foodModel;

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        quantity = 0;
      });
    });
  }

  int quantity = 0;
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
            )),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 2.h,
        ),
        children: [
          SizedBox(
            height: 2.h,
          ),
          SizedBox(
            height: 23.h,
            width: 100.w,
            child: Image(
              image: NetworkImage(
                widget.foodModel.foodImageURL,
              ),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            widget.foodModel.name,
            style: AppTextStyles.body16Bold,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            widget.foodModel.description,
            style: AppTextStyles.body14.copyWith(
              color: grey,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Container(
            height: 8.h,
            width: 100.w,
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            decoration: BoxDecoration(
              color: green200,
              borderRadius: BorderRadius.circular(
                5.sp,
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Order now and save ${(((int.parse(widget.foodModel.actualPrice) - int.parse(widget.foodModel.discountedPrice)) / int.parse(widget.foodModel.actualPrice)) * 100).round().toString()} %',
                  style: AppTextStyles.body14Bold,
                ),
                SizedBox(
                  width: 2.w,
                ),
                FaIcon(
                  FontAwesomeIcons.tag,
                  color: black,
                )
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (quantity > 0) {
                        setState(() {
                          quantity -= 1;
                        });
                      }
                    },
                    child: Container(
                      height: 3.h,
                      width: 3.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          3.sp,
                        ),
                        border: Border.all(
                          color: black87,
                        ),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.minus,
                        size: 2.h,
                        color: black,
                      ),
                    ),
                  ),
                  Text(
                    '\t\t $quantity \t\t',
                    style: AppTextStyles.body14Bold,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        quantity += 1;
                      });
                    },
                    child: Container(
                      height: 3.h,
                      width: 3.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          3.sp,
                        ),
                        border: Border.all(
                          color: black87,
                        ),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        size: 2.h,
                        color: black,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '₹${widget.foodModel.actualPrice}',
                    style: AppTextStyles.body14.copyWith(
                      decoration: TextDecoration.lineThrough,
                      color: grey,
                    ),
                  ),
                  Text(
                    '₹${widget.foodModel.discountedPrice}',
                    style: AppTextStyles.body16Bold,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          CommonElevatedButton(
            onPressed: () async {
              if (quantity > 0) {
                String foodID = uuid.v1();
                FoodModel foodData = FoodModel(
                    name: widget.foodModel.name,
                    restaurantUID: widget.foodModel.restaurantUID,
                    uploadTime: widget.foodModel.uploadTime,
                    foodID: widget.foodModel.foodID,
                    description: widget.foodModel.description,
                    foodImageURL: widget.foodModel.foodImageURL,
                    isVegetarian: widget.foodModel.isVegetarian,
                    actualPrice: widget.foodModel.actualPrice,
                    discountedPrice: widget.foodModel.discountedPrice,
                    quantity: quantity,
                    orderID: foodID,
                    addedToCartAt: DateTime.now());
                await FoodOrderServices.addItemToCart(foodData, context);
                context.read<ItemOrderProvider>().fetchCartItems();
              } else {
                ToastService.sendScaffoldAlert(
                  msg: 'Select a valid Quantity ',
                  toastStatus: 'WARNING',
                  context: context,
                );
              }
            },
            color: white,
            child: Text(
              'Add to basket',
              style: AppTextStyles.body14Bold.copyWith(color: black),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          CommonElevatedButton(
            onPressed: () {},
            color: black,
            child: Text(
              'Order Now',
              style: AppTextStyles.body14Bold.copyWith(color: white),
            ),
          ),
        ],
      ),
    ));
  }
}
