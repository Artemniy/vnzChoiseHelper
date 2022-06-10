import 'package:dyplom/components/map_place_preview.dart';
import 'package:dyplom/screens/university.dart';
import 'package:dyplom/util/map_util.dart';
import 'package:dyplom/util/search_util.dart';
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
  Map<Marker, University>? filteredUniversities;
  final _focus = FocusNode();
  final _searchController = TextEditingController();
  bool searching = false;
  LatLng _currentCenter = LatLng(50.4488698641019, 30.51429407529177);
  final _mapController = MapController();
  University? _selectedUniversity;

  @override
  void initState() {
    _initList();
    _focus.addListener(_onFocusChange);

    super.initState();
  }

  void _onFocusChange() {
    searching = _focus.hasFocus;
  }

  void _clearSelectedUniversity() {
    setState(() {
      _selectedUniversity = null;
    });
  }

  void _onMarkerTap(University university) {
    setState(() {
      _selectedUniversity = university;
    });
  }

  void _onDetailsTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UniversityPage(university: _selectedUniversity!)));
  }

  Future<void> _initList() async {
    universities = await AllData().getUniversities();
    for (var item in universities) {
      markers.add(MapUtil.getMarker(item, () => _onMarkerTap(item)));
    }
    setState(() {});
  }

  void _onSearch(String value) {
    searching = true;
    filteredUniversities ??= {};
    filteredUniversities!.clear();
    for (var univer in universities) {
      if (SearchUtil.contains(univer, value)) {
        filteredUniversities?[
            MapUtil.getMarker(univer, () => _onMarkerTap(univer))] = univer;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                onPositionChanged: (position, hasGesture) {
                  _currentCenter = position.center ??
                      LatLng(50.4488698641019, 30.51429407529177);
                },
                center: _currentCenter,
                zoom: 6,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                  attributionBuilder: (_) {
                    return const Text('');
                  },
                ),
                MarkerLayerOptions(
                  markers: filteredUniversities?.keys.toList() ?? markers,
                ),
              ],
            ),
            Positioned(
              right: 10,
              top: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    color: Colors.black12,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _mapController.move(
                            _currentCenter, _mapController.zoom + 1);
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.black12,
                    width: 35,
                    height: 35,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        _mapController.move(
                            _currentCenter, _mapController.zoom - 1);
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.only(bottom: 5),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: _onSearch,
                            decoration:
                                const InputDecoration(hintText: 'Пошук...'),
                          ),
                        ),
                        Visibility(
                          visible: _searchController.text.isNotEmpty,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  _searchController.clear();
                                  filteredUniversities = null;
                                });
                              },
                              icon: const Icon(Icons.clear)),
                        ),
                        IconButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            icon: const Icon(Icons.search)),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: searching,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.65),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: filteredUniversities?.length ?? 0,
                            itemBuilder: (_, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            filteredUniversities!.values
                                                    .toList()[index]
                                                    .shortName ??
                                                '',
                                            style: const TextStyle(
                                                color: Colors.black87),
                                          ),
                                          Text(
                                            filteredUniversities!.values
                                                    .toList()[index]
                                                    .city ??
                                                '',
                                            style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: MapPlacePreview(
                onCloseTap: _clearSelectedUniversity,
                university: _selectedUniversity,
                onDetailsTap: _onDetailsTap,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }
}
