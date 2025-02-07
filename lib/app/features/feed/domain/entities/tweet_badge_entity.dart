import 'package:equatable/equatable.dart';

abstract class TweetBadges extends Equatable {}

class TweetBadgeEntity extends TweetBadges {
  TweetBadgeEntity(
      {required this.code,
      required this.description,
      required this.imageUrl,
      required this.name,
      required this.style,
      required this.showDescription,
      required this.popUp});

  final String code;
  final String description;
  final String imageUrl;
  final String name;
  final String style;
  final int showDescription;
  final int popUp;

  @override
  List<Object?> get props =>
      [code, description, imageUrl, name, style, showDescription, popUp];
}
