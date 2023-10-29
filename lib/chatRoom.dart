import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? userId;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      userId = user.uid;
    } else {
      // Handle scenario where no user is signed in.
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Add ')),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('messages')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text(
                          "hi"); //Center(child: CircularProgressIndicator());
                    }
                    final messages = snapshot.data!.docs;
                    List<Widget> messageWidgets = [];
                    for (var message in messages) {
                      final messageText = message['text'];
                      final messageSender = message['sender'];
                      final messageType = message['type'];

                      final isUser = messageType == 'sent';

                      final messageWidget = ListTile(
                          leading: isUser ? null : Icon(Icons.computer),
                          title: Text(isUser
                              ? "You: $messageText"
                              : "$messageSender: $messageText"));

                      messageWidgets.add(messageWidget);
                    }
                    return ListView(
                      controller: _scrollController,
                      children: messageWidgets,
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Enter your message...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      _sendMessage();
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      // Call the function
      final response = await http.post(
        Uri.parse('https://chat-4tin4bdxkq-uc.a.run.app/'),
        body: {'message': _controller.text},
      );

      if (response.statusCode == 200) {
        // Process the function's response if needed
        print("Function responded with: ${response.body}");

        // Reference to the user's chatHistory subcollection
        final userChatHistoryRef = FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('chatHistory');

        // Store the user's message
        await userChatHistoryRef.add({
          'text': _controller.text,
          'sender': 'user',
          'type': 'sent',
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Store the function's response (AI's message)
        await userChatHistoryRef.add({
          'text': response.body,
          'sender': 'AI',
          'type': 'received',
          'timestamp': FieldValue.serverTimestamp(),
        });

        _controller.clear();

        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        print("Failed to call the function: ${response.statusCode}");
      }
    }
  }
}
