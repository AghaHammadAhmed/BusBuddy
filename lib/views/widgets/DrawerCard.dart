import 'package:flutter/material.dart';

Widget buildDrawerItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: Colors.blue),
    title: Text(
      title,
      style: const TextStyle(fontSize: 16),
    ),
    onTap: onTap,
    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
  );
}
