import 'package:flutter/material.dart';
import 'package:homepage/network_service.dart';
import 'product_profile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'bottom_nav.dart';
import 'saved_items.dart';
import 'inbox.dart';
import 'notification.dart';
import 'login_screen.dart';
import 'package:homepage/user_profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SamaShop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/inbox': (context) => InboxScreen(),
        '/profile': (context) => UserProfile(profileImageUrl: 'vinz.jpg'),
        '/notification': (context) => NotificationPage(),
      },
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = false;

    return isLoggedIn ? HomePage() : LoginScreen();
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedItemsPage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('Vinz Jude'),
              accountEmail: Text('Vinz@email.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/userpic.jpg'),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            const ListTile(
              title: Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text(
                'Men\'s Fashion',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
            ListTile(
              title: const Text(
                'Women\'s Clothing',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                List<String> categories = [
                  'Men\'s Fashion',
                  'Women\'s Clothing',
                  'Kids\' Clothing',
                  'Shoes',
                  'Accessories'
                ];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(categories[index]),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Featured Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Product>>(
              future: NetworkService.fetchProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No products found'));
                } else {
                  final products = snapshot.data!;
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        productName: products[index].name,
                        detailText: products[index].detailText,
                        productPrice: products[index].price.toString(),
                        sellerName: products[index].sellerName,
                        starRating: products[index].starRating,
                        productDescription: products[index].description,
                        imagePaths: products[index].imagePaths,
                        specificImage: products[index].imagePaths[0],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final String detailText;
  final String productPrice;
  final String sellerName;
  final double starRating;
  final String productDescription;
  final List<String> imagePaths;
  final String specificImage;

  ProductCard({
    required this.productName,
    required this.detailText,
    required this.productPrice,
    required this.sellerName,
    required this.starRating,
    required this.productDescription,
    required this.imagePaths,
    required this.specificImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: imagePaths.map((imagePath) {
              return Container(
                margin: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 150.0,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              productName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              detailText,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '\₱$productPrice',
              style: const TextStyle(fontSize: 16, color: Colors.green),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductProfilePage(
                      productName: productName,
                      detailText: detailText,
                      productPrice: productPrice,
                      sellerName: sellerName,
                      starRating: starRating,
                      productDescription: productDescription,
                      imagePaths: imagePaths,
                      specificImage: specificImage,
                    ),
                  ),
                );
              },
              child: const Text('View Details'),
            ),
          ),
        ],
      ),
    );
  }
}
