import 'package:classiccars_flutter/screens/home.dart';
import 'package:classiccars_flutter/widgets/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'appview.dart';
import 'bloc/category_bloc.dart';
import 'bloc/home_bloc.dart';
import 'bloc/menu_bloc.dart';
import 'common/common_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: CommonBloc.blocProviders,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              return AppView();
            },
          );
        },
      ),
    );
  }
}
