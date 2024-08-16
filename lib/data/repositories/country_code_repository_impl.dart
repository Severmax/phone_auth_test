import 'package:phone_auth_test/data/api/services/country_code_service.dart';

import '../../domain/models/country_code.dart';
import '../../domain/repositories/country_code_repository.dart';

class CountryCodeRepositoryImpl implements CountryCodeRepository {

  final CountryCodeService _service;

  CountryCodeRepositoryImpl(this._service);

  @override
  Future<List<CountryCode>> getCountryCodes() async {
    return await _service.fetchCountryCodes();
  }
}