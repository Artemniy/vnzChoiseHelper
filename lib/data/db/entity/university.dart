import 'package:floor/floor.dart';

@entity
class University {
  University(
      {this.id,
      this.name,
      this.shortName,
      this.city,
      this.region,
      this.lat,
      this.lng,
      this.studentsCount,
      this.year,
      this.rankingPosition,
      this.rating,
      this.employedGraduatesCount,
      this.listedAbroad,
      this.facultiesList,
      this.type});
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? name;
  String? shortName;
  String? city;
  String? region;
  double? lat;
  double? lng;
  int? studentsCount;
  int? year;
  int? rankingPosition;
  double? rating;
  int? employedGraduatesCount;
  bool? listedAbroad;
  String? facultiesList;
  String? type;

  @override
  String toString() {
    return '$id $name $city';
  }
}
