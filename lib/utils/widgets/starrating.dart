import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:flutter/material.dart';
typedef RatingChangeCallback = void Function(double rating);
class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback? onRatingChanged;
  final Color? color;

  const StarRating(
      {super.key, this.starCount = 5, required this.rating, this.onRatingChanged, this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        size: 18,
        color: Theme.of(context).buttonColor,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        size: 18,
        color: color ?? Theme.of(context).primaryColor,
      );
    } else {
      icon = Icon(
        Icons.star,
        size: 18,
        color: color ?? AppStyles.MAIN_COLOR,
      );
    }
    return InkResponse(
      onTap:
      onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children:
        List.generate(starCount, (index) => buildStar(context, index)));
  }
}