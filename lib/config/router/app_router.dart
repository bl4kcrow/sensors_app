import 'package:go_router/go_router.dart';
import 'package:sensors_app/presentation/screens/screens.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'permissions',
          builder: (context, state) => const PermissionsScreen(),
        ),
        GoRoute(
          path: 'accelerometer',
          builder: (context, state) => const AccelerometerScreen(),
        ),
        GoRoute(
          path: 'compass',
          builder: (context, state) => const CompassScreen(),
        ),
        GoRoute(
          path: 'gyroscope',
          builder: (context, state) => const GyroscopeScreen(),
        ),
        GoRoute(
          path: 'gyroscope-ball',
          builder: (context, state) => const GyroscopeBallScreen(),
        ),
        GoRoute(
          path: 'magnetometer',
          builder: (context, state) => const MagnetometerScreen(),
        ),
      ],
    ),
  ],
);
