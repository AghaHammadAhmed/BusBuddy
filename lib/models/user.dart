
class UserModel {
  final String userID;
  final String name;
  final String email;
  final int? age; // Nullable
  final String? gender; // Nullable in case gender is optional
  final String phone;
  final String? address; // Nullable
  final String? role; // 'student' or 'driver'
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
    this.address,
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
      age: map ['age'] ?? '',
      gender: map['gender'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      role: map['role'] ?? '',
      currentDriverId: map['currentDriverId'] ?? '',
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'name': name,
      'email': email,
      'age' : age,
      'gender' : gender,
      'phone': phone,
      'address': address,
      'role': role,
      'currentDriverId': currentDriverId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
  


  // Factory constructor for deserialization
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userID: json['userID'],
      name: json['name'],
      email: json['email'],
      age: json['age'],
      gender: json['gender'],
      phone: json['phone'],
      address: json['address'],
      role: json['role'],
      currentDriverId: json['currentDriverId'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  // Method to serialize the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'phone': phone,
      'address': address,
      'role': role,
      'currentDriverId': currentDriverId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
