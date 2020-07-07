// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return UserProfile(
    promo: json['promo'] == null
        ? null
        : Promo.fromJson(json['promo'] as Map<String, dynamic>),
    uuid: json['uuid'] as String,
    site: json['site'] == null
        ? null
        : Site.fromJson(json['site'] as Map<String, dynamic>),
    name: json['name'] as String,
    imagePath: json['imagePath'] as String,
  );
}

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'promo': instance.promo?.toJson(),
      'site': instance.site?.toJson(),
      'name': instance.name,
      'imagePath': instance.imagePath,
    };
