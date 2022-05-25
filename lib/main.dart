
import 'package:dyplom/screens/splash.dart';
import 'package:flutter/material.dart';

import 'data/db/db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('database').build();

  final universityDao = database.universityDao;
  /* universityDao
      .insertUnivercity(University(name: 'TestName', city: 'TestCity'));
  final list = await universityDao.findAllUniversities();

  log((list.toString()));
 */
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
