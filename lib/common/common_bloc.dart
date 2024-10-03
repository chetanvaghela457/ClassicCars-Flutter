import 'package:classiccars_flutter/bloc/category_bloc.dart';
import 'package:classiccars_flutter/bloc/home_bloc.dart';
import 'package:classiccars_flutter/bloc/menu_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common_bloc/bloc.dart';

class CommonBloc {
  /// Bloc
  static final applicationBloc = ApplicationBloc();
  static final homeBloc = HomeBloc();
  static final menuBloc = MenuBloc();
  static final categoriesBloc = CategoriesBloc();

  static final List<BlocProvider> blocProviders = [
    BlocProvider<ApplicationBloc>(
      create: (context) => applicationBloc,
    ),
    BlocProvider<HomeBloc>(
      create: (context) => homeBloc,
    ),
    BlocProvider<MenuBloc>(
      create: (context) => menuBloc,
    ),
    BlocProvider<CategoriesBloc>(
      create: (context) => categoriesBloc,
    )
  ];

  /// Dispose
  static void dispose() {
    applicationBloc.close();
    homeBloc.close();
    menuBloc.close();
    categoriesBloc.close();
  }

  /// Singleton factory
  static final CommonBloc _instance = CommonBloc._internal();

  factory CommonBloc() {
    return _instance;
  }
  CommonBloc._internal();
}