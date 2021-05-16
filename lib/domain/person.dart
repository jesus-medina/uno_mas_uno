class Person {
  final String firstName;
  final String lastName;
  final PersonGender gender;
  final PersonContact personContact;
  final String birthday;

  Person(this.firstName, this.lastName, this.gender, this.personContact, this.birthday);
}

enum PersonGender { Male, Female, NonSpecified }

class PersonContact {
  final String email;
  final String phoneNumber;
  final String address;

  PersonContact(this.email, this.phoneNumber, this.address);
}