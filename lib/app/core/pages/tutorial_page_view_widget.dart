import 'package:flutter/material.dart';

class TutorialPageViewWidget extends StatelessWidget {
  const TutorialPageViewWidget({
    super.key,
    String? title,
    required String description,
    required Widget bodyWidget,
  })  : _title = title,
        _description = description,
        _bodyWidget = bodyWidget;

  final String? _title;
  final String _description;
  final Widget _bodyWidget;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 12.0,
        ),
        child: Column(
          children: <Widget>[
            _titleBuilder(),
            if (_title == null) Container() else const SizedBox(height: 28.0),
            _bodyWidgetBuilder(),
            const SizedBox(height: 28.0),
            _descriptionBuilder(),
          ],
        ),
      ),
    );
  }

  Text _descriptionBuilder() {
    return Text(
      _description,
      style: const TextStyle(
        fontFamily: 'Lato',
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        letterSpacing: 0.44,
      ),
    );
  }

  Widget _bodyWidgetBuilder() {
    return Center(child: _bodyWidget);
  }

  Widget _titleBuilder() {
    return _title == null
        ? Container()
        : Center(
            child: Text(
              _title,
              style: const TextStyle(
                fontFamily: 'Lato',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.15,
              ),
            ),
          );
  }
}
