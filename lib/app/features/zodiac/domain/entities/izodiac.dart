import 'package:flutter/material.dart';

abstract class IZodiac {
  String get name;
  Widget get icone;
  Widget get constelation;
  String get date;
  List<String> get feeling;
}
