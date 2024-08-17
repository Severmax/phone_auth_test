import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_test/domain/repositories/country_code_repository.dart';
import 'package:phone_auth_test/domain/state/auth_cubit.dart';
import 'package:phone_auth_test/domain/state/country_code_cubit.dart';
import 'package:phone_auth_test/internal/auth_listener.dart';
import 'package:phone_auth_test/internal/service_locator.dart';

import '../domain/repositories/auth_repository.dart';
import '../presentation/login_screen/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: repositoryProviders,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                CountryCodeCubit(context.read<CountryCodeRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                AuthCubit(
                    context.read<AuthRepository>(),)..checkLoginStatus(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Auth Demo',
          home: AuthListener(),
        ),
      ),
    );
  }
}