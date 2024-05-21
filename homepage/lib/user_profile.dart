import 'package:flutter/material.dart';
import 'open_street_map_screen.dart'; // Import the OpenStreetMapScreen
import 'saved_items.dart';
import 'user_listings.dart'; // Import the SavedItemsScreen
import 'sell_page.dart'; // Import the SellPage
import 'login_screen.dart'; // Import the LoginScreen for logout

class UserProfile extends StatelessWidget {
  final String profileImageUrl;

  UserProfile({
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SellPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 16.0),
              child: TextButton(
                onPressed: null,
                style: ButtonStyle(
                  side: MaterialStateProperty.all(const BorderSide(color: Colors.orange)),
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                ),
                child: const Text(
                  'Sell',
                  style: TextStyle(
                    color: Colors.white, // White text color
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/vinz.jpg'),
                  radius: 50,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      'Vinz Jude',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow[600],
                        ),
                        Text(
                          '4.8',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        Text(
                          'Verified',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OpenStreetMapScreen()),
                );
              },
              child: const Text('Insert Location'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildSquareTile(Icons.favorite, 'Favorites', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SavedItemsPage()),
                    );
                  }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildSquareTile(Icons.shopping_cart, 'Listings', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserListingsScreen()),
                    );
                  }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildSquareTile(Icons.credit_card, 'Payment', () {
                    // Add your payment page navigation logic here
                  }),
                ),
              ],
            ),
            Spacer(), // Add a spacer to push the logout button to the bottom
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle logout logic, for now navigating back to login screen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Red background color for logout button
                ),
                child: const Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareTile(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.grey[800],
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
