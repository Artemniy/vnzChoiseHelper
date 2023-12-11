import 'package:auto_size_text/auto_size_text.dart';
import 'package:dyplom/data/db/entity/university.dart';
import 'package:dyplom/screens/university.dart';
import 'package:dyplom/util/hive_util.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import '../util/search_util.dart';

class UniversitiesListPage extends StatefulWidget {
  const UniversitiesListPage(
      {Key? key, required this.universities, this.favourites = false})
      : super(key: key);
  final bool favourites;
  final List<University> universities;
  @override
  State<StatefulWidget> createState() {
    return _UnversitiesListState();
  }
}

const _addressTextStyle = TextStyle(color: Colors.black54, fontSize: 14);

const byRanking = 'За рейтингом';
const byGmapsRate = 'За оцінкою';
const byStudents = 'За кількістю студентів';
const byYear = 'За роком заснування';

const sortValues = [byRanking, byGmapsRate, byStudents, byYear];

const ascending = 'По зростанню';
const descending = 'По спаданню';
const orderValues = [ascending, descending];

class _UnversitiesListState extends State<UniversitiesListPage> {
  List<University> universities = [];
  List<University>? filteredUniversities;
  final _searchController = TextEditingController();
  String? _sortValue = sortValues[0];
  String? _orderValue = orderValues[0];

  @override
  void initState() {
    _initList();
    super.initState();
  }

  Future<void> _initList() async {
    final favIdList = await HiveUtil.getFavouriteUniversities();
    if (widget.favourites) {
      List<University> allUniversities = List.from(widget.universities);
      universities = [];
      for (var fav in favIdList) {
        final uni = allUniversities.firstWhereOrNull((e) => e.id == fav);
        uni?.favourite = true;
        if (uni != null) universities.add(uni);
      }
      setState(() {});
    } else {
      universities = List.from(widget.universities);
      for (var fav in favIdList) {
        final uni = universities.firstWhereOrNull((e) => e.id == fav);
        uni?.favourite = true;
      }
      setState(() {});
    }
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

  void _onFilterValuesChanged() {
    switch (_sortValue) {
      case byGmapsRate:
        universities.sort((a, b) => (a.rating ?? 0).compareTo(b.rating ?? 0));
        break;
      case byRanking:
        universities.sort((a, b) =>
            (a.rankingPosition ?? 0).compareTo(b.rankingPosition ?? 0));
        break;
      case byStudents:
        universities.sort(
            (a, b) => (a.studentsCount ?? 0).compareTo(b.studentsCount ?? 0));
        break;
      case byYear:
        universities.sort((a, b) => (a.year ?? 0).compareTo(b.year ?? 0));
        break;
      default:
        break;
    }
    if (_orderValue == descending) {
      universities = List.from(universities.reversed);
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: _onSearch,
                      decoration: const InputDecoration(hintText: 'Пошук...'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String?>(
                    items: sortValues
                        .map((e) => DropdownMenuItem<String?>(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    value: _sortValue,
                    onChanged: (value) {
                      if (value == null) return;

                      _sortValue = value;

                      _onFilterValuesChanged();
                    }),
                DropdownButton<String?>(
                    items: orderValues
                        .map((e) => DropdownMenuItem<String?>(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    value: _orderValue,
                    onChanged: (value) {
                      if (value == null) return;

                      _orderValue = value;
                      _onFilterValuesChanged();
                    }),
              ],
            ),
            Expanded(
              child: widget.universities.isEmpty
                  ? const Center(child: Text('Нема даних'))
                  : ListView.separated(
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

class _UniversityItem extends StatefulWidget {
  final University university;

  final Function(University university) onPressed;
  const _UniversityItem(
      {Key? key, required this.university, required this.onPressed})
      : super(key: key);

  @override
  State<_UniversityItem> createState() => _UniversityItemState();
}

class _UniversityItemState extends State<_UniversityItem> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => widget.onPressed(widget.university),
      child: Row(
        children: [
          Expanded(
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
                          widget.university.rankingPosition.toString(),
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
                      widget.university.shortName ?? '',
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
                  widget.university.fullAddress,
                  style: _addressTextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                widget.university.favourite =
                    !(widget.university.favourite ?? false);
                if (widget.university.id == null) return;

                if (widget.university.favourite ?? false) {
                  HiveUtil.setFavouriteUniversity(widget.university.id!);
                } else {
                  HiveUtil.removeFavouriteUniversity(widget.university.id!);
                }
              });
            },
            icon: Icon(
              widget.university.favourite ?? false
                  ? Icons.star
                  : Icons.star_border,
              color: widget.university.favourite ?? false
                  ? Colors.amber
                  : Colors.black26,
            ),
          )
        ],
      ),
    );
  }
}
