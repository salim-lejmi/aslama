import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database_helper.dart';
import 'RestaurantOrdersPage.dart';

class RestaurantPage extends StatelessWidget {
  final String type;

  const RestaurantPage({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Restaurant> restaurants = getRestaurantForType(type);

    return Scaffold(
      appBar: AppBar(
        title: Text('$type Restaurants'),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return RestaurantListTile(restaurant: restaurants[index]);
        },
      ),
    );
  }

  List<Restaurant> getRestaurantForType(String type) {
    if (type == 'Modern') {
      return [
        Restaurant(
          name: "L'aromate Restaurant - Pizzeria",
          location: 'Sousse',
          rating: 3.8,
          imageAsset: 'assets/images/restaurants/aromate.jpg',
          menu: [
            MenuItem(name: 'Pizza Margherita', price: 10.0),
            MenuItem(name: 'Pasta Carbonara', price: 12.0),
            MenuItem(name: 'Grilled Salmon', price: 18.0),
          ],
        ),
        Restaurant(
          name: 'LE CHANDELIER - CANDLE HOUSE',
          location: 'Monastir',
          rating: 4.2,
          imageAsset: 'assets/images/restaurants/chandelier.jpg',
          menu: [
            MenuItem(name: 'Steak Frites', price: 16.0),
            MenuItem(name: 'Caesar Salad', price: 8.0),
            MenuItem(name: 'Crème Brûlée', price: 6.0),
          ],
        ),
      ];
    } else if (type == 'Traditional') {
      return [
        Restaurant(
          name: 'Dar Chraka',
          location: 'Monastir',
          rating: 4.0,
          imageAsset: 'assets/images/restaurants/chraka.jpg',
          menu: [
            MenuItem(name: 'Couscous', price: 12.0),
            MenuItem(name: 'Brick à l\'Oeuf', price: 6.0),
            MenuItem(name: 'Lablabi', price: 8.0),
          ],
        ),
      ];
    } else {
      return [];
    }
  }
}

class Restaurant {
  final String name;
  final String location;
  final double rating;
  final String imageAsset;
  final List<MenuItem> menu;

  Restaurant({
    required this.name,
    required this.location,
    required this.rating,
    required this.imageAsset,
    required this.menu,
  });
}

class MenuItem {
  final String name;
  final double price;

  MenuItem({required this.name, required this.price});
}

class RestaurantListTile extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantListTile({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              restaurant.imageAsset,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    restaurant.location,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.amber[600],
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        restaurant.rating.toString(),
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => OrderModal(restaurant: restaurant),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
    );
  }
}

class OrderModal extends StatefulWidget {
  final Restaurant restaurant;

  const OrderModal({Key? key, required this.restaurant}) : super(key: key);

  @override
  _OrderModalState createState() => _OrderModalState();
}

class _OrderModalState extends State<OrderModal> {
  final Map<MenuItem, int> _selectedItems = {};
  final Map<MenuItem, TextEditingController> _itemControllers = {};
  String _location = '';
  double _totalPrice = 0;

  @override
  void dispose() {
    for (TextEditingController controller in _itemControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Order from ${widget.restaurant.name}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Location',
            ),
            onChanged: (value) {
              setState(() {
                _location = value;
              });
            },
          ),
          const SizedBox(height: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Menu',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              DropdownButtonFormField<MenuItem>(
                decoration: const InputDecoration(
                  labelText: 'Select Food',
                ),
                items: widget.restaurant.menu
                    .map((item) => DropdownMenuItem<MenuItem>(
                          value: item,
                          child: Text(item.name),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value != null && !_selectedItems.containsKey(value)) {
                      _selectedItems[value] = 1;
                    }
                    _calculateTotalPrice();
                  });
                },
              ),
              const SizedBox(height: 8.0),
              ..._selectedItems.entries.map((entry) {
                _itemControllers.putIfAbsent(entry.key,
                    () => TextEditingController(text: entry.value.toString()));
                return Row(
                  children: [
                    Text(entry.key.name),
                    const SizedBox(width: 8.0),
                    SizedBox(
                      width: 50.0,
                      child: TextField(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        keyboardType: TextInputType.number,
                        controller: _itemControllers[entry.key],
                        onChanged: (value) {
                          setState(() {
                            _selectedItems[entry.key] =
                                value.isNotEmpty ? int.parse(value) : 0;
                            _calculateTotalPrice();
                          });
                        },
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
          const SizedBox(height: 16.0),
          Text(
            'Total Price: \$${_totalPrice.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _location.isNotEmpty && _selectedItems.isNotEmpty
              ? _submitOrder
              : null,
          child: const Text('Order'),
        ),
      ],
    );
  }

  void _calculateTotalPrice() {
    _totalPrice = 0;
    for (var entry in _selectedItems.entries) {
      _totalPrice += entry.key.price * entry.value;
    }
  }

  void _submitOrder() async {
    if (_location.isNotEmpty && _selectedItems.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? userId = prefs.getInt('userId');

      if (userId != null) {
        final order = {
          'user_id': userId,
          'restaurant_name': widget.restaurant.name,
          'location': _location,
          'order_details': _selectedItems.entries
              .map((entry) => '${entry.value} x ${entry.key.name}')
              .join(', '),
          'total_price': _totalPrice,
        };

        final id = await DatabaseHelper.instance.insertOrder(order);
        print('Order inserted with ID: $id');

        if (mounted) {
          final restaurantOrdersPage =
              context.findAncestorWidgetOfExactType<RestaurantOrdersPage>();
          if (restaurantOrdersPage != null) {
            restaurantOrdersPage.refreshRestaurantOrders();
          }
        }

        Navigator.pop(context);
      } else {
        print('User not logged in');
      }
    }
  }
}
