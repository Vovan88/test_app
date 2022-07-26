import 'package:flutter/material.dart';

import '../models/post.dart';

class PostCardWidget extends StatelessWidget {
  final Post postCard;

  const PostCardWidget({
    Key? key,
    required this.postCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        color: Colors.blue,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
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
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
