
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../domain/repositories/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<bool> register(String phone, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usersJson = prefs.getString('users');
    List<Map<String, String>> users = [];

    if (usersJson != null) {
      List<dynamic> decoded = json.decode(usersJson);
      users = decoded.map((user) => Map<String, String>.from(user)).toList();
    }

    if (users.any((user) => user['phone'] == phone)) {
      return false;
    }

    users.add({'phone': phone, 'password': password});
    await prefs.setString('users', json.encode(users));
    return true;
  }

  @override
  Future<bool> login(String phone, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usersJson = prefs.getString('users');
    List<Map<String, String>> users = [];

    if (usersJson != null) {
      List<dynamic> decoded = json.decode(usersJson);
      users = decoded.map((user) => Map<String, String>.from(user)).toList();
    }

    // Проверка наличия пользователя с указанным номером телефона и паролем
    bool userExists = users.any((user) => user['phone'] == phone && user['password'] == password);

    if (userExists) {
      // Сохранение текущего пользователя
      await prefs.setString('currentUser', phone);
    }

    return userExists;
  }

  @override
  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('currentUser');
  }

  @override
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
  }

  @override
  Future<Map<String, String>?> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? currentUserJson = prefs.getString('currentUser');

    if (currentUserJson != null) {
      return Map<String, String>.from(json.decode(currentUserJson));
    }

    return null;
  }
}