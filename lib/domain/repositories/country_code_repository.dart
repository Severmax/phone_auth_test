import '../models/country_code.dart';

abstract class CountryCodeRepository{

  Future<List<CountryCode>> getCountryCodes();

  
}