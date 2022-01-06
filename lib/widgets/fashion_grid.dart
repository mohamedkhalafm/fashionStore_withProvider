import 'package:fashion/providers/fashion_provider.dart';
import 'package:fashion/widgets/fashion_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FashionGrid extends StatelessWidget {
 
  final bool onlyFAvorits;
  FashionGrid(this.onlyFAvorits);
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<FashionProvider>(context);
    //final modelProvider = providerData.piece;
    final modelProvider = onlyFAvorits ?  providerData.favorites : providerData.piece;
    return GridView.builder(
      itemCount: modelProvider.length,
      // scrollDirection: Axis.vertical,
      // crossAxisCount: 2,mainAxisSpacing: 9,
      itemBuilder: (context, index) => ChangeNotifierProvider(
        create: (context)=> modelProvider[index],
        child: FashionItem(
        // modelProvider[index].id,
        // modelProvider[index].name,
        // modelProvider[index].image,
        // modelProvider[index].price,
        // modelProvider[index].isInFavorites,
        // modelProvider[index].isInFavorites,
      ),),
      
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 1 / 1.77),
    );
  }
}
