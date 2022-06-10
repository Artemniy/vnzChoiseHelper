import 'package:dyplom/data/db/entity/university.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class MapUtil {
  static Marker getMarker(University university, Function() onTap) {
    return Marker(
        rotate: true,
        point: LatLng(university.lat!, university.lng!),
        builder: (context) {
          return GestureDetector(
            onTap: onTap,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Icon(
                    Icons.location_on_rounded,
                    size: 30,
                    color: Colors.blue[400],
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      color: Colors.blue[400], shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      university.rankingPosition.toString(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
