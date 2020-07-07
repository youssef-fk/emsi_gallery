import '../rect/rect_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  @JsonSerializable(explicitToJson: true)
  const factory User({
    int faceId,
    String name,
    final RectModel box,
  }) = Data;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
