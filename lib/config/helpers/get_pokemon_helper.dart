
import 'package:dio/dio.dart';

import 'package:sensors_app/domain/entities/entities.dart';

Future<Pokemon?> getPokemonHelper(String id) async {
  final Dio dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2/'));

  try {
    final response = await dio.get('pokemon/$id');

    if (response.statusCode == 200) {
      final data = response.data;
      final pokemon = Pokemon(
        id: data['id'],
        name: data['name'],
        spriteFront: data['sprites']['front_default'] ?? '',
      );
      
      return pokemon;
    } else {
      return null;
    }
  } catch (e) {
    // Handle error
    return null;
  }

}