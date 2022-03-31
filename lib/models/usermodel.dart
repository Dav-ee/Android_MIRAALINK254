class UserModel {
  String? uid;
  String? phone;
  String? email;
  String? name;

  UserModel({
    this.uid,
    this.phone,
    this.email,
    this.name,
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      phone: map['phone'],
      email: map['email'],
      name: map['name'],
    );
  }
  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phone': phone,
      'email': email,
      'name': name,
    };
  }
}
