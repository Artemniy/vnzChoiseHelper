import 'package:hive/hive.dart';

class HiveUtil {
  static const _favUniversitiesKey = 'favUniversities';

  static Future<void> setFavouriteUniversity(int id) async {
    final box = await Hive.openBox<int>(_favUniversitiesKey);
    await box.add(id);
  }

  static Future<void> removeFavouriteUniversity(int id) async {
    final box = await Hive.openBox<int>(_favUniversitiesKey);
    final universities = await getFavouriteUniversities();
    universities.removeWhere((element) => element == id);
    await box.clear();
    await box.addAll(universities);
  }

  static Future<List<int>> getFavouriteUniversities() async {
    final box = await Hive.openBox<int>(_favUniversitiesKey);
    return box.values.toList();
  }
}
