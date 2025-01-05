<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  final String driverID;
  final String userID;
<<<<<<< HEAD
=======
class Driver {
  final String driverID;
>>>>>>> 91ada8e3ae45d451fda9917c6d014f925e30e54c
=======
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  final String name;
  final int age;
  final String phone;
  final String drivingLicenseNumber;
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  final double? rating; // Nullable
  final int seats;
  final double? monthlyFee; // Nullable
  final String vehicleNumber;
  final List<String> areas; // Areas served by the driver
  final bool isActive; // Whether the driver is available for booking
  final DateTime? createdAt;
  final DateTime? updatedAt;
<<<<<<< HEAD
=======
  final String password;
>>>>>>> 91ada8e3ae45d451fda9917c6d014f925e30e54c
=======
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4

  Driver({
    required this.driverID,
    required this.name,
    required this.age,
    required this.phone,
    required this.drivingLicenseNumber,
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    this.rating,
    this.seats = 0,
    this.monthlyFee,
    required this.vehicleNumber,
    required this.userID,
    this.areas = const [],
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
<<<<<<< HEAD
  });

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      driverID: map['id'] ?? '',
      userID: map['userID'] ?? '',
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      phone: map['phone'] ?? '',
      drivingLicenseNumber: map['drivingLicenseNumber'] ?? '',
      rating: map['rating'] ?? 0.0,
      seats: map['seats'] ?? 0,
      monthlyFee: map['monthlyFee'] ?? 0,
      vehicleNumber: map['vehicleNumber'] ?? '',
      areas: List<String>.from(map['areas'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': driverID,
      'userID': userID,
      'name': name,
      'age': age,
      'phone': phone,
      'drivingLicenseNumber': drivingLicenseNumber,
      'rating': rating,
      'seats': seats,
      'monthlyFee': monthlyFee,
      'vehicleNumber': vehicleNumber,
      'areas': areas,
    };
  }

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      driverID: json['driverID'] ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      phone: json['phone'] ?? '',
      drivingLicenseNumber: json['drivingLicenseNumber'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      seats: json['seats'] ?? 0,
      monthlyFee: json['monthlyFee'] != null
          ? (json['monthlyFee'] as num).toDouble()
          : null,
      vehicleNumber: json['vehicleNumber'] ?? '',
      userID: json['userID'] ?? '',
      areas: json['areas'] != null ? List<String>.from(json['areas']) : [],
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] is Timestamp
              ? (json['createdAt'] as Timestamp).toDate()
              : DateTime.parse(json['createdAt']))
          : null,
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] is Timestamp
              ? (json['updatedAt'] as Timestamp).toDate()
              : DateTime.parse(json['updatedAt']))
          : null,
=======
    required this.password,
=======
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  });

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      driverID: map['id'] ?? '',
      userID: map['userID'] ?? '',
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      phone: map['phone'] ?? '',
      drivingLicenseNumber: map['drivingLicenseNumber'] ?? '',
      rating: map['rating'] ?? 0.0,
      seats: map['seats'] ?? 0,
      monthlyFee: map['monthlyFee'] ?? 0,
      vehicleNumber: map['vehicleNumber'] ?? '',
      areas: List<String>.from(map['areas'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': driverID,
      'userID': userID,
      'name': name,
      'age': age,
      'phone': phone,
      'drivingLicenseNumber': drivingLicenseNumber,
      'rating': rating,
      'seats': seats,
      'monthlyFee': monthlyFee,
      'vehicleNumber': vehicleNumber,
      'areas': areas,
    };
  }

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
<<<<<<< HEAD
      driverID: json['driverID'],
      name: json['name'],
      age: json['age'],
      phone: json['phone'],
      drivingLicenseNumber: json['drivingLicenseNumber'],
      password: json['password'],
>>>>>>> 91ada8e3ae45d451fda9917c6d014f925e30e54c
=======
      driverID: json['driverID'] ?? '',
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      phone: json['phone'] ?? '',
      drivingLicenseNumber: json['drivingLicenseNumber'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      seats: json['seats'] ?? 0,
      monthlyFee: json['monthlyFee'] != null
          ? (json['monthlyFee'] as num).toDouble()
          : null,
      vehicleNumber: json['vehicleNumber'] ?? '',
      userID: json['userID'] ?? '',
      areas: json['areas'] != null ? List<String>.from(json['areas']) : [],
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] is Timestamp
              ? (json['createdAt'] as Timestamp).toDate()
              : DateTime.parse(json['createdAt']))
          : null,
      updatedAt: json['updatedAt'] != null
          ? (json['updatedAt'] is Timestamp
              ? (json['updatedAt'] as Timestamp).toDate()
              : DateTime.parse(json['updatedAt']))
          : null,
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driverID': driverID,
      'name': name,
      'age': age,
      'phone': phone,
      'drivingLicenseNumber': drivingLicenseNumber,
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
      'rating': rating,
      'seats': seats,
      'monthlyFee': monthlyFee,
      'vehicleNumber': vehicleNumber,
      'userID': userID,
      'areas': areas,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
<<<<<<< HEAD
=======
      'password': password,
>>>>>>> 91ada8e3ae45d451fda9917c6d014f925e30e54c
=======
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    };
  }
}
