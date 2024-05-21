import 'package:flutter/material.dart';
import 'package:homepage/main.dart';
import 'product_profile.dart'; 

class UserListingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<Map<String, dynamic>> userListings = [
      {
        'productName': 'Air Jordan 1 Low "Travis Scott"',
        'detailText': 'Size 11 | Men\'s Shoe',
        'productPrice': '7999',
        'sellerName': 'Vinz Jude',
        'starRating': 4.8,
        'productDescription': '2',
        'imagePaths': [
          'assets/nike2_1.png',
          'assets/nike2_2.png',
          'assets/nike2_3.png',
          'assets/nike2_4.png',
        ],
        'specificImage': 'assets/nike2_1.png',
      },

    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Listings'),
      ),
      body: ListView.builder(
        itemCount: userListings.length,
        itemBuilder: (context, index) {
          final listing = userListings[index];
          return ProductCard(
            productName: listing['productName'],
            detailText: listing['detailText'],
            productPrice: listing['productPrice'],
            sellerName: listing['sellerName'],
            starRating: listing['starRating'],
            productDescription: listing['productDescription'],
            imagePaths: listing['imagePaths'],
            specificImage: listing['specificImage'],
          );
        },
      ),
    );
  }
}
