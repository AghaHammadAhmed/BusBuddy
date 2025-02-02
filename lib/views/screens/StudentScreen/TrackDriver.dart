import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TrackDriver extends StatefulWidget {
  const TrackDriver({super.key});

  @override
  State<TrackDriver> createState() => _TrackDriverState();
}

class _TrackDriverState extends State<TrackDriver> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Driver'),
      ),
      body: const Center(
        child: Text('Track Driver'),
      ),
    );
  }
}
