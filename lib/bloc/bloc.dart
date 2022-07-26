import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test_application/models/post.dart';
import 'package:flutter_test_application/models/user.dart';
import 'package:http/http.dart' as http;

final StreamController<List<User>> _streamControllerUsers =
    StreamController<List<User>>.broadcast();

Stream<List<User>> get streamUsers => _streamControllerUsers.stream;
StreamSink get _addValueUser => _streamControllerUsers.sink;

final StreamController<List<Post>> _streamControllerPosts =
    StreamController<List<Post>>.broadcast();

Stream<List<Post>> get streamPosts => _streamControllerPosts.stream;
StreamSink get _addValuePost => _streamControllerPosts.sink;

Future<void> GetUsers() async {
  try {
    http.Response response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      String data = response.body;
      Iterable lUsers = jsonDecode(data);

      List<User> users =
          List<User>.from(lUsers.map((data) => User.fromJson(data)));

      _addValueUser.add(users);
    }
  } on SocketException catch (_) {
    _addValueUser.addError("No internet");
  }
}

Future<void> GetPosts(userId) async {
  try {
    http.Response response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/posts/?userId=$userId"));

    if (response.statusCode == 200) {
      String data = response.body;
      Iterable lPosts = jsonDecode(data);

      List<Post> posts =
          List<Post>.from(lPosts.map((data) => Post.fromJson(data)));

      _addValuePost.add(posts);
    }
  } on SocketException catch (_) {
    _addValuePost.addError("No internet");
  }
}
