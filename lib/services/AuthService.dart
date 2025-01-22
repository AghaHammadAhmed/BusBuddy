<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
// ignore_for_file: use_build_context_synchronously

<<<<<<< HEAD


=======
import 'dart:convert';
import 'dart:io';
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
// ignore_for_file: use_build_context_synchronously



<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
import '../models/user.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
<<<<<<< HEAD
  String currentAddress = '';
  late SharedPreferences _prefs;
=======
<<<<<<< HEAD
  String currentAddress = '';
  late SharedPreferences _prefs;
=======
<<<<<<< HEAD
  String currentAddress = '';
  late SharedPreferences _prefs;
=======
<<<<<<< HEAD
  String currentAddress = '';
=======
<<<<<<< HEAD
  String currentAddress = '';
=======
<<<<<<< HEAD
  String currentAddress = '';
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e

  /// Registers a new user using Firebase Authentication and saves user details in Firestore.
  Future<String> registerUser(UserModel user, String password) async {
    try {
      // Create user in Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      // Add userID from Firebase Authentication
      UserModel newUser = UserModel(
        userID: userCredential.user!.uid,
        name: user.name,
        email: user.email,
        role: user.role,
        age: user.age,
        gender: user.gender,
        phone: user.phone,
        address: user.address,
      );

      // Save user to Firestore
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(newUser.toJson());

      return "User registered successfully";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An error occurred during registration.";
    } catch (e) {
      return "An unexpected error occurred: $e";
    }
  }

  /// Logs in a user using Firebase Authentication.
  Future<String> loginUser(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
<<<<<<< HEAD
      // sharedPreferences.setString('address', userDoc.get('address'));
=======
<<<<<<< HEAD
      // sharedPreferences.setString('address', userDoc.get('address'));
=======
<<<<<<< HEAD
      // sharedPreferences.setString('address', userDoc.get('address'));
=======
<<<<<<< HEAD
      
=======
<<<<<<< HEAD
      
=======
<<<<<<< HEAD
      print(userDoc.exists);
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
          print(userDoc.exists);
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
      if (userDoc.exists) {
        String role = userDoc.get('role');

        if (role == 'student') {
          Navigator.pushReplacementNamed(context, '/mainNavigation');
        } else if (role == 'driver') {
<<<<<<< HEAD
          QuerySnapshot driverQuery = await _firestore
=======
<<<<<<< HEAD
          QuerySnapshot driverQuery = await _firestore
=======
<<<<<<< HEAD
          QuerySnapshot driverQuery = await _firestore
=======
<<<<<<< HEAD
          QuerySnapshot driverQuery = await _firestore
=======
<<<<<<< HEAD
          QuerySnapshot driverQuery = await _firestore
=======
<<<<<<< HEAD
          QuerySnapshot driverQuery = await _firestore
=======
           QuerySnapshot driverQuery = await _firestore
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
              .collection('drivers')
              .where('userID', isEqualTo: userCredential.user!.uid)
              .limit(1) // Fetch only one document
              .get();
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
          currentAddress = userDoc.get('address');
          _prefs = await SharedPreferences.getInstance();
          await _prefs.setBool('isLoggedIn', true);
          await _prefs.setString('userType', role);
          await _prefs.setString('userID', userCredential.user!.uid);

          if (driverQuery.docs.isNotEmpty) {
<<<<<<< HEAD
            Navigator.pushReplacementNamed(context, '/mainNavigation2');
=======
            Navigator.pushReplacementNamed(context, '/driverHome');
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
          } else {
            Navigator.pushReplacementNamed(context, '/driverDetail');
          }
        } else {}
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
          currentAddress = userDoc.get('address');

<<<<<<< HEAD
          // print(driverQuery);
         
=======
          print(driverQuery);
          print(userCredential.user!.uid);
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
          currentAddress = userDoc.get('address');

          // print(driverQuery);
         
<<<<<<< HEAD
=======
=======

          print(driverQuery);
          print(userCredential.user!.uid);
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
          if (driverQuery.docs.isNotEmpty) {
            Navigator.pushReplacementNamed(context, '/driverHome');
            print("Driver document exists");
          } else {
            Navigator.pushReplacementNamed(context, '/driverDetail');
            print("Driver document does not exist");
          }
        } else {
          print("Invalid role: $role");
        }
      } else {
        print("User document does not exist!");
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
      }

      return "Login successful";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An error occurred during login.";
    } catch (e) {
      return "An unexpected error occurred: $e";
    }
  }

  /// Logs out the current user.
  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  /// Fetches user details from Firestore.
  Future<UserModel?> fetchUser(String userID) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection('users').doc(userID).get();

      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
<<<<<<< HEAD
      Exception(e);
=======
<<<<<<< HEAD
      Exception(e);
=======
<<<<<<< HEAD
      Exception(e);
=======
<<<<<<< HEAD
      Exception(e);
=======
<<<<<<< HEAD
      Exception(e);
=======
      print("Error fetching user: $e");
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
      return null;
    }
  }

  /// Updates user details in Firestore.
<<<<<<< HEAD
  Future<String> updateUser(String userID, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userID).update(data);
=======
<<<<<<< HEAD
  Future<String> updateUser(String userID, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userID).update(data);
=======
<<<<<<< HEAD
  Future<String> updateUser(String userID, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userID).update(data);
=======
<<<<<<< HEAD
 Future<String> updateUser(String userID, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userID).update(data);
=======
<<<<<<< HEAD
 Future<String> updateUser(String userID, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userID).update(data);
=======
  Future<String> updateUser(UserModel user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.userID)
          .update(user.toJson());
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
      return "User updated successfully";
    } catch (e) {
      return "An error occurred while updating user: $e";
    }
  }

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
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
  /// Deletes a user account from both Firebase Authentication and Firestore.
  Future<String> deleteUser(String userID) async {
    try {
      // Delete user from Firestore
      await _firestore.collection('users').doc(userID).delete();

      // Delete user from Firebase Authentication
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();
      }

      return "User deleted successfully";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An error occurred while deleting user.";
    } catch (e) {
      return "An unexpected error occurred: $e";
    }
  }
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
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e

  // Future<void> uploadProfilePicture(String userID) async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     final file = File(pickedFile.path);
  //     final bytes = await file.readAsBytes();
  //     final base64Image = base64Encode(bytes);

  //     try {
  //       // Save to Firestore under the current user's document
  //       await _firestore.collection('users').doc(userID).update({
  //         'profilePicture': base64Image,
  //       });
  //       print("Profile picture uploaded successfully.");
  //     } catch (e) {
  //       print("Error uploading profile picture: $e");
  //     }
  //   } else {
  //     print("No image selected.");
  //   }
  // }

  // Future<String?> fetchProfilePicture(String userID) async {
  //   try {
  //     DocumentSnapshot<Map<String, dynamic>> doc =
  //         await _firestore.collection('users').doc(userID).get();

  //     if (doc.exists) {
  //       return doc.data()?['profilePicture'];
  //     }
  //   } catch (e) {
  //     print("Error fetching profile picture: $e");
  //   }
  //   return null;
  // }

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
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
}
