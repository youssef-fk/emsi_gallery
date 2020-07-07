import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../user/user.dart';

part 'app_image.freezed.dart';
part 'app_image.g.dart';

@freezed
abstract class AppImage with _$AppImage {
  @JsonSerializable(explicitToJson: true)
  const factory AppImage({
    @required String imagePath,
    @required String posterProfileUuid,
    @required List<User> taggedUsers,
    @required String title,
    @required DateTime timestamp,
  }) = Data;

  factory AppImage.fromJson(Map<String, dynamic> json) {
    return _$AppImageFromJson(json);
  }
}
