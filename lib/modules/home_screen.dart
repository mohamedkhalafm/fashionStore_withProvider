// ignore_for_file: constant_identifier_names

import 'package:fashion/component/reusable_components.dart';
import 'package:fashion/modules/cart_screem.dart';
import 'package:fashion/modules/my_fashio_screen.dart';
import 'package:fashion/providers/cart_provider.dart';
import 'package:fashion/providers/fashion_provider.dart';
import 'package:fashion/widgets/cart_icon.dart';
import 'package:fashion/widgets/fashion_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routePass = 'homeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool onlyFavorites = false;
  bool isLoading = true;
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    Provider.of<FashionProvider>(context, listen: false)
        .getAllFashions()
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: firstColor,
      appBar: AppBar(
        backgroundColor: secondColor,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(MyFashionScreen.routeName);
            },
            icon: const Icon(Icons.person_pin_sharp)),
        title: const Text('Home',
            style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton(
            onSelected: (Options selectedVal) {
              setState(() {
                if (selectedVal == Options.Favorites) {
                  //model.favorits();
                  onlyFavorites = true;
                } else if (selectedVal == Options.All) {
                  onlyFavorites = false;
                }
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('View Favorites'),
                value: Options.Favorites,
              ),
              const PopupMenuItem(
                child: Text('View All'),
                value: Options.All,
              ),
            ],
            icon: const Icon(Icons.more_horiz_rounded),
          ),
          Consumer<CartProvider>(
              builder: (context, provider, _) => CartIcon(
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(CartScreen.routeName);
                      },
                      icon: const Icon(Icons.shopping_bag)),
                  value: provider.myPurchases.toString(),
                  color: Colors.red))
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : FashionGrid(onlyFavorites),
    );
  }
}

enum Options { Favorites, All }
