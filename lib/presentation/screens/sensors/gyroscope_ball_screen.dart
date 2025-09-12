import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sensors_app/presentation/providers/providers.dart';

class GyroscopeBallScreen extends ConsumerWidget {
  const GyroscopeBallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gyroscope = ref.watch(gyroscopeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Gyroscope Ball')),
      body: SizedBox.expand(
        child: gyroscope.when(
          data: (value) => MovingBall(x: value.x, y: value.y),
          error: (error, stackTrace) => Text('Error: $error'),
          loading: () => Center(child: const CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class MovingBall extends StatelessWidget {
  const MovingBall({super.key, required this.x, required this.y});

  final double x;
  final double y;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double currentXPos = x * 100;
    double currentYPos = y * 100;

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositioned(
          left: (currentYPos - 25) + (size.width / 2),
          top: (currentXPos - 25) + (size.height / 2),
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 1000),
          child: Ball(),
        ),
        Text('''
        x: $x,
        y: $y
        ''', style: const TextStyle(fontSize: 20.0)),
      ],
    );
  }
}

class Ball extends StatelessWidget {
  const Ball({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(100.0),
      ),
    );
  }
}
