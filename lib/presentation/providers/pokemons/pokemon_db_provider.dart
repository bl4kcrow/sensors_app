
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_app/domain/entities/entities.dart';
import 'package:sensors_app/infrastructure/repositories/repositories.dart';

final pokemonDBProvider = FutureProvider.autoDispose<List<Pokemon>>((ref) async {

  final localDb = LocalDbRepositoryImpl();
  final pokemons = await localDb.loadPokemons();

  return pokemons;
});