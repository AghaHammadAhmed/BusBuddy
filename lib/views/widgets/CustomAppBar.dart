import "package:flutter/material.dart";

Widget customAppBar(double screenWidth, double screenHeight,
    GlobalKey<ScaffoldState> _scaffoldKey) {
  return Container(
    width: double.infinity,
    height: screenHeight * 0.10,
    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
    decoration: BoxDecoration(
      color: const Color(0xFF8A1538),
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 28),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        Text(
          'BusBuddy',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () {
            // Navigate to notifications
          },
        ),
      ],
    ),
  );
}
