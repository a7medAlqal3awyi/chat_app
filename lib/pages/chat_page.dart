import 'package:chat/models/message_model.dart';
import 'package:chat/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/colors.dart';

class ChatPage extends StatelessWidget {
  final _scrollController = ScrollController();
  static String id = 'ChatPage';
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email= ModalRoute.of(context)!.settings.arguments;
return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }

            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                automaticallyImplyLeading: false,
                title: Center(
                    child: Text("chat",
                        style: GoogleFonts.acme(
                            fontSize: 25, fontWeight: FontWeight.w500))),
              ),
              body: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/background.image.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        SafeArea(child: SizedBox(height: 20)),
                        Expanded(
                            child: ListView.builder(
                              reverse: true,
                                controller: _scrollController,
                                physics: BouncingScrollPhysics(),
                                itemCount: messagesList.length,
                                itemBuilder: (context,  index) {
                                  return messagesList[index].id == email ?
                                    ChatBubble(
                                              message: messagesList[index])
                                  :ChatBubbleForFreind(
                                      message: messagesList[index])
                                  ;

                                })),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextField(
                            controller: controller,
                            onSubmitted: (data) {
                              messages.add({
                                'messages': data,
                                'createdAt': DateTime.now(),
                                'id':email

                              });
                              controller.clear();
                              _scrollController.animateTo(
                                _scrollController.position.minScrollExtent,
                                curve: Curves.easeOut,
                                duration: const Duration(milliseconds: 500),
                              );
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: ' message',
                              hintStyle: TextStyle(color: Colors.white),
                              suffixIcon: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(25)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(25)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("Loading...."));
          }
        });
  }
}
