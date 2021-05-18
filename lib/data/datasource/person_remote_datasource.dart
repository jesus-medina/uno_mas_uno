import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uno_mas_uno/data/person_data.dart';

class PersonRemoteDataSource {
  final FirebaseFirestore _firestore;

  PersonRemoteDataSource(this._firestore);

  Stream<List<DataPerson>> getPeople() {
    return _firestore.collection('people').snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .map((queryDocumentSnapshot) =>
                DataPerson.fromMap(queryDocumentSnapshot.data()))
            .toList());
  }

  Future<DataPerson> getPersonBy(String personId) async {
    var personDoc = await _firestore.collection('people').doc(personId).get();
    return DataPerson.fromMap(personDoc.data());
  }
}
