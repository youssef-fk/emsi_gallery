import 'dart:typed_data';

import 'package:http/http.dart';

Future<Uint8List> downloadImage(String url) async {
  final response = await get(url);

  return response.bodyBytes;
}
