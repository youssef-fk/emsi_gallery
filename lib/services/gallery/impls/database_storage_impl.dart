part of '../database_storage.dart';

class GalleryDatabaseStorageServiceImpl implements GalleryDatabaseStorageService {
  static const kCollectionNameImages = 'app_images';
  static const kCollectionNameProfiles = 'app_images';

  final _firestore = Firestore.instance;

  CollectionReference _collection({
    @required Site site,
    @required PromoField promoField,
    @required int expectedGraduationYear,
  }) =>
      _firestore
          .collection(kCollectionNameImages)
          .document(site.name)
          .collection(promoField.value)
          .document(expectedGraduationYear.toString())
          .collection('images');

  CollectionReference _collectionProfile({
    @required Site site,
    @required PromoField promoField,
    @required int expectedGraduationYear,
  }) =>
      _firestore
          .collection(kCollectionNameProfiles)
          .document(site.name)
          .collection(promoField.value)
          .document(expectedGraduationYear.toString())
          .collection('profiles');

  @override
  Future<void> addImage({
    @required UserProfile userProfile,
    @required AppImage appImage,
  }) async {
    await _collection(
      expectedGraduationYear: userProfile.expectedGraduationYear,
      promoField: userProfile.promo.promoField,
      site: userProfile.site,
    ).add(
      appImage.toJson(),
    );
  }

  @override
  Future<List<AppImage>> getAppImages({
    Site site,
    PromoField promoField,
    int expectedGraduationYear,
  }) async {
    final docSnapshot = (await _collection(
      site: site,
      promoField: promoField,
      expectedGraduationYear: expectedGraduationYear,
    ).getDocuments());

    return documentsToAppImages(docSnapshot.documents);
  }

  @override
  Stream<QuerySnapshot> getAppImagesStream({
    Site site,
    PromoField promoField,
    int expectedGraduationYear,
  }) {
    final collection = _collection(
      site: site,
      promoField: promoField,
      expectedGraduationYear: expectedGraduationYear,
    );

    return collection.snapshots();
  }

  @override
  List<AppImage> documentsToAppImages(List<DocumentSnapshot> documents) {
    return documents.map((e) => AppImage.fromJson(e.data)).toList();
  }

  @override
  Future<void> addUserProfile({
    UserProfile userProfile,
  }) async {
    await _collectionProfile(
      expectedGraduationYear: userProfile.expectedGraduationYear,
      promoField: userProfile.promo.promoField,
      site: userProfile.site,
    ).add(
      userProfile.toJson(),
    );
  }

  @override
  Future<List<UserProfile>> getUserProfiles({
    @required List<String> uuidList,
    @required Site site,
    @required PromoField promoField,
    @required int expectedGraduationYear,
  }) async {
    if (uuidList.isNotEmpty) {
      final snapshot = await _collectionProfile(
        site: site,
        promoField: promoField,
        expectedGraduationYear: expectedGraduationYear,
      ).where('uuid', whereIn: uuidList).getDocuments();

      return snapshot.documents.map((e) => UserProfile.fromJson(e.data)).toList();
    }
    return <UserProfile>[];
  }

  Future<List<String>> getSiteMajors(String site) async {
    final querySnapshot = await _firestore.collection(kCollectionNameProfiles).snapshots().single;

    print(querySnapshot.toString());

    return querySnapshot.documents.map((e) => e.documentID).toList();
  }

  Future<List<int>> getMajorYearsBySiteAndMajorNames({
    @required String siteName,
    @required String major,
  }) async {
    final query = await _firestore
        .collection(kCollectionNameProfiles)
        .document(siteName)
        .collection(major)
        .snapshots()
        .single;

    return query.documents.map((e) => int.parse(e.documentID)).toList();
  }

  @override
  Future<List<UserProfile>> getAllUserProfiles({
    Site site,
    PromoField promoField,
    int expectedGraduationYear,
  }) async {
    final snapshot = await _collectionProfile(
      site: site,
      promoField: promoField,
      expectedGraduationYear: expectedGraduationYear,
    ).getDocuments();

    return snapshot.documents.map((e) => UserProfile.fromJson(e.data)).toList();
  }
}
