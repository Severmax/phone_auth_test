import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/state/auth_cubit.dart';
import '../presentation/home_screen.dart';
import '../presentation/login_screen/login_screen.dart';

class AuthListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state){
        debugPrint('AuthSuccess state detected');
        if (state is AuthSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (state is AuthInitial || state is AuthError) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      },
      child: Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
