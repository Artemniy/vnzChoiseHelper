import 'package:dyplom/screens/splash.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}


/* 
 final database = await $FloorAppDatabase.databaseBuilder('database').build();

  final universityDao = database.universityDao;
  /* universityDao
      .insertUnivercity(University(name: 'TestName', city: 'TestCity'));
  final list = await universityDao.findAllUniversities();

  log((list.toString()));
 */ */