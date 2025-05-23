import 'package:flutter/material.dart';

import '../../../../shared/design_system/text_styles.dart';

class PenhasDrawerHeaderPage extends StatelessWidget {
  const PenhasDrawerHeaderPage({
    super.key,
    required String userName,
    required Widget userAvatar,
  })  : _userName = userName,
        _userAvatar = userAvatar;

  final String _userName;
  final Widget _userAvatar;

  @override
  Widget build(BuildContext context) {
    const Color drawerGrey = Color.fromRGBO(239, 239, 239, 1.0);

    return Container(
      padding: const EdgeInsets.only(left: 16.0),
      height: 100,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: drawerGrey,
            radius: 25,
            child: _userAvatar,
          ),
          const SizedBox(width: 9.0),
          Text(
            _userName,
            style: kTextStyleDrawerUsername,
          ),
          const SizedBox(width: 9.0),
          Container(
            padding: const EdgeInsets.fromLTRB(6.0, 4.0, 6.0, 4.0),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(234, 234, 234, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6.0),
                bottomLeft: Radius.circular(6.0),
                bottomRight: Radius.circular(6.0),
              ),
            ),
            child: const Text('Você', style: kTextStyleDrawerUserNameTag),
          ),
        ],
      ),
    );
  }
}
