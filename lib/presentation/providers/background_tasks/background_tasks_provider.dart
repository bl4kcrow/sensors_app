import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sensors_app/config/config.dart';

final backgroundTasksProvider =
    AsyncNotifierProvider.family<BackgroundFetchNotifier, bool?, String>(
      BackgroundFetchNotifier.new,
    );

class BackgroundFetchNotifier extends AsyncNotifier<bool?> {
  BackgroundFetchNotifier(this.processKeyName);

  final String processKeyName;

  @override
  build() async {
    return await SharedPreferencesPlugin.getBool(processKeyName) ?? false;
  }

  activateProcess() async {
    debugPrint('Periodic Task: $processKeyName');
    
    await Workmanager().registerPeriodicTask(
      processKeyName,
      processKeyName,
      frequency: Duration(minutes: 10),
      constraints: Constraints(networkType: NetworkType.connected),
      tag: processKeyName,
    );

    await SharedPreferencesPlugin.setBool(processKeyName, true);
    state = AsyncValue.data(true);
  }

  deactivateProcess() async {
    await Workmanager().cancelByTag(processKeyName);

    await SharedPreferencesPlugin.setBool(processKeyName, false);
    state = AsyncValue.data(false);
  }

  toggleProcess() {
    if (state.value == true) {
      deactivateProcess();
    } else {
      activateProcess();
    }
  }
}
