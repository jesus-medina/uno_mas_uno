class DataPerson {
  final String firstName;
  final String lastName;
  final String gender;
  final String email;
  final String phoneNumber;
  final String address;
  final String birthday;

  DataPerson(this.firstName, this.lastName, this.gender, this.email,
      this.phoneNumber, this.address, this.birthday);

  factory DataPerson.fromMap(Map<dynamic, dynamic> map) {
    return DataPerson(map['first name'], map['last name'], map['gender'],
        map['email'], map['phone number'], map['address'], map['birthday']);
  }
}
