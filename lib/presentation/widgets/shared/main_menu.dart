import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final String routeName;

  MenuItem(this.title, this.icon, this.routeName);
}

final menuItems = <MenuItem>[
  MenuItem('Accelerometer', Icons.speed, '/accelerometer'),
  MenuItem('Gyroscope', Icons.downloading, '/gyroscope'),
  MenuItem('Magnetometer', Icons.explore_outlined, '/magnetometer'),
  MenuItem('Gyroscope Ball', Icons.sports_baseball_outlined, '/gyroscope-ball'),
  MenuItem('Compass', Icons.explore, '/compass'),
];

class HomeMenuItem extends StatelessWidget {
  const HomeMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.route,
    this.bgColors = const [Colors.lightBlue, Colors.blueAccent],
  });

  final String title;
  final IconData icon;
  final String route;
  final List<Color> bgColors;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: bgColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: bgColors.last.withValues(alpha: 0.5),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.0
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: menuItems
          .map(
            (item) => HomeMenuItem(
              title: item.title,
              icon: item.icon,
              route: item.routeName,
            ),
          )
          .toList(),
    );
  }
}
