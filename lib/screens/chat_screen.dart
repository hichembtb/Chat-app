import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static String route = "chat";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  // TextField Controller
  TextEditingController controller = TextEditingController();
  final Stream<QuerySnapshot> messagesStream =
      FirebaseFirestore.instance.collection(kMessagesCollections).snapshots();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreationDate, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(
              Message.fromJson(
                snapshot.data!.docs[i],
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 35,
              centerTitle: true,
              leading: null,
              actions: [
                IconButton(
                  onPressed: () {
                    //Implement logout functionality
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
              ],
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: const Color.fromARGB(255, 11, 31, 75),
                    child: Image.asset(
                      "images/logo.png",
                      fit: BoxFit.fill,
                      color: const Color.fromARGB(255, 7, 62, 124),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text("Chat")
                ],
              ),
              backgroundColor: const Color.fromARGB(220, 10, 19, 71),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBubbleReciver(message: messagesList[index])
                          : ChatBubbleSender(message: messagesList[index]);
                      // return ChatBubbleReciver(
                      //   message: messagesList[index],
                      // );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.black),
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        messages.add({
                          kMessage: value,
                          kCreationDate: DateTime.now(),
                          "id": email,
                        });
                        controller.clear();
                        _controller.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn,
                        );
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Send Message",
                      suffixIcon: const Icon(Icons.send),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
