import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'api/api_service.dart';
import 'main_screen.dart';
import 'states/auth.dart';
import 'utils/test_screen.dart';

class AppRouter {
  late ApiService api;

  AppRouter() {
    api = ApiService();
  }

  MaterialPageRoute _generateBlocPage(Widget page, Cubit cubit) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider(create: (BuildContext context) => cubit, child: page),
    );
  }

  Route generateRoute(RouteSettings settings) {
    if (api.loggedIn) {
      switch (settings.name) {
        case "/":
          return _generateBlocPage(MainScreen(), AuthCubit(api: api));
        case "/login":
          return _generateBlocPage(StyleTestApp(), AuthCubit(api: api));
        case "/register":
          return _generateBlocPage(StyleTestApp(), AuthCubit(api: api));
        default:
          return MaterialPageRoute(builder: (context) => MainScreen());
      }
    }
    return _generateBlocPage(StyleTestApp(), AuthCubit(api: api));
  }
}