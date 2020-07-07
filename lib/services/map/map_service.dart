import 'dart:convert';

import 'package:emsi_gallery/global/json_reader.dart';
import 'models/city.dart';

abstract class MapService {
  Future<List<City>> get cities;
}

class MapServiceImpl implements MapService {
  List<City> _cities;

  Future<List<City>> get cities async {
    if (this._cities == null) {
      final cities = json.decode(await mapDataJSONString)['cities'] as List;

      this._cities = cities
          .map(
            (city) => City.fromJson(city),
          )
          .toList()
            ..sort(
              (city1, city2) =>
                  city2.sites.length.compareTo(city1.sites.length),
            );
    }

    return _cities;
  }
}
