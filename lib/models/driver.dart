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
=======
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
import 'package:cloud_firestore/cloud_firestore.dart';

class Driver {
  final String driverID;
  final String userID;
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
class Driver {
  final String driverID;
>>>>>>> 91ada8e3ae45d451fda9917c6d014f925e30e54c
=======
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  final String name;
  final int age;
  final String phone;
  final String drivingLicenseNumber;
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
=======
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  final double? rating; // Nullable
  final int seats;
  final double? monthlyFee; // Nullable
  final String vehicleNumber;
  final List<String> areas; // Areas served by the driver
  final bool isActive; // Whether the driver is available for booking
  final DateTime? createdAt;
  final DateTime? updatedAt;
<<<<<<< HEAD
  final String verificationStatus; // New field for verification status
  final String faceImage;
  final String cnicFrontImage;
  final String cnicBackImage;
  final List<String> carVanImages;
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
  final String password;
>>>>>>> 91ada8e3ae45d451fda9917c6d014f925e30e54c
=======
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2

  Driver({
    required this.driverID,
    required this.name,
    required this.age,
    required this.phone,
    required this.drivingLicenseNumber,
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
=======
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
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
    this.verificationStatus = 'incomplete', // Default status is 'pending'
    this.faceImage = '',
    this.cnicFrontImage = '',
    this.cnicBackImage = '',
    this.carVanImages = const [],
=======
<<<<<<< HEAD
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
<<<<<<< HEAD
      isActive: map['isActive'] ?? true,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] is Timestamp
              ? (map['createdAt'] as Timestamp).toDate()
              : DateTime.parse(map['createdAt']))
          : null,
      updatedAt: map['updatedAt'] != null
          ? (map['updatedAt'] is Timestamp
              ? (map['updatedAt'] as Timestamp).toDate()
              : DateTime.parse(map['updatedAt']))
          : null,
      verificationStatus: map['verificationStatus'] ?? 'incomplete',
      faceImage: map['faceImage'] ?? '',
      cnicFrontImage: map['cnicFrontImage'] ?? '',
      cnicBackImage: map['cnicBackImage'] ?? '',
      carVanImages: List<String>.from(map['carVanImages'] ?? []),
=======
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
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
<<<<<<< HEAD
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'verificationStatus': verificationStatus,
      'faceImage': faceImage,
      'cnicFrontImage': cnicFrontImage,
      'cnicBackImage': cnicBackImage,
      'carVanImages': carVanImages,
=======
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
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
<<<<<<< HEAD
      verificationStatus: json['verificationStatus'] ?? 'incomplete',
      faceImage: json['faceImage'] ?? '',
      cnicFrontImage: json['cnicFrontImage'] ?? '',
      cnicBackImage: json['cnicBackImage'] ?? '',
      carVanImages: json['carVanImages'] != null
          ? List<String>.from(json['carVanImages'])
          : [],
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
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
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
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
      'verificationStatus': verificationStatus,
      'faceImage': faceImage,
      'cnicFrontImage': cnicFrontImage,
      'cnicBackImage': cnicBackImage,
      'carVanImages': carVanImages,
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
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
    };
  }
}
