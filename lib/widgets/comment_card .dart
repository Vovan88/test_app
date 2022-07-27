import 'package:flutter/material.dart';
import 'package:flutter_test_application/models/comment.dart';

class CommentCardWidget extends StatelessWidget {
  final Comment commentCard;

  const CommentCardWidget({Key? key, required this.commentCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        color: Colors.amber,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 1),
              Text("Name: ${commentCard.name}"),
              Text("email: ${commentCard.email}"),
              const Spacer(flex: 1),
              Text("${commentCard.body} "),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
