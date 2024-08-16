import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:phone_auth_test/domain/models/country_code.dart';

import '../repositories/country_code_repository.dart';

class CountryCodeCubit extends Cubit<List<CountryCode>> {

  final CountryCodeRepository _repository;
  List<CountryCode> _allCountryCodes = [];

  CountryCodeCubit(this._repository) : super([]);

  Future<void> fetchCountryCodes() async {
    try {
      final countryCodes = await _repository.getCountryCodes();
      _allCountryCodes = countryCodes;
      emit(countryCodes);
    } catch (e) {
      debugPrint("////////////////////////");
      debugPrint("$e");
      debugPrint("////////////////////////");
    }
  }

  void filterCountryCodes(String query) {
    if (query.isEmpty) {
      emit(_allCountryCodes);
    } else {
      final filteredCountryCodes = _allCountryCodes.where((countryCode) {
        return countryCode.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      emit(filteredCountryCodes);
    }
  }
}
