
part of "auth_cubit.dart";

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  AuthSuccess(){
    debugPrint("//////////////////");
    debugPrint("Успішна авторизація");
    debugPrint("//////////////////");
  }
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message){
    debugPrint("//////////////////");
    debugPrint("Помилка: $message");
    debugPrint("//////////////////");
  }
}

class AuthLoading extends AuthState{}