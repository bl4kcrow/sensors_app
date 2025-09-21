import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

import 'package:sensors_app/config/config.dart';
import 'package:sensors_app/domain/entities/entities.dart';
import 'package:sensors_app/presentation/providers/providers.dart';

class DbPokemonsScreen extends ConsumerWidget {
  const DbPokemonsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonsAsync = ref.watch(pokemonDBProvider);
    final isBackgroundPeriodicTaskActive = ref.watch(
      backgroundTasksProvider(fetchPeriodicBackgroundTaskKey),
    );

    if (pokemonsAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final List<Pokemon> pokemons = pokemonsAsync.value ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Process'),
        actions: [
          IconButton(
            onPressed: () {
              Workmanager().registerOneOffTask(
                fetchBackgroundTaskKey,
                fetchBackgroundTaskKey,
                initialDelay: const Duration(seconds: 3),
                inputData: {'howMany': '30'},
              );
            },
            icon: const Icon(Icons.add_alarm_sharp),
          ),
        ],
      ),
      body: CustomScrollView(slivers: [_PokemonsGrid(pokemons: pokemons)]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref
              .read(
                backgroundTasksProvider(
                  fetchPeriodicBackgroundTaskKey,
                ).notifier,
              )
              .toggleProcess();
        },
        label: isBackgroundPeriodicTaskActive.value == true
            ? const Text('Deactivate periodic fetch')
            : const Text('Activate periodic fetch'),
        icon: const Icon(Icons.av_timer),
      ),
    );
  }
}

class _PokemonsGrid extends StatelessWidget {
  const _PokemonsGrid({required this.pokemons});

  final List<Pokemon> pokemons;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return Column(
          children: [
            Image.network(pokemon.spriteFront, fit: BoxFit.contain),
            Text(pokemon.name, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        );
      },
    );
  }
}
