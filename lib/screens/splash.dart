import 'dart:async';

import 'package:dyplom/data/all_data.dart';
import 'package:dyplom/data/db/entity/university.dart';
import 'package:dyplom/data/firestore/firestore_repo.dart';
import 'package:dyplom/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  bool _universitiesInited = false;
  bool _threeSecondsPassed = false;
  List<University>? _universities;

  @override
  void initState() {
    _initUniversities();
    Timer(const Duration(seconds: 3), () {
      _threeSecondsPassed = true;
      if (_universitiesInited) {
        Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
                builder: (context) => Home(
                      universities: _universities!,
                    )));
      } else {}
    });
    super.initState();
  }

  Future<void> _initUniversities() async {
    _universities = await FirestoreRepo().fetchAllUniversities();
    _universitiesInited = true;
    if (_threeSecondsPassed) {
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              builder: (context) => Home(
                    universities: _universities!,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'VNZ\nCHOISE\nHELPER',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
