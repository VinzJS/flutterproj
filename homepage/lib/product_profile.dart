import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:homepage/inbox.dart';
import 'package:homepage/saved_items.dart'; 
import 'message.dart';
import 'user_listings.dart'; 

class ProductProfilePage extends StatefulWidget {
  final String productName;
  final String detailText;
  final String productPrice;
  final String sellerName;
  final double starRating;
  final String productDescription; 
  final List<String> imagePaths;
  final String specificImage;

  ProductProfilePage({
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
  _ProductProfilePageState createState() => _ProductProfilePageState();
}

class _ProductProfilePageState extends State<ProductProfilePage> {
  bool isSaved = false;
  double currentPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _checkSaved();
    currentPrice = double.parse(widget.productPrice);
  }

  void _checkSaved() async {
    List<String> savedItems = await SavedItems.getSavedItems();
    setState(() {
      isSaved = savedItems.contains(widget.productName);
    });
  }

  void _toggleSaved() {
    setState(() {
      isSaved = !isSaved;
    });

    if (isSaved) {
      SavedItems.addItem(widget.productName); 
    } else {
      SavedItems.removeItem(widget.productName); 
    }
  }

void _showMakeOfferDialog() {
  double offerPrice = currentPrice;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Make an Offer',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Current Price: ₱${currentPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (offerPrice > 0.0) {
                            offerPrice -= 100.0;
                          }
                        });
                      },
                    ),
                    Text(
                      '₱${offerPrice.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          offerPrice += 100.0;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    String offerMessage = 'User offered ₱${offerPrice.toStringAsFixed(2)}!';
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessageScreen(
                          Message(widget.sellerName, offerMessage),
                        ),
                      ),
                    );
                  },
                  child: const Text('Make Offer'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: widget.imagePaths.map((imagePath) {
                return Container(
                  margin: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: 1000.0,
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 250.0,
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.productName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
                        onPressed: _toggleSaved,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.detailText,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\₱${widget.productPrice}',
                        style: const TextStyle(fontSize: 20, color: Colors.green),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        'Seller: ${widget.sellerName}',
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 20, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.starRating}',
                            style: const TextStyle(fontSize: 16, color: Colors.amber),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ExpansionTile(
                    title: const Text(
                      'Description',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          widget.productDescription,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.chat),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.monetization_on), 
              onPressed: _showMakeOfferDialog,
            ),
          ],
        ),
      ),
    );
  }
}
