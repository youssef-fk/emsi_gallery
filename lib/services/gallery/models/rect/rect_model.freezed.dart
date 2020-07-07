// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'rect_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
RectModel _$RectModelFromJson(Map<String, dynamic> json) {
  return Data.fromJson(json);
}

class _$RectModelTearOff {
  const _$RectModelTearOff();

  Data call(double left, double top, double right, double bottom) {
    return Data(
      left,
      top,
      right,
      bottom,
    );
  }
}

// ignore: unused_element
const $RectModel = _$RectModelTearOff();

mixin _$RectModel {
  double get left;
  double get top;
  double get right;
  double get bottom;

  Map<String, dynamic> toJson();
  $RectModelCopyWith<RectModel> get copyWith;
}

abstract class $RectModelCopyWith<$Res> {
  factory $RectModelCopyWith(RectModel value, $Res Function(RectModel) then) =
      _$RectModelCopyWithImpl<$Res>;
  $Res call({double left, double top, double right, double bottom});
}

class _$RectModelCopyWithImpl<$Res> implements $RectModelCopyWith<$Res> {
  _$RectModelCopyWithImpl(this._value, this._then);

  final RectModel _value;
  // ignore: unused_field
  final $Res Function(RectModel) _then;

  @override
  $Res call({
    Object left = freezed,
    Object top = freezed,
    Object right = freezed,
    Object bottom = freezed,
  }) {
    return _then(_value.copyWith(
      left: left == freezed ? _value.left : left as double,
      top: top == freezed ? _value.top : top as double,
      right: right == freezed ? _value.right : right as double,
      bottom: bottom == freezed ? _value.bottom : bottom as double,
    ));
  }
}

abstract class $DataCopyWith<$Res> implements $RectModelCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res>;
  @override
  $Res call({double left, double top, double right, double bottom});
}

class _$DataCopyWithImpl<$Res> extends _$RectModelCopyWithImpl<$Res>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(Data _value, $Res Function(Data) _then)
      : super(_value, (v) => _then(v as Data));

  @override
  Data get _value => super._value as Data;

  @override
  $Res call({
    Object left = freezed,
    Object top = freezed,
    Object right = freezed,
    Object bottom = freezed,
  }) {
    return _then(Data(
      left == freezed ? _value.left : left as double,
      top == freezed ? _value.top : top as double,
      right == freezed ? _value.right : right as double,
      bottom == freezed ? _value.bottom : bottom as double,
    ));
  }
}

@JsonSerializable(explicitToJson: true)
class _$Data extends Data {
  const _$Data(this.left, this.top, this.right, this.bottom)
      : assert(left != null),
        assert(top != null),
        assert(right != null),
        assert(bottom != null),
        super._();

  factory _$Data.fromJson(Map<String, dynamic> json) => _$_$DataFromJson(json);

  @override
  final double left;
  @override
  final double top;
  @override
  final double right;
  @override
  final double bottom;

  @override
  String toString() {
    return 'RectModel(left: $left, top: $top, right: $right, bottom: $bottom)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Data &&
            (identical(other.left, left) ||
                const DeepCollectionEquality().equals(other.left, left)) &&
            (identical(other.top, top) ||
                const DeepCollectionEquality().equals(other.top, top)) &&
            (identical(other.right, right) ||
                const DeepCollectionEquality().equals(other.right, right)) &&
            (identical(other.bottom, bottom) ||
                const DeepCollectionEquality().equals(other.bottom, bottom)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(left) ^
      const DeepCollectionEquality().hash(top) ^
      const DeepCollectionEquality().hash(right) ^
      const DeepCollectionEquality().hash(bottom);

  @override
  $DataCopyWith<Data> get copyWith =>
      _$DataCopyWithImpl<Data>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$DataToJson(this);
  }
}

abstract class Data extends RectModel {
  const Data._() : super._();
  const factory Data(double left, double top, double right, double bottom) =
      _$Data;

  factory Data.fromJson(Map<String, dynamic> json) = _$Data.fromJson;

  @override
  double get left;
  @override
  double get top;
  @override
  double get right;
  @override
  double get bottom;
  @override
  $DataCopyWith<Data> get copyWith;
}
