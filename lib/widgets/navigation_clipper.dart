// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';

class NavigationClipper extends CustomClipper<Path> {
  int elements_count;
  double selected_index;
  NavigationClipper(
      {required this.elements_count, required this.selected_index});
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    double one_height = height / elements_count;
    Path path = Path();
    path.quadraticBezierTo(width * .6, 0, width * .6, one_height * .15);
    path.lineTo(width * .6, (one_height * selected_index) + one_height * .1);
    path.quadraticBezierTo(
        width * .59,
        (one_height * selected_index) + one_height * .2,
        width * .7,
        (one_height * selected_index) + one_height * .3);
    path.quadraticBezierTo(
        width * .85,
        (one_height * selected_index) + one_height * .5,
        width * .7,
        (one_height * selected_index) + one_height * .7);
    path.quadraticBezierTo(
        width * .6,
        (one_height * selected_index) + one_height * .8,
        width * .6,
        (one_height * selected_index) + one_height * .9);
    path.lineTo(width * .6, height - (one_height * .15));
    path.quadraticBezierTo(width * .6, height, 0, height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
