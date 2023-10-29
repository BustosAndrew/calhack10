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
        appBar: AppBar(title: Text('Chat')),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final chatHistory = snapshot.data!['chatHistory'] ?? [];

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: chatHistory.length,
                      itemBuilder: (context, index) {
                        final message = chatHistory[index];
                        final messageText = message['content'];
                        final isFunction = message['function_call'] != null;
                        final messageType = message['role'];

                        if (isFunction ||
                            messageType == "system" ||
                            messageType == "function") {
                          return SizedBox.shrink();
                        }

                        final isUser = messageType == 'user';

                        return Align(
                          alignment: isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 10.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color:
                                  isUser ? Colors.blue[400] : Colors.grey[300],
                              borderRadius: isUser
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    )
                                  : BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                            ),
                            child: Text(
                              messageText,
                              style: TextStyle(
                                color: isUser ? Colors.white : Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
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
        Uri.parse('https://chat-4tin4bdxkq-uc.a.run.app/chat'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: '{"msg": "${_controller.text}", "uid": "$userId"}',
      );
      print(response.body);

      if (response.statusCode == 200) {
        final aiResponse = response.body;

        // Reference to the user's document
        final userDocRef =
            FirebaseFirestore.instance.collection('users').doc(userId);

        // Fetch the current chatHistory
        DocumentSnapshot userDocSnapshot = await userDocRef.get();
        List<dynamic> chatHistory = userDocSnapshot['chatHistory'] ?? [];

        // Append the user's message
        chatHistory.add({
          'content': _controller.text,
          'role': 'user',
        });

        // Append the function's response (AI's message)
        chatHistory.add({
          'content': aiResponse,
          'role': 'assistant',
        });

        // Update the chatHistory field
        await userDocRef.update({'chatHistory': chatHistory});

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
