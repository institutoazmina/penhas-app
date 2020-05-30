import 'package:flutter/material.dart';

class TootAvatar extends StatelessWidget {
  const TootAvatar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Color.fromRGBO(239, 239, 239, 1.0),
      radius: 24.0,
      child: Icon(
        Icons.person_outline,
        color: Colors.black,
      ),
    );
  }
}
