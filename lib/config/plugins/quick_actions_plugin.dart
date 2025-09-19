import 'package:flutter/cupertino.dart';
import 'package:quick_actions/quick_actions.dart';

import 'package:sensors_app/config/config.dart';

class QuickActionsPlugin {
  static registerActions() {
    final QuickActions quickActions = QuickActions();

    quickActions.initialize((shortcutType) {
      debugPrint('Shortcut type: $shortcutType');
      switch (shortcutType) {
        case 'compass':
          router.go('/compass');
          break;
        case 'gyroscope-ball':
          router.go('/gyroscope-ball');
          break;
        case 'accelerometer':
          router.go('/accelerometer');
          break;
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'compass',
        localizedTitle: 'Compass',
        icon: 'compass',
      ),
      const ShortcutItem(
        type: 'gyroscope-ball',
        localizedTitle: 'Gyroscope Ball',
        icon: 'ball',
      ),
      const ShortcutItem(
        type: 'accelerometer',
        localizedTitle: 'Accelerometer',
        icon: 'finger',
      ),
    ]);
  }
}
