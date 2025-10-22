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

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => AuthCubit(api: api),
            child: MainScreen(),
        ));
      case "/login":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => AuthCubit(api: api),
            child: StyleTestApp(),
          ));
      case "/register":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => AuthCubit(api: api),
            child: StyleTestApp(),
          ));
      default:
        return MaterialPageRoute(builder: (context) => MainScreen());
    }
  }
}