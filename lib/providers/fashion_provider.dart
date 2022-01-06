import 'dart:convert';

import 'package:fashion/component/reusable_components.dart';
import 'package:fashion/models/fashion_model.dart';
import 'package:fashion/widgets/fashion_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class FashionProvider with ChangeNotifier {
    List<FashionModel> _piece = [
  //   FashionModel(
  //       id: '1',
  //       name: 'half cool',
  //       price: 180,
  //       discount: 25,
  //       image:
  //           'https://image.freepik.com/free-photo/portrait-charismatic-beaded-guy-white-sweater-assure-you-winking-showing-okay-sign-guar_1258-64213.jpg',
  //       isInCart: false,
  //       size: 'L',
  //       color: Colors.white,
  //       isInFavorites: false),
  //   FashionModel(
  //       id: '2',
  //       name: 'dress',
  //       price: 990,
  //       discount: 50,
  //       image:
  //           'https://image.freepik.com/free-photo/lovely-young-parisian-woman-with-brunette-hair-stylish-beret-beige-trench-coat-black-bag-standing-old-stairs-sensitively-posing-outdoors_197531-24472.jpg',
  //       isInCart: false,
  //       size: 'L',
  //       color: Colors.grey,
  //       isInFavorites: false),
  //   FashionModel(
  //       id: '3',
  //       name: 'Shirt',
  //       price: 220,
  //       discount: 30,
  //       image:
  //           'https://image.freepik.com/free-photo/portrait-handsome-confident-hipster-lumbersexual-businessman-model-wearing-casual-jeans-shirt-clothes_158538-17413.jpg',
  //       isInCart: false,
  //       size: 'M',
  //       color: Colors.blue,
  //       isInFavorites: false),
  //   FashionModel(
  //       id: '4',
  //       name: 'Complete set',
  //       price: 710,
  //       discount: 43,
  //       image:
  //           'https://image.freepik.com/free-photo/fashion-hipster-male-model-posing-outdoor_158595-809.jpg',
  //       isInCart: false,
  //       size: 'L',
  //       color: Colors.black,
  //       isInFavorites: false),
  //   FashionModel(
  //       id: '5',
  //       name: 'yellow-glasses',
  //       price: 180,
  //       discount: 25,
  //       image:
  //           'https://image.freepik.com/free-photo/surprised-happy-girl-pointing-left-recommend-product-advertisement-make-okay-gesture_176420-20191.jpg',
  //       isInCart: false,
  //       size: 'L',
  //       color: Colors.brown,
  //       isInFavorites: false),
  //   FashionModel(
  //       id: '6',
  //       name: 'Hand bag',
  //       price: 60,
  //       discount: 15,
  //       image:
  //           'https://image.freepik.com/free-photo/fashion-portrait-young-businessman-handsome-model-man-casual-cloth-suit-with-accessories-hands_158538-9455.jpg',
  //       isInCart: false,
  //       size: 'L',
  //       color: Colors.white,
  //       isInFavorites: false),

  //   ali@gmail.com
   ];

  bool _onlyFavorites = false;

  // return a copy of the list
  // to update only the widget needed
  

  final String authToken;
  final String userId;

  FashionProvider(this.authToken,this._piece, this.userId);

  List<FashionModel> get piece {
    // if(_onlyFavorites){
    //   return _piece.where((element) => element.isInFavorites).toList();
    // }
    return [..._piece];
    notifyListeners();
  }

  List<FashionModel> get favorites {
    return _piece.where((element) => element.isInFavorites!).toList();
  }

  Future<void> addFashion(FashionModel product) async{
    final url = Uri.https(
        'fashion-f3538-default-rtdb.firebaseio.com', '/fashions.json?auth=$authToken');
        try{
          final response = await http
        .post(url,
            body: json.encode({
              'name': product.name,
              'price': product.price,
              'discount': product.discount,
              'image': product.image,
              'creatorId': userId,
              'isInFavorites': product.isInFavorites,
            }));
            final newProduct = FashionModel(
          name: product.name,
          discount: product.discount,
          price: product.price,
          image: product.image,
          color: firstColor,
          isInCart: true,
          isInFavorites: true,
          size: 'L',
          id: json.decode(response.body)['name']);
      _piece.add(newProduct);
      notifyListeners();
        }catch(e){
          print(e);
        }
  }

  // Future<void> getAllFashions() async {
  //   final url = Uri.https(
  //       'fashion-f3538-default-rtdb.firebaseio.com', '/fashions.json?auth=$authToken');
    
  //   try{
  //     final res = await http.get(url);
  //     final List<FashionModel> loadedFashions = [];
  //     final  myFashionFromServer = json.decode(res.body) as Map<String, dynamic>;
  //     if(myFashionFromServer==null)
  //     {return;}
  //     myFashionFromServer.forEach((fashionId, fashionItem) {
  //       loadedFashions.add(FashionModel(
  //           id: fashionId,
  //           name: fashionItem['name'],
  //           price: fashionItem['price'],
  //           discount: fashionItem['discount'],
  //           image: fashionItem['image'],
  //           //isInCart: fashionItem['isInCart'],
  //           //size: fashionItem['size'],
  //           //color: fashionItem['color'],
  //           isInFavorites: fashionItem['isInFavorites']));
            
  //     });
  //     _piece = loadedFashions;
  //           notifyListeners();
  //   }catch(e){
  //     print(e);
  //   }
  //   //return res;
  // }

  Future<void> getAllFashions() async {
    final url = 'https://fashion-f3538-default-rtdb.firebaseio.com/fashions.json?auth=$authToken';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<FashionModel> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(FashionModel(
          id: prodId,
          name: prodData['name'],
          discount: prodData['discount'],
          price: prodData['price'],
          isInFavorites: prodData['isInFavorites'],
          image: prodData['image'],
        ));
      });
      _piece = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateFashion(String id, FashionModel newFashion) async{
    final fashionIndex = _piece.indexWhere((element) => element.id == id);
    if (fashionIndex >= 0) {
      final url = Uri.https(
        'https://fashion-f3538-default-rtdb.firebaseio.com', '/fashions/$id.json?auth=$authToken');
        await http.patch(url,body: json.encode({
          'name': newFashion.name,
              'price': newFashion.price,
              'discount': newFashion.discount,
              'image': newFashion.image,
        }));
      _piece[fashionIndex] = newFashion;
      notifyListeners();
    } else {
      print( 'NULL');
    }
  }

  Future<void> deleteFashion(String id) async{
    final url = Uri.https(
        'https://fashion-f3538-default-rtdb.firebaseio.com', '/fashions/$id.json?auth=$authToken');
    final existingItemIndex = _piece.indexWhere((element) => element.id == id);
    FashionModel? existingItem = _piece[existingItemIndex];
    _piece.removeAt(existingItemIndex);
    notifyListeners();
    http.delete(url).then((value) {
      existingItem = null;
    }).catchError((e){
      _piece.insert(existingItemIndex, existingItem! );
    });    
    _piece.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  // void favorits(){
  //   _onlyFavorites = true;
  //   notifyListeners();
  // }

  // void all(){
  //   _onlyFavorites = false;
  //   notifyListeners();
  // }

  // void chart(){
  //   _onlyFavorites = false;
  //   notifyListeners();
  // }

  FashionModel findById(String id) {
    return _piece.firstWhere((fashion) => fashion.id == id);
  }
}


//    ali@gmail.com