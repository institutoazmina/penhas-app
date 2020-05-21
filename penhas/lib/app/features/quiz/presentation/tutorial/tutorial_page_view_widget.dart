import 'package:flutter/material.dart';

class TutorialPageViewWidget extends StatelessWidget {
  final String _title;
  final String _description;
  final Widget _bodyWidget;
  const TutorialPageViewWidget({
    Key key,
    @required String title,
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
          Center(
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
          ),
          SizedBox(height: 30.0),
          SizedBox(
            child: Center(child: _bodyWidget),
            height: 290.0,
          ),
          SizedBox(height: 30.0),
          Text(
            _description,
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
              letterSpacing: 0.12,
            ),
          ),
        ],
      ),
    );
  }
}
