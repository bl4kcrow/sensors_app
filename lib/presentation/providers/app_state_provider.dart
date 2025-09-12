import 'package:flutter/widgets.dart' show AppLifecycleState;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appStateProvider = NotifierProvider<AppStateNotifier, AppLifecycleState>(
  AppStateNotifier.new,
);

class AppStateNotifier extends Notifier<AppLifecycleState> {
  @override
  build() {
    return AppLifecycleState.resumed;
  }

  void setAppState(AppLifecycleState state) {
    state = state;
  }
}
