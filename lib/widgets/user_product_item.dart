import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem(
      {Key? key, required String title, required String imageUrl})
      : _title = title,
        _imageUrl = imageUrl,
        super(key: key);

  final String _title;
  final String _imageUrl;

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
              icon: const Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}