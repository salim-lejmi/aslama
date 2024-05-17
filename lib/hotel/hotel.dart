import 'package:flutter/material.dart';
import 'booking_modal.dart';

class HotelPage extends StatelessWidget {
  final String region;

  const HotelPage({Key? key, required this.region}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Hotel> hotels = getHotelsForRegion(region);

    return Scaffold(
      appBar: AppBar(
        title: Text('Hotels in $region'),
      ),
      body: ListView.builder(
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          return HotelListTile(hotel: hotels[index]);
        },
      ),
    );
  }

  List<Hotel> getHotelsForRegion(String region) {
     if (region == 'Sahel') {
      return [
        Hotel(
          name: 'Hotel Hasdrubal Thalassa & Spa',
          location: 'Sousse',
          rating: 4.5,
          price: 200,
          imageAsset: 'assets/images/hotels/thalasso.jpg',
        ),
        Hotel(
          name: 'Sentido Phenicia',
          location: 'Hammamet',
          rating: 4.2,
          price: 150,
          imageAsset: 'assets/images/hotels/Sentido.jpg',
        ),
        Hotel(
          name: 'Hotel El Mouradi',
          location: 'Mahdia',
          rating: 4.0,
          price: 120,
          imageAsset: 'assets/images/hotels/Mouradi.jpg',
        ),
       ];
    } else if (region == 'South') {
      return [
        Hotel(
          name: 'Hotel El Mouradi Cap Serrat',
          location: 'Bizerte',
          rating: 4.0,
          price: 100,
          imageAsset: 'assets/images/hotels/Mouradi.jpg',
        ),
       ];
    } else if (region == 'North') {
      return [
        Hotel(
          name: 'Hotel El Mouradi ',
          location: 'Bizerte',
          rating: 4.0,
          price: 110,
          imageAsset: 'assets/images/hotels/Mouradi.jpg',
        ),
       ];
    } else if (region == 'interior') {
      return [
        Hotel(
          name: 'Hotel El Mouradi Cap Serrat',
          location: 'Bizerte',
          rating: 4.0,
          price: 95,
          imageAsset: 'assets/images/hotels/Mouradi.jpg',
        ),
       ];
    } else {
      return [];  
    }
  }
}

class Hotel {
  final String name;
  final String location;
  final double rating;
  final int price;  
  final String imageAsset;

  Hotel({
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
    required this.imageAsset,
  });
}

class HotelListTile extends StatelessWidget {
  final Hotel hotel;

  const HotelListTile({Key? key, required this.hotel}) : super(key: key);

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
              hotel.imageAsset,
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
                    hotel.name,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    hotel.location,
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
                        hotel.rating.toString(),
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        '${hotel.price}',
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
                builder: (context) => BookingModal(hotel: hotel),
              );
            },
            icon: const Icon(Icons.book),
          ),
        ],
      ),
    );
  }
}
