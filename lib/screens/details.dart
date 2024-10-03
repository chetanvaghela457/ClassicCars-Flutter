import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/app_cars.dart';
import '../constants/app_colors.dart';
import '../constants/app_constant.dart';
import '../constants/app_image.dart';
import '../constants/app_typography.dart';
import '../models/car.dart';
import 'package:flutter_lorem/flutter_lorem.dart' as lorem;

class Detail extends StatelessWidget {
  Car car;
  Detail({Key? key, required this.car}) : super(key: key);
  int _animation_duration = 500;

  @override
  Widget build(BuildContext context) {
    final typography = AppTypography(context);
    Radius radius = Radius.circular(typography.width * .05);
    double padding = typography.width * .05;
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: padding),
          height: typography.height * .9,
          width: double.infinity,
          decoration: BoxDecoration(
              boxShadow: [AppConstant.boxShadow],
              borderRadius: BorderRadius.only(
                  topLeft: radius,
                  topRight: radius,
                  bottomLeft: Radius.circular(typography.width * .1),
                  bottomRight: Radius.circular(typography.width * .02)),
              gradient: const LinearGradient(colors: [
                AppColors.SECONDARY_COLOR,
                AppColors.SECONDARY_COLOR_DARK,
              ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                      boxShadow: [AppConstant.boxShadow],
                      color: AppColors.ACTIVE_COLOR,
                      borderRadius: BorderRadius.all(radius)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.translate(
                        offset: Offset(0, -typography.height * .04),
                        child: Image.asset(
                          AppImage.BANNER,
                          height: typography.height * .1,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(
                            typography.width * .34, -typography.height * .06),
                        child: Image.asset(
                          AppImage.BADGE,
                          height: typography.height * .1,
                        ),
                      ),
                      Expanded(
                          child: TweenAnimationBuilder<double>(
                            tween: Tween<double>(begin: 1, end: .05),
                            curve: Curves.fastOutSlowIn,
                            duration: Duration(milliseconds: _animation_duration),
                            builder: (context, value, child) {
                              return Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..scale(typography.height * .0025)
                                  ..translate(typography.width * (-value),
                                      -typography.height * .025)
                                  ..rotateY(pi),
                                child: Hero(
                                  tag: car.id,
                                  child: Image.asset(
                                    car.image_path,
                                  ),
                                ),
                              );
                            },
                          )),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            fadeAnimationWidget(
                                duration: const Duration(milliseconds: 400),
                                children: Text(
                                  car.title,
                                  style: TextStyle(
                                      fontSize: typography.h1 * 3,
                                      fontWeight: FontWeight.bold),
                                )),
                            SizedBox(height: typography.padding / 2),
                            fadeAnimationWidget(
                                duration: const Duration(milliseconds: 600),
                                children: Text(
                                  lorem.lorem(paragraphs: 1, words: 100),
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      height: 1.9,
                                      fontSize: typography.h2,
                                      fontWeight: FontWeight.bold),
                                )),
                            SizedBox(height: typography.padding / 2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  AppCars()
                                      .getCars()[Random()
                                      .nextInt(AppCars().getCars().length)]
                                      .image_path,
                                  height: typography.height * .1,
                                ),
                                Transform(
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.001)
                                    ..scale(typography.width * .007)
                                    ..translate(-typography.width * .05,
                                        typography.height * .001)
                                    ..rotateZ(.3),
                                  child: Image.asset(
                                    AppImage.AWARD_GOLD,
                                    height: typography.width * .1,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Score".toUpperCase(),
                      style: TextStyle(
                          fontSize: typography.h2,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: typography.padding),
                    Row(
                      children: List.generate(5, (index) {
                        return Padding(
                          padding:
                          EdgeInsets.only(right: typography.padding) / 2,
                          child: Icon(
                            Icons.card_membership_rounded,
                            color: index < 4
                                ? Colors.white
                                : AppColors.SECONDARY_COLOR_DARK,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: typography.padding),
                    Text(
                      car.description.toUpperCase(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          height: 1.8,
                          fontSize: typography.h3,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget fadeAnimationWidget(
      {required Widget children, required Duration duration}) {
    const double ratio = 20;
    return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: -ratio, end: 0),
        duration: duration,
        builder: (ctx, value, child) {
          return Transform.translate(
            offset: Offset(0, -value),
            child: Opacity(
              opacity: (value + ratio) / ratio,
              child: children,
            ),
          );
        });
  }
}

class ContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double height = size.height;
    double width = size.width;
    double ratio = width * .02;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}