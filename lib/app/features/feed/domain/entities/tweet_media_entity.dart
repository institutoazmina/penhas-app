import 'package:equatable/equatable.dart';

class TweetMediaEntity extends Equatable {
  const TweetMediaEntity({
    required this.sd,
    required this.hd,
  });

  final String sd;
  final String hd;

  @override
  List<Object?> get props => [sd, hd];
}
