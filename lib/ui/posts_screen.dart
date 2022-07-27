import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/models/post.dart';
import 'package:flutter_test_application/ui/postdetil_screen.dart';
import 'package:flutter_test_application/widgets/post_card_detail.dart';

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
            return PostCardDetailWidget(
              postCard: widget.listPost[index],
              onTap: (post) {
                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return PostDetailScreen(post);
                }));
              },
            );
          }),
    );
  }
}
