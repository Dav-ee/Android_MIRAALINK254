class FarmerModel {
  String? uid;
  String? farm_name;
  String? email;
  String? name;
  String? location;
  int? status;

  FarmerModel({
    this.uid,
    this.farm_name,
    this.email,
    this.name,
    this.location,
    this.status
  });

  // receiving data from server
  factory FarmerModel.fromMap(map) {
    return FarmerModel(
      uid: map['uid'],
      farm_name: map['farm_name'],
      email: map['email'],
      name: map['name'],
      location: map['location'],
      status: map['status'],
    );
  }

  // sending data to our server
  // Map<String, dynamic> toMap() {
  //   return {
  //     'uid': uid,
  //     'phone': phone,
  //     'email': email,
  //     'name': name,
  //   };
  // }
}
