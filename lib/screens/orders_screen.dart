import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

import '../providers/orders.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        //TIP: Pode dar problema se for um statefulWidget que altera o estado
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Consumer<Orders>(
            builder: (context, value, child) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return OrderItem(order: value.orders[index]);
                },
                itemCount: value.orders.length,
              );
            },
          );
        },
        future: Provider.of<Orders>(context, listen: false).fetchOrders(),
      ),
    );
  }
}
