<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
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
<<<<<<< HEAD
  final List<int>? selectedDates;
=======
<<<<<<< HEAD
  final List<int>? selectedDates;
=======
<<<<<<< HEAD
  final List<int>? selectedDates;
=======
<<<<<<< HEAD
  final List<int>? selectedDates;
=======
<<<<<<< HEAD
  final List<int>? selectedDates;
=======
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33

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
<<<<<<< HEAD
    this.selectedDates,
=======
<<<<<<< HEAD
    this.selectedDates,
=======
<<<<<<< HEAD
    this.selectedDates,
=======
<<<<<<< HEAD
    this.selectedDates,
=======
<<<<<<< HEAD
    this.selectedDates,
=======
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
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
<<<<<<< HEAD
      selectedDates: List<int>.from(map['selectedDates'] ?? []),
=======
<<<<<<< HEAD
      selectedDates: List<int>.from(map['selectedDates'] ?? []),
=======
<<<<<<< HEAD
      selectedDates: List<int>.from(map['selectedDates'] ?? []),
=======
<<<<<<< HEAD
      selectedDates: List<int>.from(map['selectedDates'] ?? []),
=======
<<<<<<< HEAD
      selectedDates: List<int>.from(map['selectedDates'] ?? []),
=======
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
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
<<<<<<< HEAD
      'selectedDates': selectedDates,
=======
<<<<<<< HEAD
      'selectedDates': selectedDates,
=======
<<<<<<< HEAD
      'selectedDates': selectedDates,
=======
<<<<<<< HEAD
      'selectedDates': selectedDates,
=======
<<<<<<< HEAD
      'selectedDates': selectedDates,
=======
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
class User {
=======
=======
<<<<<<< HEAD
=======

>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
class UserModel {
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  final String userID;
  final String name;
  final String email;
<<<<<<< HEAD
  final int? age;
  final String? gender;
  final String phone;
<<<<<<< HEAD
=======
<<<<<<< HEAD
  final int? age;
  final String? gender;
  final String phone;
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
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
<<<<<<< HEAD
  final String? address;
  final String? profilePicture;
  final String? role;
  final double? latitude;
  final double? longitude;
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
  final int? age; // Nullable
  final String? gender; // Nullable in case gender is optional
  final String phone;
  final String? address; // Nullable
  final String? role; // 'student' or 'driver'
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
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
<<<<<<< HEAD
    this.profilePicture,
    this.latitude,
    this.longitude,
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
    this.role,
    this.currentDriverId,
    this.createdAt,
    this.updatedAt,
  });

<<<<<<< HEAD
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
>>>>>>> 91ada8e3ae45d451fda9917c6d014f925e30e54c
=======
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
<<<<<<< HEAD
      age: map['age'],
      gender: map['gender'],
      phone: map['phone'] ?? '',
<<<<<<< HEAD
=======
<<<<<<< HEAD
      age: map['age'],
      gender: map['gender'],
      phone: map['phone'] ?? '',
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
      school: map['school'] ?? '',
      address: map['address'],
      dropOffLocation: map['dropOffLocation'],
      profilePicture: map['profilePicture'],
      pickupLatitude: map['pickupLatitude'],
      pickupLongitude: map['pickupLongitude'],
      dropOffLatitude: map['dropOffLatitude'],
      dropOffLongitude: map['dropOffLongitude'],
<<<<<<< HEAD
=======
      address: map['address'],
      profilePicture: map['profilePicture'],
      latitude: map['latitude'],
      longitude: map['longitude'],
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
      role: map['role'],
      currentDriverId: map['currentDriverId'],
      createdAt:
          map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
<<<<<<< HEAD
=======
=======
      age: map ['age'] ?? '',
      gender: map['gender'] ?? '',
      phone: map['phone'] ?? '',
      address: map['address'] ?? '',
      role: map['role'] ?? '',
      currentDriverId: map['currentDriverId'] ?? '',
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'name': name,
      'email': email,
<<<<<<< HEAD
      'age': age,
      'gender': gender,
      'phone': phone,
<<<<<<< HEAD
=======
<<<<<<< HEAD
      'age': age,
      'gender': gender,
      'phone': phone,
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
      'school': school,
      'address': address,
      'dropOffLocation': dropOffLocation,
      'profilePicture': profilePicture,
      'pickupLatitude': pickupLatitude,
      'pickupLongitude': pickupLongitude,
      'dropOffLatitude': dropOffLatitude,
      'dropOffLongitude': dropOffLongitude,
=======
<<<<<<< HEAD
      'address': address,
      'profilePicture': profilePicture,
      'latitude': latitude,
      'longitude': longitude,
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
      'age' : age,
      'gender' : gender,
      'phone': phone,
      'address': address,
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
      'role': role,
      'currentDriverId': currentDriverId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
<<<<<<< HEAD

=======
<<<<<<< HEAD

=======
  


  // Factory constructor for deserialization
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
      userID: json['userID'],
      name: json['name'],
      email: json['email'],
      age: json['age'],
      gender: json['gender'],
      phone: json['phone'],
<<<<<<< HEAD
      school: json['school'],
=======
<<<<<<< HEAD
      school: json['school'],
=======
<<<<<<< HEAD
      school: json['school'],
=======
<<<<<<< HEAD
      school: json['school'],
=======
<<<<<<< HEAD
      school: json['school'],
=======
<<<<<<< HEAD
      school: json['school'],
<<<<<<< HEAD
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
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
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
      selectedDates: json['selectedDates'] != null
          ? List<int>.from(json['selectedDates'])
          : [],
    );
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
=======
      address: json['address'],
      password: json['password'],
>>>>>>> 91ada8e3ae45d451fda9917c6d014f925e30e54c
=======
      address: json['address'],
      dropOffLocation: json['dropOffLocation'],
      profilePicture: json['profilePicture'],
      pickupLatitude: json['pickupLatitude'],
      pickupLongitude: json['pickupLongitude'],
      dropOffLatitude: json['dropOffLatitude'],
      dropOffLongitude: json['dropOffLongitude'],
=======
      address: json['address'],
<<<<<<< HEAD
      profilePicture: json['profilePicture'],
      latitude: json['latitude'],
      longitude: json['longitude'],
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
      role: json['role'],
      currentDriverId: json['currentDriverId'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    );
  }

<<<<<<< HEAD
=======
  // Method to serialize the object to JSON
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
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
      'school': school,
=======
<<<<<<< HEAD
      'school': school,
=======
<<<<<<< HEAD
      'school': school,
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
      'dropOffLocation': dropOffLocation,
      'profilePicture': profilePicture,
      'pickupLatitude': pickupLatitude,
      'pickupLongitude': pickupLongitude,
      'dropOffLatitude': dropOffLatitude,
      'dropOffLongitude': dropOffLongitude,
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
      'profilePicture': profilePicture,
      'latitude': latitude,
      'longitude': longitude,
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
      'role': role,
      'currentDriverId': currentDriverId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
<<<<<<< HEAD
      'selectedDates': selectedDates,
=======
<<<<<<< HEAD
      'selectedDates': selectedDates,
=======
<<<<<<< HEAD
      'selectedDates': selectedDates,
=======
<<<<<<< HEAD
      'selectedDates': selectedDates,
=======
<<<<<<< HEAD
      'selectedDates': selectedDates,
=======
<<<<<<< HEAD
=======
      'password': password,
>>>>>>> 91ada8e3ae45d451fda9917c6d014f925e30e54c
=======
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
    };
  }
}
