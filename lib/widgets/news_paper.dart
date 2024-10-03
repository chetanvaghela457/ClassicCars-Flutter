// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';

import '../constants/app_image.dart';
import '../constants/app_typography.dart';

Widget newsPaper() {
  return Builder(builder: (context) {
    final typography = AppTypography(context);
    Radius border_radius = Radius.circular(typography.padding * 3);
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 400,
          width: typography.width * .65,
          decoration: BoxDecoration(
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                  offset: Offset(3, 0),
                  color: Colors.black12,
                  spreadRadius: 5,
                  blurRadius: 10)
            ],
            image: const DecorationImage(
                image: AssetImage(AppImage.NEWS_PAPER), fit: BoxFit.fill),
            borderRadius: BorderRadius.only(
                topRight: border_radius,
                topLeft: Radius.elliptical(
                    typography.width * .1, typography.width * .1)),
          ),
        ));
  });
}
