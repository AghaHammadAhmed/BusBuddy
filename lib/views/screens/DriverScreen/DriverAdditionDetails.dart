// import 'dart:convert';
// import 'dart:developer';
// import 'dart:typed_data';
// import 'package:busbuddy/views/widgets/CustomAppBar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';

// class AddDriverDetailsScreen extends StatefulWidget {
//   @override
//   _AddDriverDetailsScreenState createState() => _AddDriverDetailsScreenState();
// }

// class _AddDriverDetailsScreenState extends State<AddDriverDetailsScreen> {
//   final ImagePicker _picker = ImagePicker();

//   String? faceImage; // Base64 string for driver's face
//   String? cnicFrontImage; // Base64 string for CNIC front
//   String? cnicBackImage; // Base64 string for CNIC back
//   List<String> carVanImages = []; // Base64 strings for car/van images
//   String userID = FirebaseAuth.instance.currentUser!.uid;
//   String driverID = '';
//   // Helper function to pick an image and return its Base64 representation

//   Future<String?> pickImage() async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       final originalBytes = await image.readAsBytes();

//       // Compress the image to 50% of its original size
//       final compressedBytes = await FlutterImageCompress.compressWithList(
//         originalBytes,
//         quality: 50, // Compression quality (50%)
//       );

//       return base64Encode(compressedBytes);
//     }
//     return null;
//   }

//   Future<List<String>> compressImages(List<String> base64Images) async {
//     List<String> compressedImages = [];

//     for (String base64Image in base64Images) {
//       Uint8List originalBytes = base64Decode(base64Image);
//       Uint8List compressedBytes = await FlutterImageCompress.compressWithList(
//         originalBytes,
//         quality: 50,
//       );
//       compressedImages.add(base64Encode(compressedBytes));
//     }

//     return compressedImages;
//   }

//   @override
//   void initState() {
//     loadDriver();
//     super.initState();
//   }

//   //load driver with userId
//   void loadDriver() async {
//     final driverData = await FirebaseFirestore.instance
//         .collection('drivers')
//         .where('userID', isEqualTo: userID)
//         .get();
//     if (driverData.docs.isNotEmpty) {
//       final driver = driverData.docs.first.data();
//       //fetch the driverID
//       driverID = driver['driverID'];
//       log('Driver ID: $driverID');
//     }
//   }

//   // Add image to a specific section
//   Future<void> addImage(String type) async {
//     final pickedImage = await pickImage();
//     if (pickedImage != null) {
//       setState(() {
//         switch (type) {
//           case 'face':
//             faceImage = pickedImage;
//             break;
//           case 'cnicFront':
//             cnicFrontImage = pickedImage;
//             break;
//           case 'cnicBack':
//             cnicBackImage = pickedImage;
//             break;
//           case 'carVan':
//             if (carVanImages.length < 3) {
//               carVanImages.add(pickedImage);
//             } else {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                     content: Text('You can only add up to 3 car/van images.')),
//               );
//             }
//             break;
//         }
//       });
//     }
//   }

//   // Helper function to display an image preview or placeholder
//   Widget displayImage(String? base64Image) {
//     if (base64Image == null) {
//       return Container(
//         width: 300,
//         height: 100,
//         decoration: BoxDecoration(
//           color: Colors.grey[200],
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: Colors.grey),
//         ),
//         child: Icon(Icons.add_photo_alternate,
//             size: 100 * 0.5, color: Colors.grey),
//       );
//     }
//     Uint8List bytes = base64Decode(base64Image);
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(10),
//       child: Image.memory(bytes, width: 300, height: 100, fit: BoxFit.cover),
//     );
//   }

//   // Save the data to Firestore or handle the data saving logic
//   Future<void> saveDriverDetails() async {
//     try {
//       if (faceImage == null ||
//           cnicFrontImage == null ||
//           cnicBackImage == null ||
//           carVanImages.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content: Text('Please add all required images before saving.')),
//         );
//         return;
//       }

//       // Compress images before saving
//       final compressedFaceImage = await FlutterImageCompress.compressWithList(
//         base64Decode(faceImage!),
//         quality: 50,
//       );

//       final compressedCnicFrontImage =
//           await FlutterImageCompress.compressWithList(
//         base64Decode(cnicFrontImage!),
//         quality: 50,
//       );

//       final compressedCnicBackImage =
//           await FlutterImageCompress.compressWithList(
//         base64Decode(cnicBackImage!),
//         quality: 50,
//       );

//       final compressedCarVanImages = await compressImages(carVanImages);

//       FirebaseFirestore.instance
//           .collection("drivers")
//           .doc(driverID)
//           .update({
//             "faceImage": base64Encode(compressedFaceImage),
//             "cnicFrontImage": base64Encode(compressedCnicFrontImage),
//             "cnicBackImage": base64Encode(compressedCnicBackImage),
//             "carVanImages": compressedCarVanImages,
//             "verificationStatus": "pending",
//           })
//           .then((value) => {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Driver details saved successfully!')),
//                 )
//               })
//           .catchError((error) => {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                       content: Text('Failed to save driver details: $error')),
//                 )
//               });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred: $e')),
//       );
//     }

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Driver details saved successfully!')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Add Driver Details'),
//           centerTitle: true,
//           backgroundColor: const Color(0xFF8A1538),
//           //back button
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.white),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ),
//         key: _scaffoldKey,
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 20),
//               SectionTitle(title: 'Driver Face Image'),
//               SizedBox(height: 5),
//               GestureDetector(
//                 onTap: () => addImage('face'),
//                 child: displayImage(faceImage),
//               ),
//               SizedBox(height: 20),
//               SectionTitle(title: 'CNIC Images (Front & Back)'),
//               SizedBox(height: 5),
//               GestureDetector(
//                 onTap: () => addImage('cnicFront'),
//                 child: displayImage(cnicFrontImage),
//               ),
//               SizedBox(height: 10),
//               GestureDetector(
//                 onTap: () => addImage('cnicBack'),
//                 child: displayImage(cnicBackImage),
//               ),
//               SizedBox(height: 20),

//               // Car/Van Section
//               SectionTitle(title: 'Car/Van Images (Up to 3)'),
//               Wrap(
//                 spacing: 16,
//                 runSpacing: 16,
//                 children: [
//                   ...carVanImages.map((image) => displayImage(image)),
//                   if (carVanImages.length < 3)
//                     GestureDetector(
//                       onTap: () => addImage('carVan'),
//                       child: displayImage(null),
//                     ),
//                 ],
//               ),
//               SizedBox(height: 20),

//               // Save Button
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: saveDriverDetails,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF8A1538),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: const Text(
//                       'Save Details',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Section Title Widget for better UI organization
// class SectionTitle extends StatelessWidget {
//   final String title;

//   const SectionTitle({Key? key, required this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: TextStyle(
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//         color: Colors.black87,
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:busbuddy/views/navigation_bar2.dart';
import 'package:busbuddy/views/widgets/CustomAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AddDriverDetailsScreen extends StatefulWidget {
  @override
  _AddDriverDetailsScreenState createState() => _AddDriverDetailsScreenState();
}

class _AddDriverDetailsScreenState extends State<AddDriverDetailsScreen> {
  final ImagePicker _picker = ImagePicker();

  String? faceImage; // Base64 string for driver's face
  String? cnicFrontImage; // Base64 string for CNIC front
  String? cnicBackImage; // Base64 string for CNIC back
  List<String> carVanImages = []; // Base64 strings for car/van images
  String userID = FirebaseAuth.instance.currentUser!.uid;
  String driverID = '';

  // void fetchDriverID() async {
  //   final driverData = await FirebaseFirestore.instance
  //       .collection('drivers')
  //       .where('userID', isEqualTo: userID)
  //       .get();
  //   if (driverData.docs.isNotEmpty) {
  //     final driver = driverData.docs.first.data();
  //     driverID = driver['driverID'];
  //     log('Driver ID: $driverID');
  //   }
  // }

  // Helper function to pick an image and compress it
  Future<String?> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final originalBytes = await image.readAsBytes();

      // Compress the image to 50% quality
      final compressedBytes = await FlutterImageCompress.compressWithList(
        originalBytes,
        quality: 50,
      );

      return base64Encode(compressedBytes);
    }
    return null;
  }

  // Function to compress existing base64 images
  Future<List<String>> compressImages(List<String> base64Images) async {
    List<String> compressedImages = [];

    for (String base64Image in base64Images) {
      Uint8List originalBytes = base64Decode(base64Image);
      Uint8List compressedBytes = await FlutterImageCompress.compressWithList(
        originalBytes,
        quality: 50,
      );
      compressedImages.add(base64Encode(compressedBytes));
    }

    return compressedImages;
  }

  @override
  void initState() {
    loadDriver();
    // fetchDriverID();
    super.initState();
  }

  // Load driver with userID
  void loadDriver() async {
    final driverData = await FirebaseFirestore.instance
        .collection('drivers')
        .where('userID', isEqualTo: userID)
        .get();
    if (driverData.docs.isNotEmpty) {
      final driver = driverData.docs.first.data();
      // Fetch the driverID
      driverID = driver['driverID'];
      log('Driver ID: $driverID');
    }
  }

  // Add image to a specific section
  Future<void> addImage(String type) async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        switch (type) {
          case 'face':
            faceImage = pickedImage;
            break;
          case 'cnicFront':
            cnicFrontImage = pickedImage;
            break;
          case 'cnicBack':
            cnicBackImage = pickedImage;
            break;
          case 'carVan':
            if (carVanImages.length < 3) {
              carVanImages.add(pickedImage);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('You can only add up to 3 car/van images.')),
              );
            }
            break;
        }
      });
    }
  }

  // Helper function to display an image preview or placeholder
  Widget displayImage(String? base64Image) {
    if (base64Image == null) {
      return Container(
        width: 300,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Icon(Icons.add_photo_alternate,
            size: 100 * 0.5, color: Colors.grey),
      );
    }
    Uint8List bytes = base64Decode(base64Image);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.memory(bytes, width: 300, height: 100, fit: BoxFit.cover),
    );
  }

  // Save the data to Firestore
  void saveDriverDetails() async {
    try {
      if (faceImage == null ||
          cnicFrontImage == null ||
          cnicBackImage == null ||
          carVanImages.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Please add all required images before saving.')),
        );
        return;
      }

      // Compress the images before saving
      final compressedFaceImage = await FlutterImageCompress.compressWithList(
        base64Decode(faceImage!),
        quality: 50,
      );

      final compressedCnicFrontImage =
          await FlutterImageCompress.compressWithList(
        base64Decode(cnicFrontImage!),
        quality: 50,
      );

      final compressedCnicBackImage =
          await FlutterImageCompress.compressWithList(
        base64Decode(cnicBackImage!),
        quality: 50,
      );

      final compressedCarVanImages = await compressImages(carVanImages);

      // Save the driver details to Firestore
      FirebaseFirestore.instance.collection("drivers").doc(driverID).update({
        "faceImage": base64Encode(compressedFaceImage),
        "cnicFrontImage": base64Encode(compressedCnicFrontImage),
        "cnicBackImage": base64Encode(compressedCnicBackImage),
        "carVanImages": compressedCarVanImages,
        "verificationStatus": "pending",
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Driver details saved successfully!')),
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MainNavigation2()));
      }).catchError((error) {
        log(driverID);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save driver details: $error')),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Driver Details'),
          centerTitle: true,
          backgroundColor: const Color(0xFF8A1538),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              SectionTitle(title: 'Driver Face Image'),
              GestureDetector(
                onTap: () => addImage('face'),
                child: displayImage(faceImage),
              ),
              SizedBox(height: 20),
              SectionTitle(title: 'CNIC Images (Front & Back)'),
              GestureDetector(
                onTap: () => addImage('cnicFront'),
                child: displayImage(cnicFrontImage),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => addImage('cnicBack'),
                child: displayImage(cnicBackImage),
              ),
              SizedBox(height: 20),
              SectionTitle(title: 'Car/Van Images (Up to 3)'),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  ...carVanImages.map((image) => displayImage(image)),
                  if (carVanImages.length < 3)
                    GestureDetector(
                      onTap: () => addImage('carVan'),
                      child: displayImage(null),
                    ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: saveDriverDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8A1538),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Save Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
