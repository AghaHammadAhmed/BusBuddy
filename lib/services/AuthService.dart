// ignore_for_file: use_build_context_synchronously

<<<<<<< HEAD


=======
import 'dart:convert';
import 'dart:io';
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../models/user.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String currentAddress = '';

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
      
=======
      print(userDoc.exists);
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
      if (userDoc.exists) {
        String role = userDoc.get('role');

        if (role == 'student') {
          Navigator.pushReplacementNamed(context, '/mainNavigation');
        } else if (role == 'driver') {
          QuerySnapshot driverQuery = await _firestore
              .collection('drivers')
              .where('userID', isEqualTo: userCredential.user!.uid)
              .limit(1) // Fetch only one document
              .get();
          currentAddress = userDoc.get('address');

<<<<<<< HEAD
          // print(driverQuery);
         
=======
          print(driverQuery);
          print(userCredential.user!.uid);
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
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
      print("Error fetching user: $e");
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
      return null;
    }
  }

  /// Updates user details in Firestore.
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
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
      return "User updated successfully";
    } catch (e) {
      return "An error occurred while updating user: $e";
    }
  }

<<<<<<< HEAD

=======
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
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

}
