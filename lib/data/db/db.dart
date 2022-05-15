import 'package:dyplom/data/db/dao/university_dao.dart';
import 'package:dyplom/data/db/entity/university.dart';
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'db.g.dart'; 

@Database(version: 1, entities: [University])
abstract class AppDatabase extends FloorDatabase {
  UniversityDao get universityDao;
}