import 'package:flutter/material.dart';

class TwitterPost extends StatelessWidget {
  const TwitterPost({super.key, required this.id, required this.text});

  final int id;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/profilowe.jpg'),
              radius: 15,
            ),
          ],
        ),
        Column(),
      ],
    );
  }
}
