// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
User _$UserFromJson(Map<String, dynamic> json) {
  return Data.fromJson(json);
}

class _$UserTearOff {
  const _$UserTearOff();

  Data call({int faceId, String name, RectModel box}) {
    return Data(
      faceId: faceId,
      name: name,
      box: box,
    );
  }
}

// ignore: unused_element
const $User = _$UserTearOff();

mixin _$User {
  int get faceId;
  String get name;
  RectModel get box;

  Map<String, dynamic> toJson();
  $UserCopyWith<User> get copyWith;
}

abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call({int faceId, String name, RectModel box});

  $RectModelCopyWith<$Res> get box;
}

class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object faceId = freezed,
    Object name = freezed,
    Object box = freezed,
  }) {
    return _then(_value.copyWith(
      faceId: faceId == freezed ? _value.faceId : faceId as int,
      name: name == freezed ? _value.name : name as String,
      box: box == freezed ? _value.box : box as RectModel,
    ));
  }

  @override
  $RectModelCopyWith<$Res> get box {
    if (_value.box == null) {
      return null;
    }
    return $RectModelCopyWith<$Res>(_value.box, (value) {
      return _then(_value.copyWith(box: value));
    });
  }
}

abstract class $DataCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res>;
  @override
  $Res call({int faceId, String name, RectModel box});

  @override
  $RectModelCopyWith<$Res> get box;
}

class _$DataCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(Data _value, $Res Function(Data) _then)
      : super(_value, (v) => _then(v as Data));

  @override
  Data get _value => super._value as Data;

  @override
  $Res call({
    Object faceId = freezed,
    Object name = freezed,
    Object box = freezed,
  }) {
    return _then(Data(
      faceId: faceId == freezed ? _value.faceId : faceId as int,
      name: name == freezed ? _value.name : name as String,
      box: box == freezed ? _value.box : box as RectModel,
    ));
  }
}

@JsonSerializable(explicitToJson: true)
class _$Data implements Data {
  const _$Data({this.faceId, this.name, this.box});

  factory _$Data.fromJson(Map<String, dynamic> json) => _$_$DataFromJson(json);

  @override
  final int faceId;
  @override
  final String name;
  @override
  final RectModel box;

  @override
  String toString() {
    return 'User(faceId: $faceId, name: $name, box: $box)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Data &&
            (identical(other.faceId, faceId) ||
                const DeepCollectionEquality().equals(other.faceId, faceId)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.box, box) ||
                const DeepCollectionEquality().equals(other.box, box)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(faceId) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(box);

  @override
  $DataCopyWith<Data> get copyWith =>
      _$DataCopyWithImpl<Data>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$DataToJson(this);
  }
}

abstract class Data implements User {
  const factory Data({int faceId, String name, RectModel box}) = _$Data;

  factory Data.fromJson(Map<String, dynamic> json) = _$Data.fromJson;

  @override
  int get faceId;
  @override
  String get name;
  @override
  RectModel get box;
  @override
  $DataCopyWith<Data> get copyWith;
}
