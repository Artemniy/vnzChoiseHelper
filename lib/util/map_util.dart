import 'package:dyplom/data/db/entity/university.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class MapUtil {
  static Marker getMarker(University university) {
    return Marker(
        rotate: true,
        point: LatLng(university.lat!, university.lng!),
        builder: (context) {
          return const Icon(Icons.location_on_rounded);
        });
  }
}
