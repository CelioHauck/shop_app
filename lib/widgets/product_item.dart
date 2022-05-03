import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

import '../providers/cart.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  // final String _id;
  // final String _title;
  // final String _imageUrl;

  // const ProductItem({
  //   Key? key,
  //   required String id,
  //   required String title,
  //   required String imageUrl,
  // })  : _id = id,
  //       _title = title,
  //       _imageUrl = imageUrl,
  //       super(key: key);

  const ProductItem({Key? key}) : super(key: key);

  Future<void> toogleFavorite(Products provider, Product product) async {
    try {
      product.toggleFavoriteStatus();
      await provider.toogleFavorite(product.id, product.isFavorite);
    } catch (e) {
      product.toggleFavoriteStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    final product = Provider.of<Product>(context, listen: false);
    final products = Provider.of<Products>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: FadeInImage(
            placeholder: const AssetImage(
              'assets/images/product-placeholder.png',
            ),
            image: NetworkImage(
              product.imageUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, product, child) => IconButton(
              color: secondaryColor,
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_outline,
              ),
              onPressed: () async {
                await toogleFavorite(products, product);
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            color: secondaryColor,
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              cart.addItem(
                product.id,
                product.price,
                product.title,
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Added item to cart!"),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
