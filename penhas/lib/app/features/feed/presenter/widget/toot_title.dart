import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class TootTitle extends StatelessWidget {
  final String userName;
  final String tootTime;
  final BuildContext rootContext;
  const TootTitle({
    Key key,
    @required this.userName,
    @required this.tootTime,
    @required this.rootContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 20.0,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(userName, style: kTextStyleFeedTootTitle), flex: 2),
          Text(tootTime, style: kTextStyleFeedTootTime),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showTootAction(),
          ),
        ],
      ),
    );
  }

  void _showTootAction() async {
    await showModalBottomSheet(
      context: rootContext,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(top: 5, bottom: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 200,
          child: Column(
            children: <Widget>[
              ListTile(
                leading:
                    SvgPicture.asset('assets/images/svg/bottom_bar/chat.svg'),
                title: Text('Conversar'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.block),
                title: Text('Bloquear'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.report),
                title: Text('Reportar'),
                onTap: () {},
              )
            ],
          ),
        );
      },
    );
  }
}
