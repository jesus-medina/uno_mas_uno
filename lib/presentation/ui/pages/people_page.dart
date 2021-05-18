import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uno_mas_uno/data/datasource/person_remote_datasource.dart';
import 'package:uno_mas_uno/data/person_data.dart';
import 'package:uno_mas_uno/presentation/ui/dialog/add_person_dialog.dart';
import 'package:uno_mas_uno/presentation/ui/person_ui.dart';
import 'package:uno_mas_uno/presentation/ui/widget/person_card.dart';

class PeoplePage extends StatelessWidget {
  final PersonRemoteDataSource _personRemoteDataSource =
      PersonRemoteDataSource(FirebaseFirestore.instance);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<List<DataPerson>>(
          stream: this._personRemoteDataSource.getPeople(),
          builder: (context, snapshot) {
            if (snapshot.hasError || !snapshot.hasData) {
              return Text('');
            }
            List<DataPerson> dataPeople = snapshot.data;

            return ListView.separated(
                itemBuilder: (_, index) {
                  PersonUI personUI = PersonUI.fromDataPerson(dataPeople[index]);

                  return PersonCard(personUI);
                },
                separatorBuilder: (_, index) => Divider(),
                itemCount: dataPeople.length);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(new MaterialPageRoute<Null>(
                builder: (BuildContext context) => AddPersonDialog(),
                fullscreenDialog: true));
          },
          child: const Icon(Icons.group_add),
        ),
      );
}
