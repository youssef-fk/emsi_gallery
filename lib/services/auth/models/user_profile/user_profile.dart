import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import '../../../map/models/site.dart';
import '../promo/promo.dart';

part 'user_profile.g.dart';

@JsonSerializable(explicitToJson: true)
class UserProfile {
  final String uuid;
  final Promo promo;
  final Site site;
  final String name;
  String imagePath;

  @JsonKey(ignore: true)
  FirebaseUser user;

  UserProfile({
    @required this.promo,
    @required this.uuid,
    @required this.site,
    @required this.name,
    this.imagePath,
    File profilePhoto,
  }) {
    // Save picture
    if (profilePhoto != null) {
      getApplicationDocumentsDirectory().then((directory) {
        final path = directory.path;
        File('$path/profile_photo.jpg').writeAsBytesSync(
          profilePhoto.readAsBytesSync(),
        );
      });
    }
  }

  @JsonKey(ignore: true)
  Future<File> get profilePhoto async {
    final directory = await getApplicationDocumentsDirectory();

    return File('${directory.path}/profile_photo.jpg');
  }

  @JsonKey(ignore: true)
  String get promoName => this.promo.promoField.value;

  int get expectedGraduationYear => DateTime.now().year + 5 - promo.year;

  bool isSameClass(
    String siteName,
    int expectedGraduationYear,
    PromoField promoField,
  ) =>
      this.site.name == siteName &&
      this.expectedGraduationYear == expectedGraduationYear &&
      this.promo.promoFieldIndex == promoField.index;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return _$UserProfileFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserProfileToJson(this);
  }
}
