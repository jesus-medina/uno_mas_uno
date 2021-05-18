import 'package:uno_mas_uno/data/person_data.dart';

class PersonUI {
  final String firstName;
  final String lastName;
  final PersonGenderUI gender;
  final PersonContactUI personContact;
  final String birthday;
  final String spiritualGuideId;

  PersonUI(this.firstName, this.lastName, this.gender, this.personContact,
      this.birthday,
      {this.spiritualGuideId});

  String get fullName => "$firstName $lastName";

  String get acronym =>
      "${firstName.substring(0, 1)}${lastName.substring(0, 1)}";

  factory PersonUI.fromDataPerson(DataPerson dataPerson) {
    final firstName = dataPerson.firstName;
    final lastName = dataPerson.lastName;
    PersonGenderUI gender = PersonGenderUI.NonSpecified;
    switch (dataPerson.gender) {
      case 'male':
        gender = PersonGenderUI.Male;
        break;
      case 'female':
        gender = PersonGenderUI.Female;
        break;
    }
    final email = dataPerson.email;
    final phoneNumber = dataPerson.phoneNumber;
    final address = dataPerson.address;
    final PersonContactUI personContact =
        PersonContactUI(email, phoneNumber, address);
    final birthday = dataPerson.birthday;
    final spiritualGuideId = dataPerson.spiritualGuideId;

    return PersonUI(firstName, lastName, gender, personContact, birthday,
        spiritualGuideId: spiritualGuideId);
  }

  Map<String, dynamic> toMap() => {
        'first name': firstName,
        'last name': lastName,
        'gender': gender == PersonGenderUI.Male ? 'male' : 'female',
        'email': personContact.email,
        'phone number': personContact.phoneNumber,
        'address': personContact.address,
        'birthday': birthday,
        'spiritual guide id': spiritualGuideId,
      };
}

enum PersonGenderUI { Male, Female, NonSpecified }

class PersonContactUI {
  final String email;
  final String phoneNumber;
  final String address;

  PersonContactUI(this.email, this.phoneNumber, this.address);
}
