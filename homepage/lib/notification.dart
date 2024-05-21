import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notificationList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.notifications),
            title: Text(notificationList[index].title),
            subtitle: Text(notificationList[index].message),
            onTap: () {
              
            },
          );
        },
      ),
    );
  }
}

class Notification {
  final String title;
  final String message;

  Notification({
    required this.title,
    required this.message,
  });
}

List<Notification> notificationList = [
  Notification(
    title: 'New Offer',
    message: 'Michael Jordan sent you a offer of ₱4999 for your Nike Air Max 97',
  ),
  Notification(
    title: 'Order Shipped',
    message: 'Your order #456971 has been shipped.',
  ),
  Notification(
    title: 'Meet-up Schedule',
    message: 'Your order #918414 is been scheduled.',
  ),
  Notification(
    title: 'Price Drop Alert',
    message: 'Price dropped for the item in your wishlist.',
  ),
  
];
