import 'package:flutter/material.dart';
import 'message.dart'; 
class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  List<Message> messages = [
    Message('Vince', 'assets/vinz.jpg'), 
    Message('Franklin', 'https://via.placeholder.com/150'),
    Message('Roed', 'https://via.placeholder.com/150'),
    ...List.generate(8, (index) {
      return Message('Sender ${index + 1}', 'https://via.placeholder.com/150');
    })
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(messages[index].imageUrl), 
            ),
            title: Text(messages[index].senderName),
            onTap: () {
              switch (messages[index].senderName) {
                case 'Vince':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageScreen(messages[index]),
                    ),
                  );
                  break;
                case 'Franklin':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageScreen(messages[index]),
                    ),
                  );
                  break;
                  case 'Roed':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageScreen(messages[index]),
                    ),
                  );
                  break;
                default:
                  _editMessage(index);
              }
            },
          );
        },
      ),
    );
  }

  void _editMessage(int index) {
  }
}

class Message {
  final String senderName;
  final String imageUrl;

  Message(this.senderName, this.imageUrl);
}
