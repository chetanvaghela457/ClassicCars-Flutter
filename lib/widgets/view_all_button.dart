import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../constants/app_colors.dart';
import '../constants/app_typography.dart';

Widget viewAllButton({required Function onClickCallback}) {
  return Builder(builder: (context) {
    final typography = AppTypography(context);
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          onClickCallback.call();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: typography.padding, horizontal: 2 * typography.padding),
          margin: EdgeInsets.only(right: typography.width * .1),
          decoration: BoxDecoration(
              color: AppColors.SECONDARY_COLOR_DARK,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(typography.padding),
                  bottomLeft: Radius.circular(typography.padding))),
          child: Text(
            "View All".toUpperCase(),
            style: TextStyle(
                fontSize: typography.h2,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  });
}
