import 'package:json_annotation/json_annotation.dart';

import 'coords.dart';

part 'site.g.dart';

@JsonSerializable(explicitToJson: true)
class Site {
  final String name;
  final Coords coords;

  Site(this.name, this.coords);

  factory Site.fromJson(Map<String, dynamic> json) {
    return _$SiteFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SiteToJson(this);
  }
}
