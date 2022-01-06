import 'package:fashion/models/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  Map<String, CardModel> _items = {};

  Map<String, CardModel> get items {
    return {..._items};
  }

  void addItem(
    String fashoinId,
    double price,
    String name,
    String image,
  ) {
    if (_items.containsKey(fashoinId)) {
      _items.update(
          fashoinId,
          (existingCardModel) => CardModel(
            image: existingCardModel.image,
              id: existingCardModel.id,
              name: existingCardModel.name,
              price: existingCardModel.price,
              quantity: existingCardModel.quantity + 1));
    } else {
      _items.putIfAbsent(
          fashoinId,
          () => CardModel(
            image: image,
              id: DateTime.now().toString(),
              name: name,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  int get myPurchases {
    return _items.length;
    print(myPurchases.toString());
  }

  double get totaPrice {
    double total = 0.0;
    _items.forEach((key, CardModel) {
      total += CardModel.price * CardModel.quantity;
    });
    return total;
  }

  void deleteCartItem(String fashionId) {
    _items.remove(fashionId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSinglePiece(String fashionId) {
    if (!_items.containsKey(fashionId)) {
      return;
    }
    if (_items[fashionId]!.quantity > 1) {
      _items.update(
          fashionId,
          (value) => CardModel(
            image: value.image,
              id: value.id,
              name: value.name,
              price: value.price,
              quantity: value.quantity));
    }else{
      _items.remove(fashionId);
    }
    notifyListeners();
  }

  
 
  
}
