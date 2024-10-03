import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/common_bloc.dart';
import 'common/common_bloc/bloc.dart';
import 'common/routes.dart';
import 'constants/application.dart';

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  void initState() {
    CommonBloc.applicationBloc.add(SetupApplication());
    super.initState();
  }

  @override
  void dispose() {
    CommonBloc.dispose();
    super.dispose();
  }

  void onNavigate(String route) {
    _navigator!.pushNamedAndRemoveUntil(route, (route) => false);
  }


  // void loadData() {
  //   // Only load data when authenticated
  //   BlocProvider.of<ProfileBloc>(context).add(LoadProfile());
  //   BlocProvider.of<CartBloc>(context).add(LoadCart());
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationBloc, ApplicationState>(
      builder: (context, applicationState) {

        return MaterialApp(
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: Application.debug,
          title: Application.title,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: AppRouter.HOME,
          theme: ThemeData(
            fontFamily: "PoiretOne",
            primarySwatch: Colors.blue,
          ),
          builder: (context, child) {
            return BlocListener<ApplicationBloc, ApplicationState>(
              listener: (context, authState) {
                if (applicationState is ApplicationCompleted) {
                  // if (authState is Uninitialized) {
                  onNavigate(AppRouter.HOME);
                  // }
                } else {
                  onNavigate(AppRouter.HOME);
                }
              },
              child: child,
            );
          },
        );
      },
    );
  }
}
