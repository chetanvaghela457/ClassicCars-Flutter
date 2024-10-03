import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/menu_bloc.dart';
import '../constants/app_colors.dart';
import '../constants/app_icons.dart';
import '../constants/app_image.dart';
import '../constants/app_typography.dart';
import '../widgets/clip_shadow.dart';
import '../widgets/navigation_clipper.dart';

class Menu extends StatefulWidget {
  final Widget child;
  Menu({Key? key, required this.child}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selected_index = 1;
  final List<String> _menus = ["Home", "Invoke", "Notification", "My Profile"];
  Tween<double> _animation_tween = Tween<double>(begin: 0, end: 1);
  List<Widget> _navigations = [];

  @override
  Widget build(BuildContext context) {
    final typography = AppTypography(context);

    _navigations = [
      createNavigtionIcon(path: AppIcons.SHOPPING),
      ..._menus.map((menu) => createNavigationItem(item: menu)).toList(),
      createNavigtionIcon(
          path: AppImage.BADGE, navigationIconType: NavigationIconType.img),
      createNavigtionIcon(path: AppIcons.MENU),
    ];

    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return Scaffold(
          body: Row(
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 300),
                tween: _animation_tween,
                builder: (context, value, child) {
                  return Column(
                    children: [
                      SizedBox(height: typography.height * .05),
                      Expanded(
                        child: ClipShadow(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.6),
                                offset: Offset.zero,
                                blurRadius: 10,
                                spreadRadius: .2,
                                blurStyle: BlurStyle.outer),
                          ],
                          clipper: NavigationClipper(
                              elements_count: _navigations.length,
                              selected_index: value),
                          child: Container(
                            height: (typography.height),
                            width: (typography.width * .25),
                            decoration:
                            BoxDecoration(color: AppColors.ACTIVE_COLOR),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: _navigations.reversed
                                  .toList()
                                  .asMap()
                                  .entries
                                  .map(
                                    (e) => Expanded(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      _selected_index == e.key
                                          ? Positioned(
                                        right:
                                        typography.width * .12,
                                        child: Container(
                                          height: typography.width *
                                              .015,
                                          width: typography.width *
                                              .015,
                                          decoration: BoxDecoration(
                                              color: AppColors
                                                  .SECONDARY_COLOR_DARK,
                                              shape:
                                              BoxShape.circle),
                                        ),
                                      )
                                          : const SizedBox(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _animation_tween =
                                                Tween<double>(
                                                    begin: _selected_index
                                                        .toDouble(),
                                                    end:
                                                    e.key.toDouble());
                                            _selected_index = e.key;
                                          });
                                        },
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                right: typography.width *
                                                    .1),
                                            child:
                                            Center(child: e.value)),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: typography.height * .01),
                    ],
                  );
                },
              ),
              Expanded(child: widget.child),
            ],
          ),
        );
      },
    );
  }

  Widget createNavigtionIcon(
      {required String path,
        NavigationIconType navigationIconType = NavigationIconType.svg}) {
    return Builder(builder: (context) {
      final typography = AppTypography(context);
      if (navigationIconType == NavigationIconType.svg) {
        return SvgPicture.asset(
          path,
          height: typography.width * .06,
          color: AppColors.SECONDARY_COLOR,
        );
      }
      return Image.asset(
        path,
        height: typography.width * .08,
      );
    });
  }

  Widget createNavigationItem({required String item}) {
    return Builder(builder: (context) {
      final typography = AppTypography(context);
      return RotatedBox(
        quarterTurns: 3,
        child: Text(
          item.toUpperCase(),
          overflow: TextOverflow.ellipsis,
          style:
          TextStyle(fontSize: typography.h2, fontWeight: FontWeight.bold),
        ),
      );
    });
  }
}

enum NavigationIconType { svg, img }