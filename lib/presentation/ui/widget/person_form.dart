import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:uno_mas_uno/presentation/ui/person_ui.dart';

class PersonForm extends StatefulWidget {
  final GlobalKey<FormState> _personGlobalKey;
  final List<PersonUI> _people;
  final void Function(PersonUI personUI) _onPersonSaved;

  PersonForm(this._personGlobalKey, this._people, this._onPersonSaved);

  @override
  PersonFormState createState() =>
      PersonFormState(this._personGlobalKey, this._people, this._onPersonSaved);
}

class PersonFormState extends State<PersonForm> {
  final GlobalKey<FormState> _personGlobalKey;
  final List<PersonUI> _people;
  final void Function(PersonUI personUI) _onPersonSaved;

  PersonFormState(this._personGlobalKey, this._people, this._onPersonSaved);

  bool _hasSpiritualGuide = true;

  String _spiritualGuideId = '';
  String _firstName = '';
  String _lastName = '';
  String _gender = 'male';
  DateTime _birthday = DateTime.now();
  String _phoneNumber = '';
  String _email = '';
  String _address = '';

  bool _isSaving = false;

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
                  FormField(
                    builder: (state) {
                      return Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable<String>.empty();
                          }
                          return _people
                              .where((PersonUI option) {
                                return option.fullName.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase());
                              })
                              .map((e) => e.fullName)
                              .toList();
                        },
                        onSelected: (String selection) {
                          state.didChange(selection.toLowerCase());
                        },
                      );
                    },
                    onSaved: (value) {
                      _isSaving = true;
                      setState(() {
                        _spiritualGuideId = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Nombre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '¿Cómo se llama la persona?';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _firstName = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Apellidos'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '¿Cuáles son los apellidos de la persona?';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _lastName = value;
                      });
                    },
                  ),
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
                    onSaved: (value) {
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
                    onDateSaved: (value) {
                      setState(() {
                        _birthday = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Número de teléfono'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Compártenos su número de teléfono';
                      }
                      if (value.toString().length != 10) {
                        return 'Quizás faltan algunos números...';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(10,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced)
                    ],
                    onSaved: (value) {
                      setState(() {
                        _phoneNumber = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Correo electrónico'),
                    validator: (value) => EmailValidator.validate(value)
                        ? null
                        : 'Quizás el correo esté incompleto...',
                    onSaved: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Dirección'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Permitenos saber su dirección';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _isSaving = false;
                      setState(() {
                        _address = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    if (!_isSaving) {
      var firstName = _firstName;
      var lastName = _lastName;
      var gender = _personGenderUIFrom(_gender);
      var email = _email;
      var phoneNumber = _phoneNumber;
      var address = _address;
      var personContact = PersonContactUI(email, phoneNumber, address);
      var birthday = _createBirthdayDateFrom(_birthday);
      var spiritualGuideId = _spiritualGuideId;

      var personUI = PersonUI(
          firstName, lastName, gender, personContact, birthday,
          spiritualGuideId: spiritualGuideId);
      _onPersonSaved(personUI);
    }
  }

  _personGenderUIFrom(String gender) =>
      gender == 'male' ? PersonGenderUI.Male : PersonGenderUI.Female;

  _createBirthdayDateFrom(DateTime birthday) {
    var year = birthday.year;
    var month = birthday.month;
    var day = birthday.day;

    return '$year-$month-$day';
  }
}
