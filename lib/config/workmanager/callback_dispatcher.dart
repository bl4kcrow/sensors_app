import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

import 'package:sensors_app/config/config.dart';
import 'package:sensors_app/domain/repositories/repositories.dart';
import 'package:sensors_app/infrastructure/repositories/repositories.dart';

const fetchBackgroundTaskKey = 'com.bl4kcrow.sensors_app.fetch-background-pokemon';
const fetchPeriodicBackgroundTaskKey = 'com.bl4kcrow.sensors_app.fetch-periodic-pokemon';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {

    switch (task) {
      case fetchBackgroundTaskKey:
        debugPrint('fetchBackgroundTaskKey');
        await loadNextPokemon();
        break;
      case fetchPeriodicBackgroundTaskKey:
        debugPrint('fetchPeriodicBackgroundTaskKey');
        await loadNextPokemon();
        break;
      case Workmanager.iOSBackgroundTask:
        debugPrint('Workmanager.iOSBackgroundTask');
        break;
    }
    // Your background work here
    return Future.value(true);
  });
}

Future loadNextPokemon() async {
  final LocalDbRepository localDbRepository = LocalDbRepositoryImpl();

  final lastPokemonId = await localDbRepository.pokemonCount() + 1;

  try {
    final newPokemon = await getPokemonHelper('$lastPokemonId');
    if (newPokemon != null) {
      await localDbRepository.insertPokemon(newPokemon);
      debugPrint('Pokemon inserted: ${newPokemon.name}');
    } else {
      throw 'No new pokemon found';
    }
  } catch (error) {
    debugPrint('$error');
  }

}