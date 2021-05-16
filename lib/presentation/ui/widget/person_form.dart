import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class PersonForm extends StatefulWidget {
  final GlobalKey<FormState> personGlobalKey;

  PersonForm(this.personGlobalKey);

  @override
  PersonFormState createState() => PersonFormState(this.personGlobalKey);
}

class PersonFormState extends State<PersonForm> {
  final GlobalKey<FormState> personGlobalKey;

  PersonFormState(this.personGlobalKey);

  String gender = 'hombre';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Form(
        key: personGlobalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                    value: 'hombre', child: Text('Hombre')),
                DropdownMenuItem<String>(value: 'mujer', child: Text('Mujer')),
              ],
              value: gender,
              validator: (v) => v == null ? 'Permitenos saber tu género' : null,
              onChanged: (value) async {
                setState(() {
                  gender = value;
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
    );
  }

  Widget textFormField(String hintText, Function validator,
          {List<TextInputFormatter> inputFormatters}) =>
      TextFormField(
        decoration: InputDecoration(hintText: hintText),
        validator: validator,
        inputFormatters: inputFormatters,
      );
}
