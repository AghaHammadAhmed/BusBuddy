class UserModel {
  final String userID;
  final String name;
  final String email;
  final int? age;
  final String? gender;
  final String phone;
  final String? school;
  final String? address;
  final String? dropOffLocation;
  final String? profilePicture;
  final String? role;
  final double? pickupLatitude;
  final double? pickupLongitude;
  final double? dropOffLatitude;
  final double? dropOffLongitude;
  final String? currentDriverId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<int>? selectedDates;

  UserModel({
    required this.userID,
    required this.name,
    required this.email,
    this.age,
    this.gender,
    required this.phone,
    this.school,
    this.address,
    this.dropOffLocation,
    this.profilePicture,
    this.pickupLatitude,
    this.pickupLongitude,
    this.dropOffLatitude,
    this.dropOffLongitude,
    this.role,
    this.currentDriverId,
    this.createdAt,
    this.updatedAt,
    this.selectedDates,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      age: map['age'],
      gender: map['gender'],
      phone: map['phone'] ?? '',
      school: map['school'] ?? '',
      address: map['address'],
      dropOffLocation: map['dropOffLocation'],
      profilePicture: map['profilePicture'],
      pickupLatitude: map['pickupLatitude'],
      pickupLongitude: map['pickupLongitude'],
      dropOffLatitude: map['dropOffLatitude'],
      dropOffLongitude: map['dropOffLongitude'],
      role: map['role'],
      currentDriverId: map['currentDriverId'],
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      selectedDates: List<int>.from(map['selectedDates'] ?? []),
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
      'school': school,
      'address': address,
      'dropOffLocation': dropOffLocation,
      'profilePicture': profilePicture,
      'pickupLatitude': pickupLatitude,
      'pickupLongitude': pickupLongitude,
      'dropOffLatitude': dropOffLatitude,
      'dropOffLongitude': dropOffLongitude,
      'role': role,
      'currentDriverId': currentDriverId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'selectedDates': selectedDates,
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
      school: json['school'],
      address: json['address'],
      dropOffLocation: json['dropOffLocation'],
      profilePicture: json['profilePicture'],
      pickupLatitude: json['pickupLatitude'],
      pickupLongitude: json['pickupLongitude'],
      dropOffLatitude: json['dropOffLatitude'],
      dropOffLongitude: json['dropOffLongitude'],
      role: json['role'],
      currentDriverId: json['currentDriverId'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      selectedDates: json['selectedDates'] != null
          ? List<int>.from(json['selectedDates'])
          : [],
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
      'dropOffLocation': dropOffLocation,
      'profilePicture': profilePicture,
      'pickupLatitude': pickupLatitude,
      'pickupLongitude': pickupLongitude,
      'dropOffLatitude': dropOffLatitude,
      'dropOffLongitude': dropOffLongitude,
      'role': role,
      'currentDriverId': currentDriverId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'selectedDates': selectedDates,
    };
  }
}
