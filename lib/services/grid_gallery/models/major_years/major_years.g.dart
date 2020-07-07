// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'major_years.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Data _$_$DataFromJson(Map<String, dynamic> json) {
  return _$Data(
    majorName: json['majorName'] as String,
    years: (json['years'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$_$DataToJson(_$Data instance) => <String, dynamic>{
      'majorName': instance.majorName,
      'years': instance.years,
    };
