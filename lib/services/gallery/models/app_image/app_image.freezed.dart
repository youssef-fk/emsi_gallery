// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'app_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
AppImage _$AppImageFromJson(Map<String, dynamic> json) {
  return Data.fromJson(json);
}

class _$AppImageTearOff {
  const _$AppImageTearOff();

  Data call(
      {@required String imagePath,
      @required String posterProfileUuid,
      @required List<User> taggedUsers,
      @required String title,
      @required DateTime timestamp}) {
    return Data(
      imagePath: imagePath,
      posterProfileUuid: posterProfileUuid,
      taggedUsers: taggedUsers,
      title: title,
      timestamp: timestamp,
    );
  }
}

// ignore: unused_element
const $AppImage = _$AppImageTearOff();

mixin _$AppImage {
  String get imagePath;
  String get posterProfileUuid;
  List<User> get taggedUsers;
  String get title;
  DateTime get timestamp;

  Map<String, dynamic> toJson();
  $AppImageCopyWith<AppImage> get copyWith;
}

abstract class $AppImageCopyWith<$Res> {
  factory $AppImageCopyWith(AppImage value, $Res Function(AppImage) then) =
      _$AppImageCopyWithImpl<$Res>;
  $Res call(
      {String imagePath,
      String posterProfileUuid,
      List<User> taggedUsers,
      String title,
      DateTime timestamp});
}

class _$AppImageCopyWithImpl<$Res> implements $AppImageCopyWith<$Res> {
  _$AppImageCopyWithImpl(this._value, this._then);

  final AppImage _value;
  // ignore: unused_field
  final $Res Function(AppImage) _then;

  @override
  $Res call({
    Object imagePath = freezed,
    Object posterProfileUuid = freezed,
    Object taggedUsers = freezed,
    Object title = freezed,
    Object timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      imagePath: imagePath == freezed ? _value.imagePath : imagePath as String,
      posterProfileUuid: posterProfileUuid == freezed
          ? _value.posterProfileUuid
          : posterProfileUuid as String,
      taggedUsers: taggedUsers == freezed
          ? _value.taggedUsers
          : taggedUsers as List<User>,
      title: title == freezed ? _value.title : title as String,
      timestamp:
          timestamp == freezed ? _value.timestamp : timestamp as DateTime,
    ));
  }
}

abstract class $DataCopyWith<$Res> implements $AppImageCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String imagePath,
      String posterProfileUuid,
      List<User> taggedUsers,
      String title,
      DateTime timestamp});
}

class _$DataCopyWithImpl<$Res> extends _$AppImageCopyWithImpl<$Res>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(Data _value, $Res Function(Data) _then)
      : super(_value, (v) => _then(v as Data));

  @override
  Data get _value => super._value as Data;

  @override
  $Res call({
    Object imagePath = freezed,
    Object posterProfileUuid = freezed,
    Object taggedUsers = freezed,
    Object title = freezed,
    Object timestamp = freezed,
  }) {
    return _then(Data(
      imagePath: imagePath == freezed ? _value.imagePath : imagePath as String,
      posterProfileUuid: posterProfileUuid == freezed
          ? _value.posterProfileUuid
          : posterProfileUuid as String,
      taggedUsers: taggedUsers == freezed
          ? _value.taggedUsers
          : taggedUsers as List<User>,
      title: title == freezed ? _value.title : title as String,
      timestamp:
          timestamp == freezed ? _value.timestamp : timestamp as DateTime,
    ));
  }
}

@JsonSerializable(explicitToJson: true)
class _$Data implements Data {
  const _$Data(
      {@required this.imagePath,
      @required this.posterProfileUuid,
      @required this.taggedUsers,
      @required this.title,
      @required this.timestamp})
      : assert(imagePath != null),
        assert(posterProfileUuid != null),
        assert(taggedUsers != null),
        assert(title != null),
        assert(timestamp != null);

  factory _$Data.fromJson(Map<String, dynamic> json) => _$_$DataFromJson(json);

  @override
  final String imagePath;
  @override
  final String posterProfileUuid;
  @override
  final List<User> taggedUsers;
  @override
  final String title;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'AppImage(imagePath: $imagePath, posterProfileUuid: $posterProfileUuid, taggedUsers: $taggedUsers, title: $title, timestamp: $timestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Data &&
            (identical(other.imagePath, imagePath) ||
                const DeepCollectionEquality()
                    .equals(other.imagePath, imagePath)) &&
            (identical(other.posterProfileUuid, posterProfileUuid) ||
                const DeepCollectionEquality()
                    .equals(other.posterProfileUuid, posterProfileUuid)) &&
            (identical(other.taggedUsers, taggedUsers) ||
                const DeepCollectionEquality()
                    .equals(other.taggedUsers, taggedUsers)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(imagePath) ^
      const DeepCollectionEquality().hash(posterProfileUuid) ^
      const DeepCollectionEquality().hash(taggedUsers) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(timestamp);

  @override
  $DataCopyWith<Data> get copyWith =>
      _$DataCopyWithImpl<Data>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$DataToJson(this);
  }
}

abstract class Data implements AppImage {
  const factory Data(
      {@required String imagePath,
      @required String posterProfileUuid,
      @required List<User> taggedUsers,
      @required String title,
      @required DateTime timestamp}) = _$Data;

  factory Data.fromJson(Map<String, dynamic> json) = _$Data.fromJson;

  @override
  String get imagePath;
  @override
  String get posterProfileUuid;
  @override
  List<User> get taggedUsers;
  @override
  String get title;
  @override
  DateTime get timestamp;
  @override
  $DataCopyWith<Data> get copyWith;
}
