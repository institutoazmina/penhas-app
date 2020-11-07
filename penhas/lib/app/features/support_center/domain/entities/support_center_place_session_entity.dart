import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SupportCenterPlaceSessionEntity extends Equatable {
  final bool hasMore;
  final int maximumRate;
  final double latitude;
  final double longitude;
  final String nextPage;
  final List<SupportCenterPlaceEntity> places;

  SupportCenterPlaceSessionEntity({
    this.maximumRate,
    this.latitude,
    this.longitude,
    this.nextPage,
    this.hasMore,
    this.places,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        maximumRate,
        latitude,
        longitude,
        nextPage,
        hasMore,
        places,
      ];
}

class SupportCenterPlaceEntity extends Equatable {
  final int id;
  final String rate;
  final int ratedByClient;
  final String distance;
  final double latitude;
  final double longitude;
  final String name;
  final String uf;
  final SupportCenterPlaceCategoryEntity category;

  SupportCenterPlaceEntity({
    @required this.id,
    @required this.rate,
    @required this.ratedByClient,
    @required this.distance,
    @required this.latitude,
    @required this.longitude,
    @required this.name,
    @required this.uf,
    @required this.category,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id,
        rate,
        ratedByClient,
        distance,
        latitude,
        longitude,
        name,
        uf,
      ];
}

class SupportCenterPlaceCategoryEntity extends Equatable {
  final int id;
  final String name;
  final String color;

  SupportCenterPlaceCategoryEntity({
    @required this.id,
    @required this.name,
    @required this.color,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id,
        name,
        color,
      ];
}
