import 'package:dyplom/screens/list.dart';
import 'package:flutter/material.dart';

import 'map.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  var _currentPage = 0;
  static const _pages = [
    MapPage(),
    UniversitiesListPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
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
          ]),
    );
  }
}
