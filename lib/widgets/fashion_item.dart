import 'package:fashion/component/reusable_components.dart';
import 'package:fashion/models/fashion_model.dart';
import 'package:fashion/modules/fashion_details_screen.dart';
import 'package:fashion/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FashionItem extends StatelessWidget {
  // final String id;
  // final String name;
  // final String price;
  // final String image;
  // final bool isInCart;
  // final bool isInFavorites;

  // FashionItem(
  //   this.id,
  //   this.name,
  //   this.price,
  //   this.image,
  //   this.isInCart,
  //   this.isInFavorites,
  // );

  @override
  Widget build(BuildContext context) {
    final fashionId = ModalRoute.of(context)!.settings.arguments.toString();
    final model = Provider.of<FashionModel>(
      context,
    );
    final cart = Provider.of<CartProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        height: 450,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(17.0),
                      topEnd: Radius.circular(17.0))),
              child: Card(
                elevation: 22,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(17.0),
                          topEnd: Radius.circular(17.0))),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, FashionDetailsScreen.routePass,
                          arguments: model.id);
                    },
                    child: Stack(
                      children: [
                        Hero(
                          tag: model.id!,
                          child: Image(
                            image: NetworkImage(model.image),
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 30,
                              color: Colors.black54,
                              child: Text('Discount ${model.discount}  \$',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: secondColor,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        cart.addItem(model.id!, model.price, model.name,model.image);
                        Scaffold.of(context).hideCurrentSnackBar(); 
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Piece Added to the Cart'),
                            duration: Duration(seconds: 3),
                            action: SnackBarAction(label: 'UNDO', onPressed: (){
                              cart.removeSinglePiece(model.id!);
                            }),
                            ));
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      )),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        model.changeFavoritesStatus();
                      },
                      icon: Icon(
                        model.isInFavorites!
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            Text(model.name,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text('${model.price} \$ ',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
