import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce Homepage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopify Rebellion'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Handle cart button press
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Shopify Rebellion',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Menu Item 1'),
              onTap: () {
                // Handle menu item 1 press
              },
            ),
            ListTile(
              title: Text('Menu Item 2'),
              onTap: () {
                // Handle menu item 2 press
              },
            ),
            // Add more menu items as needed
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/logo.png', // Replace with the actual path to your logo image
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Featured Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Replace with the actual number of products
              itemBuilder: (context, index) {
                List<String> productNames = [
                  'Nike Air Max 97',
                  'Air Jordan 1 Low "Travis Scott x Fragment"',
                  'Anita Max Wynn Drake Embroidered Trucker Hat',
                  'Fear of God FOG Essentials stretch limo black Pullover Hoodie',
                  'BAPE × Kaws T-shirt'
                ]; // Add more product names if needed

                List<String> detailTexts = [
                  'Size 10 | Men\'s Shoe',
                  'Size 11 | Men\'s Shoe',
                  'ANITA MAX WYNN - Drake A 100% polyester front and 100% nylon mesh',
                  'Men\'s  | Size XL | Unused',
                  'Men\s | Size S | Used'
                ]; // Add your small detail texts here

                List<int> prices = [
                  5999,
                  7999,
                  1299,
                  9506,
                  5500,
                ]; // Add your prices here

                return ProductCard(
                  productName: '${productNames[index]}',
                  detailText: '${detailTexts[index]}', // Use different detail text for each product
                  productPrice: '${prices[index]}', // Use different prices for each product
                  imagePath: 'assets/nike${index + 1}.png', // Replace with the actual path to your product images
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String detailText;
  final String productPrice;
  final String imagePath;

  ProductCard({
    required this.productName,
    required this.detailText,
    required this.productPrice,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              productName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              detailText,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '\$$productPrice',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle product details or add to cart action
              },
              child: Text('View Details'),
            ),
          ),
        ],
      ),
    );
  }
}
