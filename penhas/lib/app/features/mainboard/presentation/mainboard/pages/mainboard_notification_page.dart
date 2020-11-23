import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainboardNotificationPage extends StatelessWidget {
  final int counter;

  const MainboardNotificationPage({
    Key key,
    @required this.counter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Badge(
        child: counter == 0
            ? Icon(Icons.notifications_none, size: 34)
            : Icon(Icons.notifications, size: 34),
        elevation: 0.0,
        position: _badgePosition(counter),
        showBadge: counter > 0,
        toAnimate: false,
        badgeContent: Text(
          counter > 99 ? "+99" : counter.toString(),
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontSize: 11.0,
              fontWeight: FontWeight.normal),
        ),
      ),
      onPressed: () async => {
        Modular.to.pushNamed('/mainboard/notification'),
      },
    );
  }

  BadgePosition _badgePosition(int counter) {
    if (counter < 10) {
      return BadgePosition(end: -4, top: -8);
    } else if (counter < 100) {
      return BadgePosition(end: -8, top: -8);
    }

    return null;
  }
}
