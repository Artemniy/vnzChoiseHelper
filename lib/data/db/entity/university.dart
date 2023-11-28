/* import 'package:floor/floor.dart';

@entity */
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
      this.imageUrl,
      this.phone,
      this.site});
  // @PrimaryKey(autoGenerate: true)
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
  String? imageUrl;

  String get fullAddress =>
      '${region ?? ''} область, ${city ?? ''}, ${address ?? ''}';
  @override
  String toString() {
    return '$id $name $city';
  }

  University.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        shortName = json['shortName'] as String?,
        city = json['city'] as String?,
        region = json['region'] as String?,
        lat = json['lat'] as double?,
        lng = json['lng'] as double?,
        studentsCount = json['studentsCount'] as int?,
        year = json['year'] as int?,
        rankingPosition = json['rankingPosition'] as int?,
        rating = json['rating'] as double?,
        address = json['address'] as String?,
        phone = json['phone'] as String?,
        site = json['site'] as String?,
        email = json['email'] as String?,
        imageUrl = json['imageUrl'] as String?;
/* 
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      }; */
}
