import 'package:dyplom/data/db/entity/university.dart';

class SearchUtil {
  static bool contains(University university, String val) {
    var allUniverSearchFields =
        '${university.address} ${university.city} ${university.name} ${university.region} ${university.shortName}'
            .toLowerCase();
    return allUniverSearchFields.contains(val.toLowerCase());
  }
}
