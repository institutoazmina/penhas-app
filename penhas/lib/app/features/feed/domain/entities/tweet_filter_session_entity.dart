import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class TweetFilterSessionEntity extends Equatable {
  final List<TweetFilterEntity> categories;
  final List<TweetFilterEntity> tags;

  const TweetFilterSessionEntity({
    required this.categories,
    required this.tags,
  });

  @override
  List<Object?> get props => [categories, tags];

  @override
  bool get stringify => true;
}

@immutable
class TweetFilterEntity extends Equatable {
  final String id;
  final String? label;
  final bool isSelected;

  const TweetFilterEntity({
    required this.id,
    required this.label,
    required this.isSelected,
  });

  @override
  List<Object?> get props => [id, label!, isSelected];

  @override
  bool get stringify => true;

  TweetFilterEntity copyWith({String? id, String? label, bool? isSelected}) {
    return TweetFilterEntity(
        id: id ?? this.id,
        label: label ?? this.label,
        isSelected: isSelected ?? this.isSelected,);
  }
}
