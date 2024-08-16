import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../domain/models/country_code.dart';

class CountryCodeService {
  final Dio _dio = Dio();
  final String apiUrl = 'https://gist.githubusercontent.com/anubhavshrimal/75f6183458db8c453306f93521e93d37/raw/f77e7598a8503f1f70528ae1cbf9f66755698a16/CountryCodes.json';

  Future<List<CountryCode>> fetchCountryCodes() async {
    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data is String ? json.decode(response.data) : response.data;
        return data.map((item) => CountryCode.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load country codes');
      }
    } catch (e) {
      throw Exception('Failed to load country codes: $e');
    }
  }
}