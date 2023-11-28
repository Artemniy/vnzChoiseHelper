import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyplom/data/db/entity/university.dart';

class FirestoreRepo {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<University>> fetchAllUniversities() async {
    final col = firestore.collection('universities');
    final result = await col.get();
    final docs = result.docs;
    List<University> universities = [];
    for (final doc in docs) {
      universities.add(University.fromJson(doc.data()));
    }
    universities
        .sort((a, b) => a.rankingPosition!.compareTo(b.rankingPosition!));
    return universities;
  }
}
