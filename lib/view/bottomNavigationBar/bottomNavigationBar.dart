import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:quicknoms/view/account/account.dart';
import 'package:quicknoms/view/basket/basketScreen.dart';
import 'package:quicknoms/view/browse/browse.dart';
import 'package:quicknoms/view/home/homeScreen.dart';
import 'package:quicknoms/view/grocery/groceryScreen.dart';

class BottomNavigationBarQuickNoms extends StatefulWidget {
  const BottomNavigationBarQuickNoms({super.key});

  @override
  State<BottomNavigationBarQuickNoms> createState() =>
      _BottomNavigationBarQuickNomsState();
}

class _BottomNavigationBarQuickNomsState
    extends State<BottomNavigationBarQuickNoms> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      tabs: [
        PersistentTabConfig(
          screen: const HomeScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.home),
            title: "Home",
          ),
        ),
        PersistentTabConfig(
          screen: const BrowseScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.calendar_view_month_sharp),
            title: "Browse",
          ),
        ),
        PersistentTabConfig(
          screen: const GroceryScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.shopping_bag),
            title: "Grocery",
          ),
        ),
        PersistentTabConfig(
          screen: const BasketScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.shopping_cart),
            title: "Basket",
          ),
        ),
        PersistentTabConfig(
          screen: const AccountScreen(),
          item: ItemConfig(
            icon: const Icon(Icons.account_circle),
            title: "Account",
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
      ),
    );
  }
}
