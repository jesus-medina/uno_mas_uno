import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:uno_mas_uno/data/person_data.dart';
import 'package:uno_mas_uno/presentation/ui/person_ui.dart';

class PersonForm extends StatefulWidget {
  final GlobalKey<FormState> _personGlobalKey;
  final List<PersonUI> _people;

  PersonForm(this._personGlobalKey, this._people);

  @override
  PersonFormState createState() =>
      PersonFormState(this._personGlobalKey, this._people);
}

class PersonFormState extends State<PersonForm> {
  final GlobalKey<FormState> _personGlobalKey;
  final List<PersonUI> _people;

  PersonFormState(this._personGlobalKey, this._people);

  String _gender = 'male';

  bool _hasSpiritualGuide = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Text('Tiene padre espiritual'),
                Switch(
                    value: _hasSpiritualGuide,
                    onChanged: (value) {
                      setState(() {
                        _hasSpiritualGuide = value;
                      });
                    })
              ],
            ),
            Form(
              key: _personGlobalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return _people
                          .where((PersonUI option) {
                            return option.fullName
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase());
                          })
                          .map((e) => e.fullName)
                          .toList();
                    },
                    onSelected: (String selection) {
                      print('You just selected $selection');
                    },
                  ),
                  textFormField('Nombre', (value) {
                    if (value == null || value.isEmpty) {
                      return '¿Cómo se llama la persona?';
                    }
                    return null;
                  }),
                  textFormField('Apellidos', (value) {
                    if (value == null || value.isEmpty) {
                      return '¿Cuáles son los apellidos de la persona?';
                    }
                    return null;
                  }),
                  DropdownButtonFormField(
                    items: [
                      DropdownMenuItem<String>(
                          value: 'male', child: Text('Hombre')),
                      DropdownMenuItem<String>(
                          value: 'female', child: Text('Mujer')),
                    ],
                    value: _gender,
                    validator: (v) =>
                        v == null ? 'Permitenos saber tu género' : null,
                    onChanged: (value) async {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                  InputDatePickerFormField(
                    firstDate: DateTime.fromMillisecondsSinceEpoch(
                        DateTime.now().millisecondsSinceEpoch - 6307200000000),
                    lastDate: DateTime.now(),
                    initialDate: DateTime.now(),
                    errorFormatText: 'Esta fecha es confusa de leer',
                    errorInvalidText: 'No reconozco esta fecha',
                  ),
                  textFormField('Número de teléfono', (value) {
                    if (value == null || value.isEmpty) {
                      return 'Compártenos su número de teléfono';
                    }
                    if (value.toString().length != 10) {
                      return 'Quizás faltan algunos números...';
                    }
                    return null;
                  }, inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(10,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced)
                  ]),
                  textFormField(
                    'Correo electrónico',
                    (value) => EmailValidator.validate(value)
                        ? null
                        : 'Quizás el correo esté incompleto...',
                  ),
                  textFormField('Dirección', (value) {
                    if (value == null || value.isEmpty) {
                      return 'Permitenos saber su dirección';
                    }
                    return null;
                  }),
                ],
              ),
            ),
          ],
        ));
  }

  Widget textFormField(String hintText, Function validator,
          {List<TextInputFormatter> inputFormatters}) =>
      TextFormField(
        decoration: InputDecoration(hintText: hintText),
        validator: validator,
        inputFormatters: inputFormatters,
      );
}
