import 'package:fashion/models/cart_model.dart';
import 'package:fashion/widgets/cart_item.dart';

class OrderModel{
  final String id;
  final double amount;
  final List<CardModel> fashions;
  final DateTime dateTime;

  OrderModel({
    required this.id,
    required this.amount,
    required this.fashions,
    required this.dateTime,
  });
}