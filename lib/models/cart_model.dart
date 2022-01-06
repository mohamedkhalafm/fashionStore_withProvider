import 'dart:collection';

class CardModel{
  final String id;
  final String name;
  final int quantity;
  final double price;
  final String image;

  CardModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
  });

}