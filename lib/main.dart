import 'package:dyplom/firebase_options.dart';
import 'package:dyplom/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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