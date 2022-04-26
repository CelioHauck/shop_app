import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required UniqueKey id,
    required double price,
    required String productId,
    required int quantity,
    required String title,
  })  : _id = id,
        _price = price,
        _quantity = quantity,
        _productId = productId,
        _title = title,
        super(key: key);

  final UniqueKey _id;
  final double _price;
  final int _quantity;
  final String _title;
  final String _productId;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(_id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              'Are you sure?',
            ),
            content: const Text(
              'Do you want to remove the item from the cart?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(_productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text('R\$ $_price'),
                ),
              ),
            ),
            title: Text(_title),
            subtitle: Text('Total: R\$${_price * _quantity}'),
            trailing: Text('$_quantity x'),
          ),
        ),
      ),
    );
  }
}
