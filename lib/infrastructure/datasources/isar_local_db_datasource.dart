import 'package:flutter/material.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sensors_app/domain/datasources/datasources.dart';
import 'package:sensors_app/domain/entities/entities.dart';

class IsarLocalDbDatasource extends LocalDbDatasource {
  late Future<Isar> db;

  IsarLocalDbDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([PokemonSchema], directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<void> insertPokemon(Pokemon pokemon) async {
    final isar = await db;

    final done = isar.writeTxnSync(() => isar.pokemons.putSync(pokemon));

    debugPrint('Inserted pokemon: $done');
  }

  @override
  Future<List<Pokemon>> loadPokemons() async {
    final isar = await db;

    return isar.pokemons.where().findAll();
  }

  @override
  Future<int> pokemonCount() async {
    final isar = await db;

    return isar.pokemons.count();
  }
}
