class DataPerson {
  final String id;
  final String firstName;
  final String lastName;
  final String gender;
  final String email;
  final String phoneNumber;
  final String address;
  final String birthday;
  final String spiritualGuideId;

  DataPerson(this.id, this.firstName, this.lastName, this.gender, this.email,
      this.phoneNumber, this.address, this.birthday,
      {this.spiritualGuideId});

  factory DataPerson.fromMap(String id, Map<dynamic, dynamic> map) {
    var firstName = map['first name'];
    var lastName = map['last name'];
    var gender = map['gender'];
    var email = map['email'];
    var phoneNumber = map['phone number'];
    var address = map['address'];
    var birthday = map['birthday'];
    var spiritualGuideId = map['spiritual guide id'];

    return DataPerson(
        id, firstName, lastName, gender, email, phoneNumber, address, birthday,
        spiritualGuideId: spiritualGuideId);
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'first name': firstName,
        'last name': lastName,
        'gender': gender,
        'email': email,
        'phone number': phoneNumber,
        'address': address,
        'birthday': birthday,
        'spiritual guide id': spiritualGuideId,
      };
}
