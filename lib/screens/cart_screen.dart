import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/cart_item.dart';

import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orderProvider = Provider.of<Orders>(context, listen: false);
    final scaffold = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your cart!'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(25),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      'R\$ ${cart.totalAmount.toStringAsPrecision(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6!.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        await orderProvider.addOrder(
                          cart.items.values.toList(),
                          cart.totalAmount,
                        );
                        cart.clear();
                      } catch (_) {
                        scaffold.showSnackBar(
                          const SnackBar(
                            content: Text('Ocorreu um erro'),
                          ),
                        );
                      }
                    },
                    child: const Text('Order now!'),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final actualCard = cart.items.values.toList()[index];
              return CartItem(
                id: actualCard.id,
                productId: cart.items.keys.toList()[index],
                title: actualCard.title,
                quantity: actualCard.quantity,
                price: actualCard.price,
              );
            },
          ))
        ],
      ),
    );
  }
}
