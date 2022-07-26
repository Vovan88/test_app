import 'package:flutter/material.dart';
import 'package:flutter_test_application/models/user.dart';
import 'package:flutter_test_application/widgets/user_card.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.userCard.username)),
      body:
          ListView(children: [UserCardDetailWidget(userCard: widget.userCard)]),
    );
  }
}
