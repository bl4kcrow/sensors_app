import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sensors_app/presentation/providers/providers.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permissions Screen')),
      body: _PermissionsView(),
    );
  }
}

class _PermissionsView extends ConsumerWidget {
  const _PermissionsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissions = ref.watch(permissionsProvider);

    return ListView(
      children: [
        CheckboxListTile(
          value: permissions.cameraGranted,
          title: const Text('Camera'),
          subtitle: Text('${permissions.camera}'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestCameraAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.photosGranted,
          title: const Text('Photos'),
          subtitle: Text('${permissions.photos}'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestPhotosAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.sensorsGranted,
          title: const Text('Sensors'),
          subtitle: Text('${permissions.sensors}'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestSensorsAccess();
          },
        ),
        CheckboxListTile(
          value: permissions.locationGranted,
          title: const Text('Location'),
          subtitle: Text('${permissions.location}'),
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestLocationAccess();
          },
        ),
      ],
    );
  }
}
