import 'package:auto_size_text/auto_size_text.dart';
import 'package:dyplom/data/db/entity/university.dart';
import 'package:dyplom/screens/university.dart';
import 'package:flutter/material.dart';

import '../util/search_util.dart';

class UniversitiesListPage extends StatefulWidget {
  const UniversitiesListPage({Key? key, required this.universities})
      : super(key: key);

  final List<University> universities;
  @override
  State<StatefulWidget> createState() {
    return _UnversitiesListState();
  }
}

const _addressTextStyle = TextStyle(color: Colors.black54, fontSize: 14);

class _UnversitiesListState extends State<UniversitiesListPage> {
  List<University> universities = [];
  List<University>? filteredUniversities;
  final _searchController = TextEditingController();

  @override
  void initState() {
    _initList();
    super.initState();
  }

  void _initList() {
    universities = widget.universities;
    setState(() {});
  }

  void _onSearch(String value) {
    filteredUniversities ??= [];
    filteredUniversities!.clear();
    for (var univer in universities) {
      if (SearchUtil.contains(univer, value)) {
        filteredUniversities?.add(univer);
      }
    }
    setState(() {});
  }

  void _openUniversityPage(University university) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UniversityPage(
          university: university,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: _onSearch,
                      decoration: const InputDecoration(hintText: '??????????...'),
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
            ),
            Expanded(
              child: ListView.separated(
                itemCount: (filteredUniversities ?? universities).length,
                itemBuilder: (_, i) {
                  return _UniversityItem(
                    university: (filteredUniversities ?? universities)[i],
                    onPressed: _openUniversityPage,
                  );
                },
                separatorBuilder: (_, i) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Divider(
                      height: 1,
                      color: Colors.black54,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UniversityItem extends StatelessWidget {
  final University university;

  final Function(University university) onPressed;
  const _UniversityItem(
      {Key? key, required this.university, required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(university),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    color: Colors.blue[400], shape: BoxShape.circle),
                child: Center(
                  child: AutoSizeText(
                    university.rankingPosition.toString(),
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                university.shortName ?? '',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            university.fullAddress,
            style: _addressTextStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
