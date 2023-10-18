// ignore_for_file: library_private_types_in_public_api

import 'package:cookmaster_front/app/data/store/user_store.dart';
import 'package:flutter/material.dart';

class DynamicStarRating extends StatefulWidget {
  const DynamicStarRating({super.key, required this.userStore});
  final UserStore userStore;

  @override
  _DynamicStarRatingState createState() => _DynamicStarRatingState();
}

class _DynamicStarRatingState extends State<DynamicStarRating> {
  int rating = 0;
  UserStore get _user => widget.userStore;
  @override
  Widget build(BuildContext context) {
    final List<Widget> starIcons = List.generate(5, (index) {
      return IconButton(
        onPressed: () {
          setState(() {
            rating = index + 1;
            
          });
        },
        icon: Icon(
          Icons.star,
          color: index < rating ? Colors.deepOrange : null,
          size: 40,
        ),
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: starIcons,
    );
  }
}
