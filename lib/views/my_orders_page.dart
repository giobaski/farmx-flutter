import 'package:farmx/models/lot.dart';
import 'package:farmx/models/order.dart';
import 'package:farmx/services/order_service.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';


class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {

  // List<Order> _myOrders = [
  //   Order(id: 1, description: "descr", amount: 20, orderDateTime: "today",
  //       lot: Lot(id: 1,productName: "pn", description: "descr", currentAmount: 100, openingPrice: 1.0, closingPrice: 3.0, closingDate: "today" )),
  //   Order(id: 2, description: "decr", amount: 15, orderDateTime: "yesterday",
  //       lot: Lot(id: 1,productName: "pn", description: "descr", currentAmount: 100, openingPrice: 1.0, closingPrice: 3.0, closingDate: "today" )
  // ),
  // ];

  List<Order> orders = [];

  void fetchOrders() {
    OrderService.fetchOrdersByUsername().then((value) => setState((){
      orders = value;
      print("##### from setState() in MyOrdersPage, after receiving orders");
      print(orders.toString());
    }));
  }

  @override
  void initState() {
    super.initState();

    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Orders"),),
      body: Column(
        children: orders.map((order) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.history),
              title: Text("Order ID #${order.id}"),
              subtitle: Text("Order Amount \$ ${order.amount}"),
              trailing:  Text("UNPAID",
                  style: TextStyle(
                      color: Colors.red,
                      backgroundColor: Colors.amber,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
          );
        }).toList(),

      ),
    );
  }
}
