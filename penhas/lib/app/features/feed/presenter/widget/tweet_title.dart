import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';

class TweetTitle extends StatelessWidget {
  final String userName;
  final String time;
  final BuildContext rootContext;
  const TweetTitle({
    Key key,
    @required this.userName,
    @required this.time,
    @required this.rootContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(userName, style: kTextStyleFeedTweetTitle), flex: 2),
          Text(time, style: kTextStyleFeedTweetTime),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showTweetAction(),
          ),
        ],
      ),
    );
  }

  double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  void _showTweetAction() async {
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
              Container(
                width: fullWidth(context) * .2,
                height: 5,
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
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
