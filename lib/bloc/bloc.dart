import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test_application/models/albums.dart';
import 'package:flutter_test_application/models/comment.dart';
import 'package:flutter_test_application/models/post.dart';
import 'package:flutter_test_application/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

final StreamController<List<User>> _streamControllerUsers =
    BehaviorSubject<List<User>>();

Stream<List<User>> get streamUsers => _streamControllerUsers.stream;
StreamSink get _addValueUsers => _streamControllerUsers.sink;

final StreamController<List<Post>> streamControllerPosts =
    BehaviorSubject<List<Post>>();

Stream<List<Post>> get streamPosts => streamControllerPosts.stream;
StreamSink get _addValuePosts => streamControllerPosts.sink;

final StreamController<List<Albums>> _streamControllerAllbums =
    BehaviorSubject<List<Albums>>();

Stream<List<Albums>> get streamAlbums => _streamControllerAllbums.stream;
StreamSink get _addValueAlbums => _streamControllerAllbums.sink;

final StreamController<List<Comment>> _streamControllerComments =
    BehaviorSubject<List<Comment>>();

Stream<List<Comment>> get streamComments => _streamControllerComments.stream;
StreamSink get _addValueComments => _streamControllerComments.sink;
SharedPreferences? _preferences;
Future<void> getUsers() async {
  try {
    _preferences = await SharedPreferences.getInstance();

    if (_preferences!.containsKey('users')) {
      Iterable lUsers =
          jsonDecode(_preferences!.getStringList("users").toString());
      List<User> users =
          List<User>.from(lUsers.map((data) => User.fromJson(data)));
      _addValueUsers.add(users);
      return;
    }

    http.Response response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      String data = response.body;
      Iterable lUsers = jsonDecode(data);

      List<User> users =
          List<User>.from(lUsers.map((data) => User.fromJson(data)));

      List<String> userList = [];
      for (User element in users) {
        String u = element.toRawJson().toString();

        userList.add(u);
      }

      _preferences!.setStringList("users", userList);

      _addValueUsers.add(users);
    }
  } on SocketException catch (_) {
    _addValueUsers.addError("No internet");
  }
}

Future<void> getPosts(userId) async {
  try {
    if (_preferences!.containsKey('posts$userId')) {
      Iterable lUsers =
          jsonDecode(_preferences!.getStringList("posts$userId").toString());
      List<Post> users =
          List<Post>.from(lUsers.map((data) => Post.fromJson(data)));
      _addValuePosts.add(users);
      return;
    }

    http.Response response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/posts/?userId=$userId"));

    if (response.statusCode == 200) {
      String data = response.body;
      Iterable lPosts = jsonDecode(data);

      List<Post> posts =
          List<Post>.from(lPosts.map((data) => Post.fromJson(data)));

      List<String> userList = [];
      for (Post element in posts) {
        String u = element.toRawJson().toString();

        userList.add(u);
      }

      _preferences!.setStringList("posts$userId", userList);

      _addValuePosts.add(posts);
    }
  } on SocketException catch (_) {
    _addValuePosts.addError("No internet");
  }
}

Future<void> getAllbums(userId) async {
  try {
    if (_preferences!.containsKey('albums$userId')) {
      Iterable lUsers =
          jsonDecode(_preferences!.getStringList("albums$userId").toString());
      List<Albums> users =
          List<Albums>.from(lUsers.map((data) => Albums.fromJson(data)));
      _addValueAlbums.add(users);
      return;
    }

    http.Response response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/albums/?userId=$userId"));

    if (response.statusCode == 200) {
      String data = response.body;
      Iterable lalbums = jsonDecode(data);

      List<Albums> albums =
          List<Albums>.from(lalbums.map((data) => Albums.fromJson(data)));

      List<String> userList = [];
      for (Albums element in albums) {
        String u = element.toRawJson().toString();

        userList.add(u);
      }

      _preferences!.setStringList("albums$userId", userList);

      _addValueAlbums.add(albums);
    }
  } on SocketException catch (_) {
    _addValueAlbums.addError("No internet");
  }
}

Future<List<AlbumsPreview>> getAllbumsPhotos(albumId) async {
  try {
    if (_preferences!.containsKey('albumsPreview$albumId')) {
      Iterable lAlbums = jsonDecode(
          _preferences!.getStringList("albumsPreview$albumId").toString());
      List<AlbumsPreview> albumsPrewievs = List<AlbumsPreview>.from(
          lAlbums.map((data) => AlbumsPreview.fromJson(data)));

      return albumsPrewievs;
    }

    http.Response response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/photos/?albumId=$albumId"));

    if (response.statusCode == 200) {
      String data = response.body;
      Iterable lAlbums = jsonDecode(data);

      List<AlbumsPreview> albumsPreview = List<AlbumsPreview>.from(
          lAlbums.map((data) => AlbumsPreview.fromJson(data)));
      List<String> albumsPreviewList = [];
      for (AlbumsPreview element in albumsPreview) {
        String u = element.toRawJson().toString();

        albumsPreviewList.add(u);
      }

      _preferences!.setStringList("albumsPreview$albumId", albumsPreviewList);

      return albumsPreview;
    }

    return Future.error("No internet");
  } on SocketException catch (_) {
    return Future.error("No internet");
  }
}

Future<void> getComments(postId) async {
  try {
    if (_preferences!.containsKey('comments$postId')) {
      Iterable lComments =
          jsonDecode(_preferences!.getStringList("comments$postId").toString());
      List<Comment> comments =
          List<Comment>.from(lComments.map((data) => Comment.fromJson(data)));
      _addValueComments.add(comments);
      return;
    }

    http.Response response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/comments/?postId=$postId"));

    if (response.statusCode == 200) {
      String data = response.body;
      Iterable lcomments = jsonDecode(data);

      List<Comment> comments =
          List<Comment>.from(lcomments.map((data) => Comment.fromJson(data)));
      List<String> commentsList = [];
      for (Comment element in comments) {
        String u = element.toRawJson().toString();

        commentsList.add(u);
      }

      _preferences!.setStringList("comments$postId", commentsList);
      _addValueComments.add(comments);
    }

    return Future.error("No internet");
  } on SocketException catch (_) {
    return Future.error("No internet");
  }
}

addComment(List<Comment> comments, postId) {
  List<String> commentsList = [];
  for (Comment element in comments) {
    String u = element.toRawJson().toString();

    commentsList.add(u);
  }

  _preferences!.setStringList("comments$postId", commentsList);
  _addValueComments.add(comments);
}
