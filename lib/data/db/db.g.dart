// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UniversityDao? _universityDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `University` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `shortName` TEXT, `city` TEXT, `region` TEXT, `lat` REAL, `lng` REAL, `studentsCount` INTEGER, `year` INTEGER, `rankingPosition` INTEGER, `rating` REAL, `employedGraduatesCount` INTEGER, `listedAbroad` INTEGER, `facultiesList` TEXT, `type` TEXT)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UniversityDao get universityDao {
    return _universityDaoInstance ??= _$UniversityDao(database, changeListener);
  }
}

class _$UniversityDao extends UniversityDao {
  _$UniversityDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _universityInsertionAdapter = InsertionAdapter(
            database,
            'University',
            (University item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'shortName': item.shortName,
                  'city': item.city,
                  'region': item.region,
                  'lat': item.lat,
                  'lng': item.lng,
                  'studentsCount': item.studentsCount,
                  'year': item.year,
                  'rankingPosition': item.rankingPosition,
                  'rating': item.rating,
                  'employedGraduatesCount': item.employedGraduatesCount,
                  'listedAbroad': item.listedAbroad == null
                      ? null
                      : (item.listedAbroad! ? 1 : 0),
                  'facultiesList': item.facultiesList,
                  'type': item.type
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<University> _universityInsertionAdapter;

  @override
  Future<List<University>> findAllUniversities() async {
    return _queryAdapter.queryList('SELECT * FROM university',
        mapper: (Map<String, Object?> row) => University(
            id: row['id'] as int?,
            name: row['name'] as String?,
            shortName: row['shortName'] as String?,
            city: row['city'] as String?,
            region: row['region'] as String?,
            lat: row['lat'] as double?,
            lng: row['lng'] as double?,
            studentsCount: row['studentsCount'] as int?,
            year: row['year'] as int?,
            rankingPosition: row['rankingPosition'] as int?,
            rating: row['rating'] as double?,
            employedGraduatesCount: row['employedGraduatesCount'] as int?,
            listedAbroad: row['listedAbroad'] == null
                ? null
                : (row['listedAbroad'] as int) != 0,
            facultiesList: row['facultiesList'] as String?,
            type: row['type'] as String?));
  }

  @override
  Stream<University?> findUnivercityById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM university WHERE id = ?1',
        mapper: (Map<String, Object?> row) => University(
            id: row['id'] as int?,
            name: row['name'] as String?,
            shortName: row['shortName'] as String?,
            city: row['city'] as String?,
            region: row['region'] as String?,
            lat: row['lat'] as double?,
            lng: row['lng'] as double?,
            studentsCount: row['studentsCount'] as int?,
            year: row['year'] as int?,
            rankingPosition: row['rankingPosition'] as int?,
            rating: row['rating'] as double?,
            employedGraduatesCount: row['employedGraduatesCount'] as int?,
            listedAbroad: row['listedAbroad'] == null
                ? null
                : (row['listedAbroad'] as int) != 0,
            facultiesList: row['facultiesList'] as String?,
            type: row['type'] as String?),
        arguments: [id],
        queryableName: 'University',
        isView: false);
  }

  @override
  Future<void> insertUnivercity(University university) async {
    await _universityInsertionAdapter.insert(
        university, OnConflictStrategy.abort);
  }
}
