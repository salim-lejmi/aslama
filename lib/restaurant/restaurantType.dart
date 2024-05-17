import 'package:flutter/material.dart';

class RestaurantTypePage extends StatelessWidget {
  const RestaurantTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select type of restaurant'),
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/hotel_header.jpeg',
            width: MediaQuery.of(context).size.width * 0.96,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: [
                  _buildTypeButton(
                      context, 'Modern', Colors.pink, Icons.lightbulb_outline),
                  _buildTypeButton(
                      context, 'Traditional', Colors.orange, Icons.castle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton(
      BuildContext context, String type, Color color, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/restaurant', arguments: type);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 48.0),  
            const SizedBox(
                height: 8.0),  
            Text(
              type,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
