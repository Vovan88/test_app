import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test_application/models/albums.dart';
import 'package:flutter_test_application/models/comment.dart';
import 'package:flutter_test_application/models/post.dart';
import 'package:flutter_test_application/models/user.dart';
import 'package:http/http.dart' as http;

final StreamController<List<User>> _streamControllerUsers =
    StreamController<List<User>>.broadcast();

Stream<List<User>> get streamUsers => _streamControllerUsers.stream;
StreamSink get _addValueUsers => _streamControllerUsers.sink;

final StreamController<List<Post>> _streamControllerPosts =
    StreamController<List<Post>>.broadcast();

Stream<List<Post>> get streamPosts => _streamControllerPosts.stream;
StreamSink get _addValuePosts => _streamControllerPosts.sink;

final StreamController<List<Albums>> _streamControllerAllbums =
    StreamController<List<Albums>>.broadcast();

Stream<List<Albums>> get streamAlbums => _streamControllerAllbums.stream;
StreamSink get _addValueAlbums => _streamControllerAllbums.sink;

final StreamController<List<Comment>> _streamControllerComments =
    StreamController<List<Comment>>.broadcast();

Stream<List<Comment>> get streamComments => _streamControllerComments.stream;
StreamSink get _addValueComments => _streamControllerComments.sink;

Future<void> getUsers() async {
  try {
    http.Response response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      String data = response.body;
      Iterable lUsers = jsonDecode(data);

      List<User> users =
          List<User>.from(lUsers.map((data) => User.fromJson(data)));

      _addValueUsers.add(users);
    }
  } on SocketException catch (_) {
    _addValueUsers.addError("No internet");
  }
}

Future<void> getPosts(userId) async {
  try {
    http.Response response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/posts/?userId=$userId"));

    if (response.statusCode == 200) {
      String data = response.body;
      Iterable lPosts = jsonDecode(data);

      List<Post> posts =
          List<Post>.from(lPosts.map((data) => Post.fromJson(data)));

      _addValuePosts.add(posts);
    }
  } on SocketException catch (_) {
    _addValuePosts.addError("No internet");
  }
}

Future<void> getAllbums(userId) async {
  try {
    http.Response response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/albums/?userId=$userId"));

    if (response.statusCode == 200) {
      String data = response.body;
      Iterable lalbums = jsonDecode(data);

      List<Albums> albums =
          List<Albums>.from(lalbums.map((data) => Albums.fromJson(data)));

      _addValueAlbums.add(albums);
    }
  } on SocketException catch (_) {
    _addValueAlbums.addError("No internet");
  }
}

Future<List<AlbumsPreview>> getAllbumsPhotos(albumId) async {
  try {
    http.Response response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/photos/?albumId=$albumId"));

    if (response.statusCode == 200) {
      String data = response.body;
      Iterable lAlbums = jsonDecode(data);

      return List<AlbumsPreview>.from(
          lAlbums.map((data) => AlbumsPreview.fromJson(data)));
    }

    return Future.error("No internet");
  } on SocketException catch (_) {
    return Future.error("No internet");
  }
}

Future<List<Comment>> getComments(postId) async {
  try {
    http.Response response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/comments/?postId=$postId"));

    if (response.statusCode == 200) {
      String data = response.body;
      Iterable lcomments = jsonDecode(data);

      List<Comment> comments =
          List<Comment>.from(lcomments.map((data) => Comment.fromJson(data)));

      _addValueComments.add(comments);
    }

    return Future.error("No internet");
  } on SocketException catch (_) {
    return Future.error("No internet");
  }
}
