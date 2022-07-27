import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_test_application/models/albums.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/bloc.dart';

class AlbumCardDetailWidget extends StatefulWidget {
  final Albums albumCard;

  const AlbumCardDetailWidget({
    Key? key,
    required this.albumCard,
  }) : super(key: key);

  @override
  AlbumCardDetailWidgetState createState() => AlbumCardDetailWidgetState();
}

class AlbumCardDetailWidgetState extends State<AlbumCardDetailWidget> {
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
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${widget.albumCard.title} ",
              ),
              const Spacer(flex: 1),
              Expanded(
                flex: 6,
                child: FutureBuilder(
                  future: getAllbumsPhotos(widget.albumCard.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

                    if (snapshot.hasData) {
                      List<AlbumsPreview> albumsPreview =
                          snapshot.data as List<AlbumsPreview>;

                      return CarouselSlider(
                        options: CarouselOptions(),
                        items: albumsPreview
                            .map((item) => Container(
                                  color: Colors.blue[300],
                                  child: Center(
                                      child: CachedNetworkImage(
                                    cacheKey: item.thumbnailUrl,
                                    imageUrl: item.thumbnailUrl,
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
                                  )),
                                ))
                            .toList(),
                      );
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
