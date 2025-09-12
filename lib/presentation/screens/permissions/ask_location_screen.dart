import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sensors_app/presentation/providers/providers.dart';

class AskLocationScreen extends ConsumerWidget {
  const AskLocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Permission')),
      body: Center(
        child: FilledButton(
          child: Text('Location required'),
          onPressed: () {
            ref.read(permissionsProvider.notifier).requestLocationAccess();
          },
        ),
      ),
    );
  }
}
