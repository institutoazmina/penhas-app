import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:penhas/app/shared/design_system/text_styles.dart';
import 'package:timeago/timeago.dart' as timeago;

class TweetTitle extends StatelessWidget {
  final String userName;
  final String time;
  final BuildContext rootContext;
  const TweetTitle({
    Key key,
    @required this.userName,
    @required this.time,
    @required BuildContext context,
  })  : rootContext = context,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(userName, style: kTextStyleFeedTweetTitle), flex: 2),
          _buildTime(),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showTweetAction(),
          ),
        ],
      ),
    );
  }

  Widget _buildTime() {
    timeago.setLocaleMessages('pt_br', timeago.PtBrMessages());
    final parsedTime = _mapServerUtcToLocalDate(time);
    return Text(timeago.format(parsedTime, locale: 'pt_br'),
        style: kTextStyleFeedTweetTime);
  }

  DateTime _mapServerUtcToLocalDate(String time) {
    final utcEnabled = "${time}Z";

    return DateTime.parse(utcEnabled).toLocal();
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
