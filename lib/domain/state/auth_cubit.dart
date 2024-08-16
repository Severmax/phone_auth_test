import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:phone_auth_test/domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final void Function()? onAuthSuccess;

  AuthCubit(this._authRepository, {this.onAuthSuccess}) : super(AuthInitial());

  Future<void> register(String phone, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      emit(AuthError('Passwords do not match'));
      return;
    }

    emit(AuthLoading());
    final success = await _authRepository.register(phone, password);
    if (success) {
      emit(AuthSuccess());
      if (onAuthSuccess != null) {
        onAuthSuccess!();
      }
    } else {
      emit(AuthError('Registration failed'));
    }
  }

  Future<void> login(String phone, String password) async {
    emit(AuthLoading());
    final success = await _authRepository.login(phone, password);
    if (success) {
      emit(AuthSuccess());
      if (onAuthSuccess != null) {
        onAuthSuccess!();
      }
    } else {
      emit(AuthError('Login failed'));
    }
  }


  Future<void> checkLoginStatus() async {
    final loggedIn = await _authRepository.isLoggedIn();
    if (loggedIn) {
      emit(AuthSuccess());
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    emit(AuthInitial());
  }
}
