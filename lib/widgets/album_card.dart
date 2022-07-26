import 'package:flutter/material.dart';

import 'package:flutter_test_application/models/albums.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/bloc.dart';

class AlbumCardWidget extends StatefulWidget {
  final Albums albumCard;

  const AlbumCardWidget({
    Key? key,
    required this.albumCard,
  }) : super(key: key);

  @override
  AlbumCardWidgetState createState() => AlbumCardWidgetState();
}

class AlbumCardWidgetState extends State<AlbumCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        color: Colors.blue,
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.albumCard.title} ",
              ),
              const Spacer(flex: 1),
              Flexible(
                flex: 2,
                child: FutureBuilder(
                  future: getAllbumsPhotos(widget.albumCard.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

                    if (snapshot.hasData) {
                      List<AlbumsPreview> albumsPreview =
                          snapshot.data as List<AlbumsPreview>;

                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: albumsPreview.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CachedNetworkImage(
                              cacheKey: albumsPreview[index].thumbnailUrl,
                              imageUrl: albumsPreview[index].thumbnailUrl,
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                );
                              },
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) {
                                // ignore: prefer_const_constructors
                                return CircularProgressIndicator();
                              },
                            );
                          });
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
