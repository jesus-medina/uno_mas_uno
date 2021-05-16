class PersonUI {
  final String _firstName;
  final String _lastName;
  final PersonGenderUI gender;
  final PersonContactUI personContact;
  final String birthday;

  PersonUI(this._firstName, this._lastName, this.gender, this.personContact, this.birthday);

  String get fullName => "$_firstName $_lastName";
  String get acronym => "${_firstName.substring(0, 1)}${_lastName.substring(0, 1)}";
}

enum PersonGenderUI { Male, Female, NonSpecified }

class PersonContactUI {
  final String email;
  final String phoneNumber;
  final String address;

  PersonContactUI(this.email, this.phoneNumber, this.address);
}