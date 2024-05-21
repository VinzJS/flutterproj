import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'user_profile.dart'; // Import the UserProfile screen

class OpenStreetMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Maps'),
        ),
      ),
      body: OpenStreetMapSearchAndPick(
        center: LatLong(10.639356577250915, 122.92844403946303),
        buttonColor: Colors.blue,
        buttonText: 'Set Current Location',
        onPicked: (pickedData) {
          print('Location picked!'); 
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserProfile(profileImageUrl: '',)),
          );
        },
      ),
    );
  }
}
