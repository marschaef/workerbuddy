import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/api_service.dart';
import 'state_info.dart';

class User {}

class UserStateSuccessful extends StateInfo {
  final String user;
  UserStateSuccessful({required this.user});
}

class UserCubit extends Cubit<StateInfo> {
  final ApiService api;

  UserCubit({required this.api, String? user})
    : super(user == null ? StateInitial() : UserStateSuccessful(user: user)) {
      void get() async {
        final cache = await api.cache.get('user');
        if (cache != null) emit(UserStateSuccessful(user: cache));
      }
      get();
    }

  void login(String email, String password) async {
    try {
      emit(StateLoading());
      if (email.isNotEmpty && password.isNotEmpty) {
        final response = await api.login(email, password);

        if (response != null) emit(UserStateSuccessful(user: response["value"]));
      } else {
        emit(StateError(message: "Invalid credentials"));
      }
    } catch (e) {
      print('Error user state login: ${e.toString()}');
    }
    emit(StateError(message: "Login failed"));
  }

  void logout() => emit(StateInitial());
}
