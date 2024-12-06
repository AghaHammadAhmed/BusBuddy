import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OngoingTrip extends StatefulWidget {
  const OngoingTrip({super.key});

  @override
  State<OngoingTrip> createState() => _OngoingTripState();
}

class _OngoingTripState extends State<OngoingTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Text")),
    );
  }
}
