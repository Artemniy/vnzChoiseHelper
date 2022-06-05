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
      this.address,
      this.email,
      this.phone,
      this.site});
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
  String? address;
  String? phone;
  String? site;
  String? email;

  String get fullAddress =>
      '${region ?? ''} область, ${city ?? ''}, ${address ?? ''}';
  @override
  String toString() {
    return '$id $name $city';
  }
}
