import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'rect_model.freezed.dart';
part 'rect_model.g.dart';

@freezed
abstract class RectModel implements _$RectModel {
  const RectModel._();
  @JsonSerializable(explicitToJson: true)
  const factory RectModel(
    final double left,
    final double top,
    final double right,
    final double bottom,
  ) = Data;

  factory RectModel.fromJson(Map<String, dynamic> json) =>
      _$RectModelFromJson(json);

  Rect get rect => Rect.fromLTRB(left, top, right, bottom);
}

RectModel getRectModelFromRect(Rect rect) =>
    RectModel(rect.left, rect.top, rect.right, rect.bottom);
