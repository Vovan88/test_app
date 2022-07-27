import 'package:flutter/material.dart';
import 'package:flutter_test_application/models/albums.dart';

import '../widgets/album_card.dart';
import '../widgets/album_card_detail.dart';

class AllAlbumsScreen extends StatefulWidget {
  final List<Albums> listAlbum;

  const AllAlbumsScreen({
    Key? key,
    required this.listAlbum,
  }) : super(key: key);

  @override
  AllPostScreenState createState() => AllPostScreenState();
}

class AllPostScreenState extends State<AllAlbumsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: widget.listAlbum.length,
          itemBuilder: (BuildContext context, int index) {
            return AlbumCardDetailWidget(
              albumCard: widget.listAlbum[index],
            );
          }),
    );
  }
}
