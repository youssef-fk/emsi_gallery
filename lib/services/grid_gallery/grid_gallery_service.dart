import 'package:meta/meta.dart';

import 'models/major_years/major_years.dart';

abstract class GridGalleryService {
  Future<List<MajorYears>> getMajorYearsList({@required String siteName});

  Future<void> saveMajorYear({
    @required String siteName,
    @required String majorName,
    @required int year,
  });
}
