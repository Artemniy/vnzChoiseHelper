import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

import '../data/all_data.dart';
import '../data/db/entity/university.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MapPageState();
  }
}

class _MapPageState extends State<MapPage> {
  List<University> universities = [];
  List<Marker> markers = [];
  @override
  void initState() {
    _initList();
    super.initState();
  }

  Future<void> _initList() async {
    universities = await AllData().getUniversities();
    for (var item in universities) {
      markers.add(Marker(
        rotate: true,
        point: LatLng(item.lat!, item.lng!), builder: (context){
        return const Icon(Icons.location_on_rounded);
      }));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: LatLng(50.4488698641019, 30.51429407529177),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
              attributionBuilder: (_) {
                return const Text('');
              },
            ),
            MarkerLayerOptions(
              markers: markers,
            ),
          ],
        )
      ],
    );
  }
}
