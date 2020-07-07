import 'package:freezed_annotation/freezed_annotation.dart';

part 'major_years.freezed.dart';
part 'major_years.g.dart';

@freezed
abstract class MajorYears with _$MajorYears {
  const factory MajorYears({
    @required String majorName,
    @required List<int> years,
  }) = Data;

  factory MajorYears.fromJson(Map<String, dynamic> json) {
    return _$MajorYearsFromJson(json);
  }
}
