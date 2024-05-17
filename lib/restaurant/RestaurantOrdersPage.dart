import 'package:flutter/material.dart';
import '../database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantOrdersPage extends StatefulWidget {
  const RestaurantOrdersPage({Key? key}) : super(key: key);

  @override
  _RestaurantOrdersPageState createState() => _RestaurantOrdersPageState();

  void refreshRestaurantOrders() {
    final state = _RestaurantOrdersPageState();
    if (state.mounted) {
      state._loadOrders();
    }
  }
}

class _RestaurantOrdersPageState extends State<RestaurantOrdersPage> {
  List<Map<String, dynamic>> _orders = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }
Future<void> _deleteOrder(int orderId) async {
  int rowsDeleted = await DatabaseHelper.instance.deleteOrder(orderId);
  if (rowsDeleted > 0) {
     setState(() {
      _orders = _orders.where((order) => order['id'] != orderId).toList();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order cancelled'),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to cancel order'),
      ),
    );
  }
}  Future<void> _loadOrders() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    if (userId != null) {
      final orders = await DatabaseHelper.instance.getOrdersForUser(userId);
      setState(() {
        _orders = orders;
      });
    } else {
       print('User not logged in');
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Restaurant Orders'),
    ),
    body: ListView.builder(
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        final order = _orders[index];
        return Card(
          elevation: 2.0,
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Text(order['restaurant_name']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location: ${order['location']}'),
                Text('Order Details: ${order['order_details']}'),
                Text('Total Price: \$${order['total_price'].toStringAsFixed(2)}'),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _deleteOrder(order['id']);
              },
            ),
          ),
        );
      },
    ),
  );
}}