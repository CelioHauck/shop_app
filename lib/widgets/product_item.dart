import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String _id;
  final String _title;
  final String _imageUrl;

  const ProductItem({
    Key? key,
    required String id,
    required String title,
    required String imageUrl,
  })  : _id = id,
        _title = title,
        _imageUrl = imageUrl,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final secondaryColor = Theme.of(context).colorScheme.secondary;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: _id,
            );
          },
          child: Image.network(
            _imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            color: secondaryColor,
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
          title: Text(
            _title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            color: secondaryColor,
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
