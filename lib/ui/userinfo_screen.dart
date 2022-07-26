import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_application/bloc/bloc.dart';
import 'package:flutter_test_application/models/albums.dart';
import 'package:flutter_test_application/models/post.dart';
import 'package:flutter_test_application/models/user.dart';
import 'package:flutter_test_application/ui/albums_screen.dart';
import 'package:flutter_test_application/ui/posts_screen.dart';
import 'package:flutter_test_application/widgets/album_card.dart';

import '../widgets/post_card.dart';
import '../widgets/user_card_detail.dart';

class UserInfoScreen extends StatefulWidget {
  final User userCard;

  const UserInfoScreen(
    this.userCard, {
    Key? key,
  }) : super(key: key);

  @override
  UserInfoScreenState createState() => UserInfoScreenState();
}

class UserInfoScreenState extends State<UserInfoScreen> {
  @override
  void initState() {
    getAllbums(widget.userCard.id);
    getPosts(widget.userCard.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Post> allposts = List.empty();
    List<Albums> allAlbums = List.empty();
    return Scaffold(
      appBar: AppBar(title: Text(widget.userCard.username)),
      body: Stack(children: [
        Column(
          children: [
            UserCardDetailWidget(userCard: widget.userCard),
            Flexible(
              child: StreamBuilder<List<Albums>>(
                  stream: streamAlbums,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Albums>> snapshot) {
                    if (snapshot.hasError) {
                      Text(snapshot.error.toString());
                    }

                    if (snapshot.hasData) {
                      allAlbums = snapshot.data as List<Albums>;
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return AlbumCardWidget(
                              albumCard: snapshot.data![index],
                            );
                          });
                    }

                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.amber,
                        color: Colors.yellow,
                      ),
                    );
                  }),
            ),
            Flexible(
              child: StreamBuilder<List<Post>>(
                  stream: streamPosts,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Post>> snapshot) {
                    if (snapshot.hasError) {
                      Text(snapshot.error.toString());
                    }

                    if (snapshot.hasData) {
                      allposts = snapshot.data!;

                      return ListView.builder(
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return PostCardWidget(
                              postCard: snapshot.data![index],
                            );
                          });
                    }

                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.amber,
                        color: Colors.yellow,
                      ),
                    );
                  }),
            ),
          ],
        ),
        Positioned(
            right: 10,
            bottom: 10,
            child: Row(
              children: [
                Container(
                    color: Colors.blueGrey,
                    child: TextButton(
                        onPressed: () {
                          if (allposts.isNotEmpty) {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) {
                                return AllPostScreen(
                                  listPost: allposts,
                                );
                              }),
                            );
                          }
                        },
                        child: const Text(
                          "All posts",
                          style: TextStyle(color: Colors.white),
                        ))),
                const SizedBox(
                  width: 10,
                ),
                Container(
                    color: Colors.blueGrey,
                    child: TextButton(
                        onPressed: () {
                          if (allAlbums.isNotEmpty) {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context) {
                                return AllAlbumsScreen(
                                  listAlbum: allAlbums,
                                );
                              }),
                            );
                          }
                        },
                        child: const Text(
                          "All albums",
                          style: TextStyle(color: Colors.white),
                        )))
              ],
            )),
      ]),
    );
  }
}
