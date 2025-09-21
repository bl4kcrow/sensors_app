import 'package:sensors_app/domain/entities/entities.dart';

abstract class LocalDbRepository {
  Future<List<Pokemon>> loadPokemons();

  Future<int> pokemonCount();

  Future<void> insertPokemon(Pokemon pokemon);
}
