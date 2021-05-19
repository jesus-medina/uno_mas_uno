import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uno_mas_uno/data/datasource/person_remote_datasource.dart';
import 'package:uno_mas_uno/data/person_data.dart';
import 'package:uno_mas_uno/presentation/ui/person_ui.dart';
import 'package:uno_mas_uno/presentation/ui/widget/person_form.dart';

class AddPersonDialog extends StatefulWidget {
  @override
  AddPersonDialogState createState() => AddPersonDialogState();
}

class AddPersonDialogState extends State<AddPersonDialog> {
  final PersonRemoteDataSource _personRemoteDataSource =
      PersonRemoteDataSource(FirebaseFirestore.instance);
  final GlobalKey<FormState> _personGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva persona'),
        actions: [
          TextButton(
              onPressed: () {
                if (_personGlobalKey.currentState.validate()) {
                  _personGlobalKey.currentState.save();
                }
              },
              child: Text('AGREGAR',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.white))),
        ],
      ),
      body: StreamBuilder<List<DataPerson>>(
        stream: _personRemoteDataSource.getPeople(),
        builder: (context, snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return Text('');
          }
          List<PersonUI> people = snapshot.data
              .map((dataPerson) => PersonUI.fromDataPerson(dataPerson))
              .toList();

          return PersonForm(_personGlobalKey, people, this.onPersonSaved);
        },
      ),
    );
  }

  onPersonSaved(PersonUI personUI) async {
    var personUIMap = personUI.toMap();
    var dataPerson = DataPerson.fromMap(personUI.id, personUIMap);
    var personDocSnapshot = await _personRemoteDataSource.addPerson(dataPerson);
    if (personDocSnapshot.exists) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Hemos sumado uno más!')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Parece que no hemos podido agregar la persona')));
    }
  }
}
