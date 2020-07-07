import 'package:json_annotation/json_annotation.dart';

part 'coords.g.dart';

@JsonSerializable()
class Coords {
  final double latitude;
  final double longitude;

  Coords(this.latitude, this.longitude);

  factory Coords.fromJson(Map<String, dynamic> json) {
    return _$CoordsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CoordsToJson(this);
  }
}
