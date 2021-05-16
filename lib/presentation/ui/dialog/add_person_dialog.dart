import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uno_mas_uno/presentation/ui/widget/person_form.dart';

class AddPersonDialog extends StatefulWidget {
  @override
  AddPersonDialogState createState() => AddPersonDialogState();
}

class AddPersonDialogState extends State<AddPersonDialog> {
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
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('AGREGAR',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.white))),
        ],
      ),
      body: PersonForm(_personGlobalKey),
    );
  }
}
