import 'package:chat/models/message_model.dart';
import 'package:flutter/material.dart';

import '../constant/colors.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({Key? key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
        padding: EdgeInsets.only(left: 10, top: 30, bottom: 30, right: 10),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
            )),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}


class ChatBubbleForFreind extends StatelessWidget {
  ChatBubbleForFreind({Key? key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
        padding: EdgeInsets.only(left: 10, top: 30, bottom: 30, right: 10),
        decoration: BoxDecoration(
            color: senderColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              topLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            )),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}

// Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Container(
// margin: EdgeInsets.all(16),
// height: 65,
// decoration: BoxDecoration(
// color: senderColor,
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(25),
// topRight: Radius.circular(32),
// bottomLeft: Radius.circular(32),
// )),
// alignment: Alignment.centerRight,
// padding: EdgeInsets.symmetric(horizontal: 12),
// child: Text(
// "hello iam ahmed ",
// style: TextStyle(color: Colors.white),
// ),
// ),
// ],
// ),
