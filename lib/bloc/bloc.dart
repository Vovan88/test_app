import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test_application/models/user.dart';
import 'package:http/http.dart' as http;

final StreamController<List<User>> _streamController =
    StreamController<List<User>>();

Stream<List<User>> get streamUsers => _streamController.stream;
StreamSink get _addValue => _streamController.sink;

Future<void> GetUsers() async {
  try {
    http.Response response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      String data = response.body;
      Iterable lUsers = jsonDecode(data);

      List<User> users =
          List<User>.from(lUsers.map((data) => User.fromJson(data)));

      _addValue.add(users);
    }
  } on SocketException catch (_) {
    _addValue.addError("No internet");
  }
}
