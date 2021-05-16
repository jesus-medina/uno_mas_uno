import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uno_mas_uno/data/person_data.dart';

class PersonRemoteDataSource {
  final FirebaseFirestore firestore;

  PersonRemoteDataSource(this.firestore);

  Stream<List<DataPerson>> getPeople() {
    return firestore.collection('people').snapshots().map((event) =>
        event.docs.map((e) => DataPerson.fromMap(e.data())).toList());
  }
}
