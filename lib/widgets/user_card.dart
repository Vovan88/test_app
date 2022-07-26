import 'package:flutter/material.dart';

import '../models/user.dart';

class UserCardWidget extends StatelessWidget {
  final User userCard;
  final Function(User) onTap;
  const UserCardWidget({Key? key, required this.userCard, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GestureDetector(
        onTap: () => onTap(userCard),
        child: Container(
          color: Colors.amber,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 1),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("UserName: ${userCard.username}"),
              ),
              const Spacer(flex: 1),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("Name: ${userCard.name}"),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
