
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/api/services/country_code_service.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../data/repositories/country_code_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/country_code_repository.dart';

List<RepositoryProvider> repositoryProviders = [
  RepositoryProvider<CountryCodeService>(create: (_) => CountryCodeService()),
  RepositoryProvider<CountryCodeRepository>(
    create: (context) => CountryCodeRepositoryImpl(context.read<CountryCodeService>()),
  ),
  RepositoryProvider<AuthRepository>(
    create: (context) => AuthRepositoryImpl(),
  ),
];