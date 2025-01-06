import 'package:flutter/material.dart';

abstract class IZodiac {
  String get name;
  Widget get icon;
  Widget get constellation;
  String get date;
  List<String> get feeling;
}
