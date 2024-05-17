import 'package:flutter/material.dart';

class HotelRegionPage extends StatelessWidget {
  const HotelRegionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Region'),
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/hotel_header.jpeg',
            width: MediaQuery.of(context).size.width * 0.96,

            fit: BoxFit
                .cover,  
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,  
                childAspectRatio:
                    0.75,  
                mainAxisSpacing: 8.0,  
                crossAxisSpacing: 8.0,  
                children: [
                  _buildRegionButton(context, 'Sahel', Colors.pink),
                  _buildRegionButton(context, 'South', Colors.orange),
                  _buildRegionButton(context, 'North', Colors.green),
                  _buildRegionButton(context, 'interior', Colors.blue),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionButton(BuildContext context, String region, Color color) {
    return GestureDetector(
      onTap: () {
         Navigator.pushNamed(context, '/hotels', arguments: region);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            region,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
