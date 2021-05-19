import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uno_mas_uno/data/person_data.dart';

class PersonRemoteDataSource {
  final FirebaseFirestore _firestore;

  PersonRemoteDataSource(this._firestore);

  Stream<List<DataPerson>> getPeople() {
    return _firestore.collection('people').snapshots().map((querySnapshot) =>
        querySnapshot.docs
            .where((element) {
              if (element.data().keys.contains('active')) {
                return element.data()['active'];
              }

              return false;
            })
            .map((queryDocumentSnapshot) {
          var id = queryDocumentSnapshot.id;
          var dataPersonMap = queryDocumentSnapshot.data();

          return DataPerson.fromMap(id, dataPersonMap);
        }).toList());
  }

  Future<DataPerson> getPersonBy(String personId) async {
    var personDoc = await _firestore.collection('people').doc(personId).get();

    return DataPerson.fromMap(personDoc.id, personDoc.data());
  }

  Future<DocumentSnapshot<dynamic>> addPerson(DataPerson dataPerson) async {
    var dataPersonMap = dataPerson.toMap();
    if (dataPersonMap.keys.contains('id')) {
      dataPersonMap.remove('id');
      dataPersonMap['active'] = true;
    }
    var documentRef = await _firestore.collection('people').add(dataPersonMap);

    return documentRef.get();
  }

  Future<void> hidePersonById(String personId) =>
      _firestore.collection('people').doc(personId).update({'active': false});
}
