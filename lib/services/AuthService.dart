// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String currentAddress = '';
  late SharedPreferences _prefs;

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
      // sharedPreferences.setString('address', userDoc.get('address'));
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
          _prefs = await SharedPreferences.getInstance();
          await _prefs.setBool('isLoggedIn', true);
          await _prefs.setString('userType', role);
          await _prefs.setString('userID', userCredential.user!.uid);

          if (driverQuery.docs.isNotEmpty) {
            Navigator.pushReplacementNamed(context, '/mainNavigation2');
          } else {
            Navigator.pushReplacementNamed(context, '/driverDetail');
          }
        } else {}
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
      Exception(e);
      return null;
    }
  }

  /// Updates user details in Firestore.
  Future<String> updateUser(String userID, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userID).update(data);
      return "User updated successfully";
    } catch (e) {
      return "An error occurred while updating user: $e";
    }
  }

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
