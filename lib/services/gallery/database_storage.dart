import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../auth/models/promo/promo.dart';
import '../auth/models/user_profile/user_profile.dart';
import '../map/models/site.dart';
import 'models/app_image/app_image.dart';

part 'impls/database_storage_impl.dart';

abstract class GalleryDatabaseStorageService {
  Future<List<AppImage>> getAppImages({
    @required Site site,
    @required PromoField promoField,
    @required int expectedGraduationYear,
  });

  Future<List<UserProfile>> getUserProfiles({
    @required List<String> uuidList,
    @required Site site,
    @required PromoField promoField,
    @required int expectedGraduationYear,
  });

  Future<List<UserProfile>> getAllUserProfiles({
    @required Site site,
    @required PromoField promoField,
    @required int expectedGraduationYear,
  });

  Future<void> addImage({
    @required UserProfile userProfile,
    @required AppImage appImage,
  });

  Future<void> addUserProfile({
    @required UserProfile userProfile,
  });

  Stream<QuerySnapshot> getAppImagesStream({
    Site site,
    PromoField promoField,
    int expectedGraduationYear,
  });

  List<AppImage> documentsToAppImages(List<DocumentSnapshot> documents);
  Future<List<String>> getSiteMajors(String site);
  Future<List<int>> getMajorYearsBySiteAndMajorNames({
    @required String siteName,
    @required String major,
  });
}
