import 'package:flutter/material.dart';

import 'colors.dart';

const kButtonShapeFilled = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(20.0)),
);

const kButtonShapeOutlineWhite = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(20.0)),
  side: BorderSide(color: Colors.white),
);

const kButtonShapeOutlinePurple = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(20.0)),
  side: BorderSide(color: DesignSystemColors.ligthPurple),
);
