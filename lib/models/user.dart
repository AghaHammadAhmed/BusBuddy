class UserModel {
  final String userID;
  final String name;
  final String email;
  final int? age;
  final String? gender;
  final String phone;
<<<<<<< HEAD
  final String? school;
  final String? address;
  final String? dropOffLocation;
  final String? profilePicture;
  final String? role;
  final double? pickupLatitude;
  final double? pickupLongitude;
  final double? dropOffLatitude;
  final double? dropOffLongitude;
=======
  final String? address;
  final String? profilePicture;
  final String? role;
  final double? latitude;
  final double? longitude;
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
  final String? currentDriverId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.userID,
    required this.name,
    required this.email,
    this.age,
    this.gender,
    required this.phone,
<<<<<<< HEAD
    this.school,
    this.address,
    this.dropOffLocation,
    this.profilePicture,
    this.pickupLatitude,
    this.pickupLongitude,
    this.dropOffLatitude,
    this.dropOffLongitude,
=======
    this.address,
    this.profilePicture,
    this.latitude,
    this.longitude,
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
    this.role,
    this.currentDriverId,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      age: map['age'],
      gender: map['gender'],
      phone: map['phone'] ?? '',
<<<<<<< HEAD
      school: map['school'] ?? '',
      address: map['address'],
      dropOffLocation: map['dropOffLocation'],
      profilePicture: map['profilePicture'],
      pickupLatitude: map['pickupLatitude'],
      pickupLongitude: map['pickupLongitude'],
      dropOffLatitude: map['dropOffLatitude'],
      dropOffLongitude: map['dropOffLongitude'],
=======
      address: map['address'],
      profilePicture: map['profilePicture'],
      latitude: map['latitude'],
      longitude: map['longitude'],
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
      role: map['role'],
      currentDriverId: map['currentDriverId'],
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'phone': phone,
<<<<<<< HEAD
      'school': school,
      'address': address,
      'dropOffLocation': dropOffLocation,
      'profilePicture': profilePicture,
      'pickupLatitude': pickupLatitude,
      'pickupLongitude': pickupLongitude,
      'dropOffLatitude': dropOffLatitude,
      'dropOffLongitude': dropOffLongitude,
=======
      'address': address,
      'profilePicture': profilePicture,
      'latitude': latitude,
      'longitude': longitude,
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
      'role': role,
      'currentDriverId': currentDriverId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json['userID'],
      name: json['name'],
      email: json['email'],
      age: json['age'],
      gender: json['gender'],
      phone: json['phone'],
<<<<<<< HEAD
      school: json['school'],
      address: json['address'],
      dropOffLocation: json['dropOffLocation'],
      profilePicture: json['profilePicture'],
      pickupLatitude: json['pickupLatitude'],
      pickupLongitude: json['pickupLongitude'],
      dropOffLatitude: json['dropOffLatitude'],
      dropOffLongitude: json['dropOffLongitude'],
=======
      address: json['address'],
      profilePicture: json['profilePicture'],
      latitude: json['latitude'],
      longitude: json['longitude'],
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
      role: json['role'],
      currentDriverId: json['currentDriverId'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'phone': phone,
      'address': address,
<<<<<<< HEAD
      'dropOffLocation': dropOffLocation,
      'profilePicture': profilePicture,
      'pickupLatitude': pickupLatitude,
      'pickupLongitude': pickupLongitude,
      'dropOffLatitude': dropOffLatitude,
      'dropOffLongitude': dropOffLongitude,
=======
      'profilePicture': profilePicture,
      'latitude': latitude,
      'longitude': longitude,
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
      'role': role,
      'currentDriverId': currentDriverId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
