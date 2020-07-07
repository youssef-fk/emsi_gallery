import 'package:json_annotation/json_annotation.dart';

import 'site.dart';

part 'city.g.dart';

@JsonSerializable(explicitToJson: true)
class City {
  final String name;
  final List<Site> sites;

  City(this.name, this.sites);

  factory City.fromJson(Map<String, dynamic> json) {
    return _$CityFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CityToJson(this);
  }
}
