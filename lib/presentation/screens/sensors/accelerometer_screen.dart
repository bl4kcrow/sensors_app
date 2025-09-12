import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sensors_app/presentation/providers/providers.dart';

class AccelerometerScreen extends ConsumerWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accelerometer = ref.watch(accelerometerGravityProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Accelerometer')),
      body: accelerometer.when(
        data: (value) => Center(child: Text(value.toString())),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
