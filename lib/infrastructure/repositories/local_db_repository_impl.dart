import 'package:sensors_app/domain/datasources/datasources.dart';
import 'package:sensors_app/domain/entities/pokemon.dart';
import 'package:sensors_app/domain/repositories/repositories.dart';
import 'package:sensors_app/infrastructure/datasources/datasources.dart';

class LocalDbRepositoryImpl extends LocalDbRepository {
  final LocalDbDatasource _datasource;

  LocalDbRepositoryImpl([LocalDbDatasource? datasource])
    : _datasource = datasource ?? IsarLocalDbDatasource();

  @override
  Future<void> insertPokemon(Pokemon pokemon) {
    return _datasource.insertPokemon(pokemon);
  }

  @override
  Future<List<Pokemon>> loadPokemons() {
    return _datasource.loadPokemons();
  }

  @override
  Future<int> pokemonCount() {
    return _datasource.pokemonCount();
  }
}
