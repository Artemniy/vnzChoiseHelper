

import 'package:floor/floor.dart';

import '../entity/university.dart';

@dao
abstract class UniversityDao {

  @Query('SELECT * FROM university')
  Future<List<University>> findAllUniversities();

  @Query('SELECT * FROM university WHERE id = :id')
  Stream<University?> findUnivercityById(int id);

  @insert
  Future<void> insertUnivercity(University university);
}