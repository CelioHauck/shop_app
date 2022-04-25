import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required UniqueKey id,
    required double price,
    required int quantity,
    required String title,
  })  : _id = id,
        _price = price,
        _quantity = quantity,
        _title = title,
        super(key: key);

  final UniqueKey _id;
  final double _price;
  final int _quantity;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
