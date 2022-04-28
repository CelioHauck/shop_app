import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem(
      {Key? key,
      required String title,
      required String id,
      required String imageUrl})
      : _title = title,
        _id = id,
        _imageUrl = imageUrl,
        super(key: key);

  final String _title;
  final String _id;
  final String _imageUrl;

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(_title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          _imageUrl,
        ),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditproductScreen.routeName,
                  arguments: _id,
                );
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(_id);
                } catch (e) {
                  scaffold.showSnackBar(const SnackBar(
                    content: Text("Failed delete !"),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
