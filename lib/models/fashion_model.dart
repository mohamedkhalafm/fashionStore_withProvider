import 'package:flutter/cupertino.dart';

class FashionModel with ChangeNotifier {
  final String? id;
  final String name;
  final double price;
  final double discount;
  final String image;
  final bool? isInCart;
  final String? size;
  final Color? color;
  bool? isInFavorites;

  FashionModel({
    this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.image,
    this.isInCart,
    this.size,
    this.color,
    this.isInFavorites,
  });

  void changeFavoritesStatus(){
    isInFavorites =! isInFavorites!;
    notifyListeners();
  }
  
}

   

