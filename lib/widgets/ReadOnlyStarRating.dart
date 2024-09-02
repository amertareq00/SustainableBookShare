import 'package:flutter/material.dart';

class ReadOnlyStarRating extends StatelessWidget {
  final int starCount;
  final double rating;

  ReadOnlyStarRating({
    this.starCount = 5,
    this.rating = 0,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        color: Colors.grey,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: Colors.amber,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: Colors.amber,
      );
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        starCount,
        (index) => buildStar(context, index),
      ),
    );
  }
}
