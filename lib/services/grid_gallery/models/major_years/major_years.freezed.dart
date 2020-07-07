// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'major_years.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
MajorYears _$MajorYearsFromJson(Map<String, dynamic> json) {
  return Data.fromJson(json);
}

class _$MajorYearsTearOff {
  const _$MajorYearsTearOff();

  Data call({@required String majorName, @required List<int> years}) {
    return Data(
      majorName: majorName,
      years: years,
    );
  }
}

// ignore: unused_element
const $MajorYears = _$MajorYearsTearOff();

mixin _$MajorYears {
  String get majorName;
  List<int> get years;

  Map<String, dynamic> toJson();
  $MajorYearsCopyWith<MajorYears> get copyWith;
}

abstract class $MajorYearsCopyWith<$Res> {
  factory $MajorYearsCopyWith(
          MajorYears value, $Res Function(MajorYears) then) =
      _$MajorYearsCopyWithImpl<$Res>;
  $Res call({String majorName, List<int> years});
}

class _$MajorYearsCopyWithImpl<$Res> implements $MajorYearsCopyWith<$Res> {
  _$MajorYearsCopyWithImpl(this._value, this._then);

  final MajorYears _value;
  // ignore: unused_field
  final $Res Function(MajorYears) _then;

  @override
  $Res call({
    Object majorName = freezed,
    Object years = freezed,
  }) {
    return _then(_value.copyWith(
      majorName: majorName == freezed ? _value.majorName : majorName as String,
      years: years == freezed ? _value.years : years as List<int>,
    ));
  }
}

abstract class $DataCopyWith<$Res> implements $MajorYearsCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res>;
  @override
  $Res call({String majorName, List<int> years});
}

class _$DataCopyWithImpl<$Res> extends _$MajorYearsCopyWithImpl<$Res>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(Data _value, $Res Function(Data) _then)
      : super(_value, (v) => _then(v as Data));

  @override
  Data get _value => super._value as Data;

  @override
  $Res call({
    Object majorName = freezed,
    Object years = freezed,
  }) {
    return _then(Data(
      majorName: majorName == freezed ? _value.majorName : majorName as String,
      years: years == freezed ? _value.years : years as List<int>,
    ));
  }
}

@JsonSerializable()
class _$Data implements Data {
  const _$Data({@required this.majorName, @required this.years})
      : assert(majorName != null),
        assert(years != null);

  factory _$Data.fromJson(Map<String, dynamic> json) => _$_$DataFromJson(json);

  @override
  final String majorName;
  @override
  final List<int> years;

  @override
  String toString() {
    return 'MajorYears(majorName: $majorName, years: $years)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Data &&
            (identical(other.majorName, majorName) ||
                const DeepCollectionEquality()
                    .equals(other.majorName, majorName)) &&
            (identical(other.years, years) ||
                const DeepCollectionEquality().equals(other.years, years)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(majorName) ^
      const DeepCollectionEquality().hash(years);

  @override
  $DataCopyWith<Data> get copyWith =>
      _$DataCopyWithImpl<Data>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$DataToJson(this);
  }
}

abstract class Data implements MajorYears {
  const factory Data({@required String majorName, @required List<int> years}) =
      _$Data;

  factory Data.fromJson(Map<String, dynamic> json) = _$Data.fromJson;

  @override
  String get majorName;
  @override
  List<int> get years;
  @override
  $DataCopyWith<Data> get copyWith;
}
