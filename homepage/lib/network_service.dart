import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
  static const String url = 'http://vinzj.helioho.st/fetch_products.php'; // Replace with your actual URL

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}

class Product {
  final int id;
  final String name;
  final String detailText;
  final String price; 
  final String sellerName;
  final double starRating;
  final String description;
  final List<String> imagePaths;

  Product({
    required this.id,
    required this.name,
    required this.detailText,
    required this.price,
    required this.sellerName,
    required this.starRating,
    required this.description,
    required this.imagePaths,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<dynamic> imagePathsFromJson = jsonDecode(json['image_paths']);
    double starRating = double.tryParse(json['star_rating']) ?? 0.0;
    return Product(
      id: json['id'],
      name: json['name'],
      detailText: json['detail_text'],
      price: json['price'].toString(),
      sellerName: json['seller_name'],
      starRating: starRating,
      description: json['description'],
      imagePaths: List<String>.from(imagePathsFromJson),
    );
  }
}
