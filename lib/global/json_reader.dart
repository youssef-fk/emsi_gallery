import 'package:flutter/services.dart' show rootBundle;

Future<String> _getJsonFromAsset(String name) async {
  return await rootBundle.loadString('assets/json/$name');
}

Future<String> get mapDataJSONString async =>
    await _getJsonFromAsset('map_data.json');
