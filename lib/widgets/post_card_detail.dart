import 'package:flutter/material.dart';

import '../models/post.dart';

class PostCardDetailWidget extends StatelessWidget {
  final Post postCard;
  final Function(Post) onTap;

  const PostCardDetailWidget({
    Key? key,
    required this.postCard,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        color: Colors.blue,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(flex: 1),
                    Text(
                      "${postCard.title} ",
                    ),
                    const Spacer(flex: 1),
                    Text(
                      "${postCard.body} ",
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    onTap(postCard);
                  },
                  child: const Text("Show detail",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
