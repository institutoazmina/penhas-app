import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mastodon_dart/mastodon_dart.dart';

import 'media_info.dart';

/// Shows a [_MediaScreen] containing the given Attachment.
///
/// Note: [Hero] is tagged by [Attachment.id] and must have a [BoxFit] that
/// matches it's sibling [Hero].
showMediaScreen(BuildContext context, Status status, Attachment attachment) {
  Navigator.push(
    context,
    _HeroDialogRoute(
      builder: (BuildContext context) => _MediaScreen(
        status: status,
        attachment: attachment,
      ),
    ),
  );
}

/// The media screen itself!
class _MediaScreen extends StatefulWidget {
  final Status status;
  final Attachment attachment;

  _MediaScreen({@required this.status, @required this.attachment});

  @override
  _MediaScreenState createState() => _MediaScreenState();
}

class _MediaScreenState extends State<_MediaScreen> {
  PageController _controller;

  Status get status => widget.status;
  Attachment get attachment => widget.attachment;
  int get referralIndex => status.mediaAttachments.indexOf(attachment);

  @override
  initState() {
    _controller = PageController(
      initialPage: referralIndex,

      /// >1 allows us to use [Container.margin] to add a border that
      /// is only visible while scrolling between pages
      ///
      /// `final gap = (pageWidth * _controller.viewportFraction - pageWidth);`
      viewportFraction: 1.05,
    );

    super.initState();
  }

  _handleExit() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    final gap = (pageWidth * _controller.viewportFraction - pageWidth);

    return Material(
      color: Colors.grey.shade900,
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            PageView(
              controller: _controller,

              /// Don't scroll side-to-side with 1 item
              physics: ClampingScrollPhysics(),
              children: status.mediaAttachments.map((a) {
                return Container(
                  /// Compensate for [PageController.viewportFraction]
                  margin: EdgeInsets.symmetric(horizontal: gap / 2),
                  child: Dismissible(
                    key: Key(status.id),
                    direction: DismissDirection.vertical,

                    /// Cannot be null because the hero tries to animate if it is
                    resizeDuration: Duration(microseconds: 1),
                    onDismissed: (_) => _handleExit(),
                    child: FittedBox(
                      /// The box fit has to match the sibling Hero
                      fit: BoxFit.contain,
                      child: Hero(
                        tag: a.id,
                        child: Image.network(
                          a.previewUrl.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: _handleExit,
                icon: Icon(
                  FeatherIcons.x,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: MediaInfo(
                status: status,
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// A dialog style route that uses a [PageRoute] to enable
/// the use of [Hero] dialogues.
///
/// Particularly useful for creating a [Hero] animation that
/// goes from a social-media style feed to a full-screen media view.
class _HeroDialogRoute<T> extends PageRoute<T> {
  _HeroDialogRoute({this.builder}) : super();

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => false;

  @override
  Color get barrierColor => Colors.grey.shade900;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  String get barrierLabel => "Dialog";
}
