import 'package:shopapp/models/order.dart';
import 'package:shopapp/provider/app.dart';
import 'package:shopapp/provider/user.dart';
import 'package:shopapp/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: CustomText(text: "Orders"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: userProvider.orders.length,
          itemBuilder: (_, index) {
            OrderModel _order = userProvider.orders[index];
            return ListTile(
              leading: CustomText(
                text: "\$${_order.total! / 100}",
                weight: FontWeight.bold,
              ),
              title: Text(_order.description.toString()),
              subtitle: Text((DateTime.fromMillisecondsSinceEpoch(
                      _order.createdAt!.toInt()))
                  .toString()),
              trailing: CustomText(
                text: _order.status.toString(),
                color: Colors.green,
              ),
            );
          }),
    );
  }
}
