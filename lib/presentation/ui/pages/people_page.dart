import 'package:flutter/material.dart';
import 'package:uno_mas_uno/presentation/ui/dialog/add_person_dialog.dart';
import 'package:uno_mas_uno/presentation/ui/person_ui.dart';
import 'package:uno_mas_uno/presentation/ui/widget/person_card.dart';

class PeoplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: ListView.separated(
            itemBuilder: (_, index) => PersonCard(PersonUI(
                "Jesús Daniel",
                "Medina Cruz",
                PersonGenderUI.NonSpecified,
                PersonContactUI("jesus.daniel.medina.cruz@gmail.com",
                    "6631036365", "De los Geranios"),
                "8/11/1996")),
            separatorBuilder: (_, index) => Divider(),
            itemCount: 100),
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
