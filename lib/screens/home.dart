import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../constants/app_cars.dart';
import '../constants/app_image.dart';
import '../constants/app_typography.dart';
import '../widgets/car_item_builder.dart';
import '../widgets/news_paper.dart';
import '../widgets/view_all_button.dart';
import 'categories.dart';
import 'menu.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeBloc _homeBloc = HomeBloc();

  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  Tween<Offset> _tween = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      final typography = AppTypography(context);
      _homeBloc.add(LoadInitialItems());
      _homeBloc.initializeItems([
        SizedBox(height: typography.height * .05),
        Center(
          child: Image.asset(
            AppImage.BANNER,
            width: typography.width * .3,
          ),
        ),
        SizedBox(height: typography.height * .01),
        Categories(),
        SizedBox(height: typography.height * .02),
        Text(
          "Near You".toUpperCase(),
          style: TextStyle(fontSize: typography.h1, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: typography.height * .02),
        ...List.generate(2, (index) => CarItemBuilder(car: AppCars().getCars()[index])).toList(),
        SizedBox(height: typography.height * .02),
        viewAllButton(onClickCallback: () {

          viewAll();
          // _homeBloc.add(ViewAllItems());
        }),
        SizedBox(height: typography.padding * 2),
        newsPaper(),
        SizedBox(height: typography.padding * 2)
      ]);
    });


    return BlocBuilder<HomeBloc, HomeState>(
      bloc: _homeBloc,
      builder: (context, state) {
        if (state is HomeLoaded) {
          return Menu(
              child: AnimatedList(
                  physics: const BouncingScrollPhysics(),
                  key: _key,
                  initialItemCount: state.items.length,
                  itemBuilder: (context, index, animation) {
                    return SlideTransition(
                      child: state.items[index],
                      position: animation.drive(_tween),
                    );
                  }));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  viewAll() {
    var future = Future(() {});
    setState(() {
      _tween =
          Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));
      // _show_all = true;
    });
    for (var i = 2; i < AppCars().getCars().length; i++) {
      future = future.then((_) {
        Widget element = CarItemBuilder(car: AppCars().getCars()[i]);
        inserAt(6, element);
        return Future.delayed(const Duration(milliseconds: 400));
      });
    }
  }

  inserAt(index, item) {
    _homeBloc.items.insert(index, item);
    _key.currentState?.insertItem(index);
  }
}
