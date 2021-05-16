import 'package:uno_mas_uno/data/person_data.dart';

class PersonUI {
  final String _firstName;
  final String _lastName;
  final PersonGenderUI gender;
  final PersonContactUI personContact;
  final String birthday;

  PersonUI(this._firstName, this._lastName, this.gender, this.personContact,
      this.birthday);

  String get fullName => "$_firstName $_lastName";

  String get acronym =>
      "${_firstName.substring(0, 1)}${_lastName.substring(0, 1)}";

  factory PersonUI.fromDataPerson(DataPerson dataPerson) {
    final firstName = dataPerson.firstName;
    final lastName = dataPerson.lastName;
    PersonGenderUI gender = PersonGenderUI.NonSpecified;
    switch (dataPerson.gender) {
      case 'male':
        gender = PersonGenderUI.Male;
        break;
      case 'famale':
        gender = PersonGenderUI.Female;
        break;
    }
    final email = dataPerson.email;
    final phoneNumber = dataPerson.phoneNumber;
    final address = dataPerson.address;
    final PersonContactUI personContact =
        PersonContactUI(email, phoneNumber, address);
    final birthday = dataPerson.birthday;

    return PersonUI(firstName, lastName, gender, personContact, birthday);
  }
}

enum PersonGenderUI { Male, Female, NonSpecified }

class PersonContactUI {
  final String email;
  final String phoneNumber;
  final String address;

  PersonContactUI(this.email, this.phoneNumber, this.address);
}
