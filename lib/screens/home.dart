import 'package:dyplom/data/db/entity/university.dart';
import 'package:dyplom/screens/list.dart';
import 'package:flutter/material.dart';

import 'map.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.universities}) : super(key: key);
  final List<University> universities;

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var _currentPage = 0;
  late final _pages = [
    MapPage(universities: widget.universities),
    UniversitiesListPage(
      universities: widget.universities,
      key: const ValueKey(0),
    ),
    UniversitiesListPage(
      key: const ValueKey(1),
      universities: widget.universities,
      favourites: true,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.orange,
          currentIndex: _currentPage,
          onTap: (value) => setState(() => _currentPage = value),
          items: const [
            BottomNavigationBarItem(
              label: 'Карта',
              icon: Icon(Icons.map_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Список',
              icon: Icon(Icons.list_alt),
            ),
            BottomNavigationBarItem(
              label: 'Обране',
              icon: Icon(Icons.star_outline),
            ),
          ]),
    );
  }
}
