import 'package:flutter/material.dart';

class TutorialPageViewWidget extends StatelessWidget {
  final String _title;
  final String _description;
  final Widget _bodyWidget;
  const TutorialPageViewWidget({
    Key key,
    String title,
    @required String description,
    @required Widget bodyWidget,
  })  : this._title = title,
        this._description = description,
        this._bodyWidget = bodyWidget,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 12.0,
        right: 12.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _titleBuilder(),
          SizedBox(height: 30.0),
          _bodyWidgetBuilder(),
          SizedBox(height: 30.0),
          _descriptionBuilder(),
        ],
      ),
    );
  }

  Text _descriptionBuilder() {
    return Text(
      _description,
      style: TextStyle(
        fontFamily: 'Lato',
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        color: Colors.white,
        letterSpacing: 0.12,
      ),
    );
  }

  Widget _bodyWidgetBuilder() {
    return SizedBox(
      child: Center(child: _bodyWidget),
      height: 290.0,
    );
  }

  Widget _titleBuilder() {
    return _title == null
        ? Container()
        : Center(
            child: Text(
              _title,
              style: TextStyle(
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
