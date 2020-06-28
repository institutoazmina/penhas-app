import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class TweetFilterSessionEntity extends Equatable {
  final List<TweetFilterCategory> categories;
  final List<TweetFilterTag> tags;

  TweetFilterSessionEntity({
    @required this.categories,
    @required this.tags,
  });

  @override
  List<Object> get props => [categories, tags];
}

@immutable
class TweetFilterCategory extends Equatable {
  final String id;
  final String label;
  final bool isDefault;

  TweetFilterCategory({
    @required this.id,
    @required this.label,
    @required this.isDefault,
  });

  @override
  List<Object> get props => [id, label, isDefault];

  @override
  bool get stringify => true;
}

@immutable
class TweetFilterTag extends Equatable {
  final String id;
  final String title;

  TweetFilterTag({@required this.id, @required this.title});

  @override
  List<Object> get props => [id, title];

  @override
  bool get stringify => true;
}
