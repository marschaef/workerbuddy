import 'package:flutter_bloc/flutter_bloc.dart';

import 'classes/user.dart';
import '../api/api_service.dart';
import 'state_info.dart';

class AuthStateSuccessful extends StateInfo {
  final User user;
  AuthStateSuccessful({required this.user});
}

class AuthCubit extends Cubit<StateInfo> {
  final ApiService api;

  AuthCubit({required this.api}) : super(StateInitial()) {
    void getCache() async {
      final cache = await api.cache.get(ApiMethod.login);
      if (cache == null) {
        emit(StateInitial());
      }else {
        emit(AuthStateSuccessful(user: User.fromJson(cache)));
      }
    }
    
    emit(StateLoading());
    getCache();
  }

  void login(String email, String password) async {
    try {
      emit(StateLoading());
      if (await api.cache.get(ApiMethod.login) != null) {
        emit(StateError(message: "Logout first"));
      } else if (email.isEmpty) {
        emit(StateError(message: "E-Mail missing"));
      } else if (password.isEmpty) {
        StateError(message: "Password missing");
      } else if (!email.contains('@') || !email.contains('.')) {
        emit(StateError(message: "Invalid email"));
      } else {
        final response = await api.login(email, password);
        if (response != null) {
          emit(AuthStateSuccessful(user: User.fromJson(response)));
        }
      }
    } catch (e) {
      print('Error user state login: ${e.toString()}');
    }
    emit(StateError(message: "Login failed"));
  }

  void register(String username, String email, String password) async {
    try {
      emit(StateLoading());
      if (await api.cache.get(ApiMethod.login) != null) {
        emit(StateError(message: "Logout first"));
      } else if (email.isEmpty) {
        emit(StateError(message: "E-Mail missing"));
      } else if (username.isEmpty) {
        emit(StateError(message: "Set username"));
      }else if (password.isEmpty) {
        StateError(message: "Password missing");
      } else if (!email.contains('@') || !email.contains('.')) {
        emit(StateError(message: "Invalid e-mail"));
      } else if (password.length < 8) {
        emit(StateError(message: "Invalid password"));
      }else {
        final response = await api.register(username, email, password);
        if (response != null) {
          emit(AuthStateSuccessful(user: User.fromJson(response)));
        }
      }
    } catch (e) {
      print('Error user state register: ${e.toString()}');
    }
    emit(StateError(message: "Register failed"));
  }

  void logout() async {
    try {
      emit(StateLoading());
      final response = await api.logout();

      if (response) {
        emit(StateInitial());
      }
    } catch (e) {
      print('Error user state logout: ${e.toString()}');
    }
    emit(StateError(message: "Logout failed"));
  }
}
