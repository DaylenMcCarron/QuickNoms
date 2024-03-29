import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quicknoms/utils/textStyles.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List categories = [
    ['assets/categories/alcohol.png', 'Alcohol'],
    ['assets/categories/american.png', 'American'],
    ['assets/categories/asian.png', 'Asian'],
    ['assets/categories/burger.png', 'Burger'],
    ['assets/categories/carrebian.png', 'Carrebian'],
    ['assets/categories/chinese.png', 'Chinese'],
    ['assets/categories/convenience.png', 'Convenience'],
    ['assets/categories/dessert.png', 'Dessert'],
    ['assets/categories/fastFood.png', 'Fast Food'],
    ['assets/categories/flower.png', 'Flower'],
    ['assets/categories/french.png', 'French'],
    ['assets/categories/grocery.png', 'Grocery'],
    ['assets/categories/halal.png', 'Halal'],
    ['assets/categories/icecream.png', 'Ice cream'],
    ['assets/categories/indian.png', 'Indian'],
    ['assets/categories/petSupplies.png', 'Pet Supplies'],
    ['assets/categories/retails.png', 'Retails'],
    ['assets/categories/ride.png', 'Ride'],
    ['assets/categories/takeout.png', 'Takeout'],
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
          children: [
            SizedBox(
              height: 2.h,
            ),
            Text(
              'All Categories',
              style: AppTextStyles.body16,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 3.h,
            ),
            GridView.builder(
              itemCount: categories.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.sp),
                            color: const Color.fromARGB(10, 0, 0, 0)),
                        child: Image(
                          image: AssetImage(categories[index][0]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.3.h,
                    ),
                    Text(
                      categories[index][1],
                      style: AppTextStyles.small10,
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
