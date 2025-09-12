import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sensors_app/presentation/providers/providers.dart';
import 'package:sensors_app/presentation/screens/screens.dart';

class CompassScreen extends ConsumerWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLocationGranted = ref.watch(permissionsProvider).locationGranted;
    final compassHeading = ref.watch(compassProvider);

    if (!isLocationGranted) {
      return AskLocationScreen();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Compass', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: compassHeading.when(
        data: (headingData) => Compass(heading: headingData ?? 0),
        error: (error, stackTrace) => Center(
          child: Text(
            'Error: $error',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        loading: () => Center(child: const CircularProgressIndicator()),
      ),
    );
  }
}

class Compass extends StatefulWidget {
  const Compass({super.key, required this.heading});

  final double heading;

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double previousHeading = 0;
  double turns = 0;

  double getTurns() {

    double? direction = widget.heading;
    direction = (direction < 0) ? (360 + direction): direction;

    double diff = direction - previousHeading;
    if(diff.abs() > 180) {

      if(previousHeading > direction) {
        diff = 360 - (direction - previousHeading).abs();
      } else {
        diff = 360 - (previousHeading - direction).abs();
        diff = diff * -1;
      }
    }

    turns += (diff / 360);
    previousHeading = direction;

    return turns * -1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${widget.heading.ceil()}',
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/compass/quadrant-1.png'),
            AnimatedRotation(
              curve: Curves.easeOut,
              turns: getTurns(),
              duration: const Duration(seconds: 1),
              child: Image.asset('assets/images/compass/needle-1.png'),
            ),
          ],
        ),
      ],
    );
  }
}
