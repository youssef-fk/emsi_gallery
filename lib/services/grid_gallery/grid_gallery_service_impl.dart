import 'package:cloud_firestore/cloud_firestore.dart';

import 'grid_gallery_service.dart';
import 'models/major_years/major_years.dart';

class GridGalleryServiceImpl implements GridGalleryService {
  final _kCollectionName = 'grid_select';

  final _firestore = Firestore.instance;

  @override
  Future<List<MajorYears>> getMajorYearsList({String siteName}) async {
    final query =
        await _firestore.collection(_kCollectionName).document(siteName).get();

    if (query.data == null) {
      return [];
    }

    return (query.data['data'] as List)
        .map((json) => MajorYears.fromJson(json))
        .toList();
  }

  @override
  Future<void> saveMajorYear({
    String siteName,
    String majorName,
    int year,
  }) async {
    final listMajorYears = await this.getMajorYearsList(siteName: siteName);

    final majorYears = listMajorYears.singleWhere(
      (e) => e.majorName == majorName,
      orElse: () => null,
    );

    final majorYearsIndex = listMajorYears.indexOf(majorYears);

    if (majorYears != null && majorYears.years.contains(year)) {
      return;
    }

    if (majorYears == null) {
      listMajorYears.add(MajorYears(majorName: majorName, years: [year]));
    } else {
      majorYears.years.add(year);

      listMajorYears[majorYearsIndex] = majorYears;
    }

    _firestore.collection(_kCollectionName).document(siteName).setData(
      {
        'data': listMajorYears.map((e) => e.toJson()).toList(),
      },
    );
  }
}
