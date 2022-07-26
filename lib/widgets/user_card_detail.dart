import 'package:flutter/material.dart';

import '../models/user.dart';

class UserCardDetailWidget extends StatelessWidget {
  final User userCard;

  const UserCardDetailWidget({
    Key? key,
    required this.userCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        color: Colors.amber,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 1),
              Text("Name: ${userCard.name}"),
              const Spacer(flex: 1),
              Text("email: ${userCard.email}"),
              const Spacer(flex: 1),
              Text("Phone: ${userCard.phone}"),
              const Spacer(flex: 1),
              Text("website: ${userCard.website}"),
              const Spacer(flex: 1),
              Text("Company: ${userCard.company.name} ${userCard.company.bs} "),
              Text(
                "${userCard.company.catchPhrase} ",
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const Spacer(flex: 1),
              Text(
                  "Address: ${userCard.address.city}, ${userCard.address.street}"),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
