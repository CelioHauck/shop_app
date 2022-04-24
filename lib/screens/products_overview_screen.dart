import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My shop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions value) {
              setState(() {
                _showOnlyFavorites = value == FilterOptions.favorites;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.favorites),
              const PopupMenuItem(
                  child: Text('Show all'), value: FilterOptions.all),
            ],
            icon: const Icon(
              Icons.more_vert,
            ),
          )
        ],
      ),
      body: ProductsGrid(
        showOnlyFavorites: _showOnlyFavorites,
      ),
    );
  }
}
