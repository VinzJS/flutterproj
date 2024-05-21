import 'dart:io'; // Import 'dart:io' for File class
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  String _selectedCategory = 'Select Category';
  bool _isNewSelected = false;
  bool _isUsedSelected = false;
  bool _meetUpSelected = false;
  bool _mailingSelected = false;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  List<File> _imageList = [];

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _imageList.add(File(pickedImage.path));
      });
    }
  }

  Future<void> _submitProduct() async {
    // Convert image paths to a single string separated by commas
    String imagePaths = _imageList.map((file) => file.path).join(',');

    // Gather product details
    String name = _titleController.text;
    String detailText = _selectedCategory;
    double price = double.tryParse(_priceController.text) ?? 0.0;
    String sellerName = "Seller Name"; // This should come from logged-in user info
    double starRating = _isNewSelected ? 5.0 : 3.5; // Example rating based on condition
    String description = _descriptionController.text;

    // Create a JSON object
    Map<String, dynamic> productData = {
      'name': name,
      'detail_text': detailText,
      'price': price,
      'seller_name': sellerName,
      'star_rating': starRating,
      'description': description,
      'image_paths': imagePaths,
    };

    // Make a POST request to the backend
    final response = await http.post(
      Uri.parse('http://vinzj.helioho.st/add_product.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(productData),
    );

    if (response.statusCode == 200) {
      // If the server returns a successful response, show a success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product submitted successfully')));
    } else {
      // If the server did not return a 200 OK response, show an error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to submit product')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sell'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Upload Pictures',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _getImage(ImageSource.camera),
                    child: const Text('Take a Picture'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => _getImage(ImageSource.gallery),
                    child: const Text('Choose from Gallery'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _imageList.isEmpty
                  ? const Text('No images selected.')
                  : SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _imageList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.file(
                              _imageList[index],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
              const SizedBox(height: 24),
              const Text(
                'Category',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: [
                  'Select Category',
                  'Men\'s Fashion',
                  'Women\'s Clothing',
                  'Kids\' Clothing',
                  'Shoes',
                  'Accessories'
                ].map<DropdownMenuItem<String>>(
                  (value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ),
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value ?? 'Select Category';
                  });
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Listing Title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Enter listing title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Condition',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isNewSelected = true;
                        _isUsedSelected = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      primary: _isNewSelected ? Colors.blue : Colors.grey[300],
                    ),
                    child: Text(
                      'Brand New',
                      style: TextStyle(
                        color: _isNewSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isNewSelected = false;
                        _isUsedSelected = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      primary: _isUsedSelected ? Colors.blue : Colors.grey[300],
                    ),
                    child: Text(
                      'Pre-owned',
                      style: TextStyle(
                        color: _isUsedSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Price',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Enter price',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Enter description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Deal Method',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Checkbox(
                    value: _meetUpSelected,
                    onChanged: (value) {
                      setState(() {
                        _meetUpSelected = value ?? false;
                      });
                    },
                  ),
                  const Text('Meet-up'),
                  const SizedBox(width: 20),
                  Checkbox(
                    value: _mailingSelected,
                    onChanged: (value) {
                      setState(() {
                        _mailingSelected = value ?? false;
                      });
                    },
                  ),
                  const Text('Mailing & Delivery'),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitProduct,
                child: const Text('Submit Listing'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
