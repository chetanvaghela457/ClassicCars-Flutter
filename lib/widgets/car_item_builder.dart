// ignore_for_file: must_be_immutable, prefer_final_fields
// ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_typography.dart';
import '../models/car.dart';
import '../screens/details.dart';

class CarItemBuilder extends StatefulWidget {
  Car car;
  CarItemBuilder({Key? key, required this.car}) : super(key: key);

  @override
  State<CarItemBuilder> createState() => _CarItemBuilderState();
}

class _CarItemBuilderState extends State<CarItemBuilder>
    with TickerProviderStateMixin {
  bool _is_selected = false;
  late AnimationController _animation_controller;
  late Animation<Color?> _color_animation;
  late Animation<double> _scale_animation;
  @override
  void initState() {
    super.initState();
    _animation_controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _color_animation = ColorTween(begin: Colors.grey, end: Colors.red)
        .animate(_animation_controller);
    _scale_animation = TweenSequence<double>(
      [
        TweenSequenceItem(
          tween: Tween<double>(begin: 1, end: 1.5),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.5, end: 1),
          weight: 1,
        ),
      ],
    ).animate(_animation_controller);
    _animation_controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _is_selected = !_is_selected;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          _is_selected = !_is_selected;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final typography = AppTypography(context);
    Radius border_radius = Radius.circular(typography.padding * 3);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(PageRouteBuilder(pageBuilder: (context, a, b) {
          return Detail(car: widget.car);
        }));
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: typography.height * .02),
          height: typography.height * .2,
          width: typography.width * .65,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: typography.height * .16,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(10, 10),
                          color: Colors.black26.withOpacity(.2),
                          spreadRadius: 2,
                          blurRadius: 15)
                    ],
                    border: Border.all(color: Colors.black12, width: 2),
                    color: AppColors.PRIMARY_COLOR_DARK,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.elliptical(
                            typography.width * .2, typography.width * .1),
                        bottomLeft: border_radius,
                        bottomRight: border_radius,
                        topRight: border_radius)),
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(typography.padding * .5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            _is_selected
                                ? _animation_controller.reverse()
                                : _animation_controller.forward();
                          },
                          child: AnimatedBuilder(
                              animation: _animation_controller,
                              builder: (context, _) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: typography.padding / 3,
                                      horizontal: typography.padding * 1.2),
                                  decoration: BoxDecoration(
                                      color: AppColors.ACTIVE_COLOR,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: border_radius,
                                          topRight: border_radius)),
                                  child: Transform.scale(
                                    scaleX: _scale_animation.value,
                                    scaleY: _scale_animation.value,
                                    child: Icon(
                                      Icons.favorite_rounded,
                                      size: typography.h2 * 1.3,
                                      color: _color_animation.value,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: typography.padding * 2),
                        child: Text(widget.car.title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: typography.h2,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: typography.padding * 2),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: typography.padding * 2),
                        child: Text(widget.car.description.toUpperCase(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: typography.h3,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: typography.padding * 2),
                    ],
                  ),
                ),
              ),
              Transform.translate(
                offset:
                    Offset(-typography.padding * 5, -typography.height * .08),
                child: Hero(
                    tag: widget.car.id,
                    flightShuttleBuilder: (context, animation, flightDirection,
                        fromHeroContext, toHeroContext) {
                      Widget toHero = toHeroContext.widget;
                      if (flightDirection == HeroFlightDirection.pop) {
                        return toHero;
                      } else {
                        return FadeTransition(
                          opacity: const AlwaysStoppedAnimation(0),
                          child: toHero,
                        );
                      }
                    },
                    child: Image.asset(
                      widget.car.image_path,
                      height: typography.height * .15,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
