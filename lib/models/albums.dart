import 'dart:convert';

class Albums {
  Albums({
    required this.userId,
    required this.id,
    required this.title,
  });

  int userId;
  int id;
  String title;

  factory Albums.fromRawJson(String str) => Albums.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Albums.fromJson(Map<String, dynamic> json) => Albums(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}

class AlbumsPreview {
  AlbumsPreview({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  factory AlbumsPreview.fromRawJson(String str) =>
      AlbumsPreview.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AlbumsPreview.fromJson(Map<String, dynamic> json) => AlbumsPreview(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };
}
