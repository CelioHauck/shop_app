import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order_item.dart' as o;

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key, required o.OrderItem order})
      : _order = order,
        super(key: key);

  final o.OrderItem _order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('R\$ ${_order.amount}'),
          subtitle: Text(
            DateFormat('dd/MM/yyyy hh:mm').format(_order.dateTime),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.expand_more),
            onPressed: () {},
          ),
        )
      ]),
    );
  }
}
