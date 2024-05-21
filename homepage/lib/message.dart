import 'package:flutter/material.dart';
import 'package:homepage/inbox.dart';
import 'package:web_socket_channel/io.dart';

class MessageScreen extends StatefulWidget {
  final Message message;

  MessageScreen(this.message);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late IOWebSocketChannel _channel;
  List<String> _messages = [];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
    _channel.stream.listen((dynamic message) {
      setState(() {
        _messages.add(message.toString());
      });
    });
  }

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  @override
  void dispose() {
    _channel.sink.close();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.message.senderName),
            IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () {

              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.message.imageUrl),
                  radius: 50,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.message.senderName,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                bool isUserMessage = _messages[index].startsWith('Vince');
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      isUserMessage
                          ? Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      _messages[index],
                                      style: const TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(widget.message.imageUrl),
                                    radius: 20,
                                  ),
                                ],
                              ),
                            )
                          : Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(widget.message.imageUrl),
                                    radius: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      _messages[index],
                                      style: const TextStyle(fontSize: 16, color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      labelText: 'Enter message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (String value) {
                      sendMessage(value);
                      _textEditingController.clear();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    sendMessage(_textEditingController.text);
                    _textEditingController.clear();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
