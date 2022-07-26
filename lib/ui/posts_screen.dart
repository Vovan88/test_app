import 'package:flutter/material.dart';
import 'package:flutter_test_application/models/post.dart';

import '../widgets/post_card.dart';

class AllPostScreen extends StatefulWidget {
  final List<Post> listPost;

  const AllPostScreen({
    Key? key,
    required this.listPost,
  }) : super(key: key);

  @override
  AllPostScreenState createState() => AllPostScreenState();
}

class AllPostScreenState extends State<AllPostScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.listPost.length,
          itemBuilder: (BuildContext context, int index) {
            return PostCardWidget(
              postCard: widget.listPost[index],
            );
          }),
    );
  }
}
