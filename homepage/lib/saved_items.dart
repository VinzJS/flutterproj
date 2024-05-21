import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedItems {
  static const String _key = 'saved_items';


  static Future<void> addItem(String itemName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedItems = prefs.getStringList(_key) ?? [];
    
    if (!savedItems.contains(itemName)) {
      savedItems.add(itemName);
      await prefs.setStringList(_key, savedItems);
    }
  }


  static Future<void> removeItem(String itemName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedItems = prefs.getStringList(_key) ?? [];
    savedItems.remove(itemName);
    await prefs.setStringList(_key, savedItems);
  }


  static Future<List<String>> getSavedItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }
}

class SavedItemsPage extends StatefulWidget {
  @override
  _SavedItemsPageState createState() => _SavedItemsPageState();
}

class _SavedItemsPageState extends State<SavedItemsPage> {
  List<String> savedItems = [];

  @override
  void initState() {
    super.initState();
    _loadSavedItems();
  }

  Future<void> _loadSavedItems() async {
    List<String> items = await SavedItems.getSavedItems();
    setState(() {
      savedItems = items;
    });
  }

  Future<void> _removeItem(String itemName) async {
    await SavedItems.removeItem(itemName);
    _loadSavedItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Items'),
      ),
      body: savedItems.isEmpty
          ? const Center(
              child: Text(
                'No saved items',
                style: TextStyle(fontSize: 24),
              ),
            )
          : ListView.builder(
              itemCount: savedItems.length,
              itemBuilder: (context, index) {
                String productName = savedItems[index];
                String productImage = 'assets/nike1_1.png';
                String productPrice = '\₱5999'; 
                return ListTile(
                  leading: Image.asset(productImage),
                  title: Text(productName),
                  subtitle: Text(productPrice),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      _removeItem(productName);
                    },
                  ),
                  onTap: () {

                  },
                );
              },
            ),
    );
  }
}
