import 'package:badges/badges.dart' as bdg;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainboardNotificationPage extends StatelessWidget {
  const MainboardNotificationPage({
    super.key,
    required this.counter,
    required this.resetCounter,
  });

  final int counter;
  final void Function() resetCounter;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: bdg.Badge(
        elevation: 0.0,
        position: _badgePosition(counter),
        showBadge: counter > 0,
        badgeContent: Text(
          counter > 99 ? '+99' : counter.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Lato',
            fontSize: 11.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        child: counter == 0
            ? const Icon(Icons.notifications_none, size: 34)
            : const Icon(Icons.notifications, size: 34),
      ),
      onPressed: () async => _forwardNotification(),
    );
  }

  bdg.BadgePosition? _badgePosition(int counter) {
    if (counter < 10) {
      return const bdg.BadgePosition(end: -4, top: -8);
    } else if (counter < 100) {
      return const bdg.BadgePosition(end: -8, top: -8);
    }

    return null;
  }

  void _forwardNotification() {
    resetCounter();
    Modular.to.pushNamed('/mainboard/notification');
  }
}
