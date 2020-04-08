import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mastodon_dart/mastodon_dart.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:html/parser.dart';

/// This widget shows information about the current Media
/// at the bottom of the MediaScreen
class MediaInfo extends StatefulWidget {
  final Status status;
  MediaInfo({@required this.status});

  @override
  _MediaInfoState createState() => _MediaInfoState();
}

class _MediaInfoState extends State<MediaInfo> {
  bool isVisible = false;

  Status get status => widget.status;

  String get name => status?.account?.displayName;
  String get username => status?.account?.username;

  String get timestamp => timeago
      .format(status?.createdAt, locale: "en_short")
      .replaceAll(" ", "")
      .replaceAll("~", "");

  String get content => parse(status?.content).documentElement.text;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 300)).then((_) {
      setState(() {
        isVisible = true;
      });
    });

    super.initState();
  }

  _handleTap() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 6.0,
          sigmaY: 6.0,
        ),
        child: GestureDetector(
          onTap: _handleTap,
          child: AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 300),
            child: AnimatedContainer(
              transform: Matrix4.translationValues(
                0.0,
                isVisible ? 0.0 : 100,
                0.0,
              ),
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,

              ///
              color: Colors.black54,
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(status.account.avatarStatic.toString()),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "$name ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          TextSpan(text: "@$username · $timestamp"),
                          TextSpan(text: "\n"),
                          TextSpan(text: content),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
