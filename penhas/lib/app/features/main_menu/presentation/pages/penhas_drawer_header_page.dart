import 'package:flutter/material.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class PenhasDrawerHeaderPage extends StatelessWidget {
  final String _userName;
  final Widget _userAvatar;
  const PenhasDrawerHeaderPage({
    Key key,
    @required String userName,
    @required Widget userAvatar,
  })  : this._userName = userName,
        this._userAvatar = userAvatar,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color drawerGrey = Color.fromRGBO(239, 239, 239, 1.0);

    return Container(
      padding: EdgeInsets.only(left: 16.0),
      height: 100,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: drawerGrey,
            radius: 25,
            child: _userAvatar,
          ),
          SizedBox(width: 9.0),
          Text(
            _userName,
            style: kTextStyleDrawerUsername,
          ),
          SizedBox(width: 9.0),
          Container(
            padding: EdgeInsets.fromLTRB(6.0, 4.0, 6.0, 4.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(234, 234, 234, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  bottomLeft: Radius.circular(6.0),
                  bottomRight: Radius.circular(6.0),
                )),
            child: Text('Você', style: kTextStyleDrawerUserNameTag),
          ),
        ],
      ),
    );
  }
}
