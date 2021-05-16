import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uno_mas_uno/presentation/ui/person_ui.dart';

class PersonCard extends StatelessWidget {
  final PersonUI _personUI;

  PersonCard(this._personUI);

  @override
  Widget build(BuildContext context) => ExpansionTile(
        leading: CircleAvatar(child: Text(_personUI.acronym)),
        title: Text(_personUI.fullName),
        subtitle: Text(_personUI.birthday),
        children: [
          ListTile(
            title: Text("${_personUI.personContact.address}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${_personUI.personContact.phoneNumber}"),
                Text("${_personUI.personContact.email}")
              ],
            ),
          )
        ],
      );
}
