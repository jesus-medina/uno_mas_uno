import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:uno_mas_uno/data/datasource/person_remote_datasource.dart';
import 'package:uno_mas_uno/data/person_data.dart';
import 'package:uno_mas_uno/presentation/ui/person_ui.dart';

class PersonCard extends StatelessWidget {
  final PersonRemoteDataSource _personRemoteDataSource =
      PersonRemoteDataSource(FirebaseFirestore.instance);

  final PersonUI _personUI;

  PersonCard(this._personUI);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DataPerson>(
        future: _personRemoteDataSource.getPersonBy(_personUI.spiritualGuideId),
        builder: (context, snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          DataPerson spiritualGuideDataPerson = snapshot.data;
          PersonUI spiritualGuide =
              PersonUI.fromDataPerson(spiritualGuideDataPerson);

          return Slidable(
            child: ExpansionTile(
              leading: CircleAvatar(child: Text(_personUI.acronym)),
              title: Text(_personUI.fullName),
              subtitle: Text(_personUI.birthday),
              children: [
                ListTile(
                  title: Text('${_personUI.personContact.address}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${_personUI.personContact.phoneNumber}'),
                      Text('${_personUI.personContact.email}'),
                      Text('${_personUI.spiritualGuideId}'),
                    ],
                  ),
                )
              ],
            ),
            actionPane: SlidableDrawerActionPane(),
            actions: [
              ListTile(
                tileColor: Theme.of(context).primaryColor,
                title: Text(
                  spiritualGuide.firstName,
                  style:
                      TextStyle(color: Theme.of(context).secondaryHeaderColor),
                ),
                subtitle: Text(
                  spiritualGuide.lastName,
                  style:
                      TextStyle(color: Theme.of(context).secondaryHeaderColor),
                ),
              ),
            ],
          );
        });
  }
}
