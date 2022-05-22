import 'package:dyplom/data/all_data.dart';
import 'package:dyplom/data/db/entity/university.dart';
import 'package:flutter/material.dart';

class UniversitiesListPage extends StatefulWidget {
  const UniversitiesListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UnversitiesListState();
  }
}

class _UnversitiesListState extends State<UniversitiesListPage> {
  List<University> universities = [];

  @override
  void initState() {
    _initList();
    super.initState();
  }

  Future<void> _initList() async {
    universities = await AllData().getUniversities();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: universities.length,
          itemBuilder: (context, i) {
            return Text(universities[i].toString());
          }),
    );
  }
}
