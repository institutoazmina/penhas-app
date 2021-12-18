import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainboardNotificationPage extends StatelessWidget {
  final int counter;
  final void Function() resetCounter;

  const MainboardNotificationPage({
    Key? key,
    required this.counter,
    required this.resetCounter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Badge(
        elevation: 0.0,
        position: _badgePosition(counter)!,
        showBadge: counter > 0,
        toAnimate: false,
        badgeContent: Text(
          counter > 99 ? '+99' : counter.toString(),
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontSize: 11.0,
              fontWeight: FontWeight.normal,),
        ),
        child: counter == 0
            ? const Icon(Icons.notifications_none, size: 34)
            : const Icon(Icons.notifications, size: 34),
      ),
      onPressed: () async => _forwardNotification(),
    );
  }

  BadgePosition? _badgePosition(int counter) {
    if (counter < 10) {
      return const BadgePosition(end: -4, top: -8);
    } else if (counter < 100) {
      return const BadgePosition(end: -8, top: -8);
    }

    return null;
  }

  void _forwardNotification() {
    resetCounter();
    Modular.to.pushNamed('/mainboard/notification');
  }
}
