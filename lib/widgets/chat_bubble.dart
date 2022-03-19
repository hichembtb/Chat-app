import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class ChatBubbleReciver extends StatelessWidget {
  final Message message;

  const ChatBubbleReciver({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(13),
        decoration: const BoxDecoration(
          color: Color.fromARGB(220, 38, 53, 139),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(message.message),
      ),
    );
  }
}

class ChatBubbleSender extends StatelessWidget {
  final Message message;

  const ChatBubbleSender({Key? key, required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(13),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 1, 5, 34),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(message.message),
      ),
    );
  }
}
