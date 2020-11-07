import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class SupportCenterPlaceSessionEntity extends Equatable {
  final int id;
  final String maximumRate;
  final String latitude;
  final String longitude;
  final String nextPage;
  final List<SupportCenterPlaceEntity> places;

  SupportCenterPlaceSessionEntity({
    this.id,
    this.maximumRate,
    this.latitude,
    this.longitude,
    this.nextPage,
    this.places,
  });

  @override
  List<Object> get props => [
        id,
        maximumRate,
        latitude,
        longitude,
        nextPage,
        places,
      ];
}

class SupportCenterPlaceEntity extends Equatable {
  final int id;
  final String rate;
  final int ratedByClient;
  final String distance;
  final String latitude;
  final String longitude;
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
  List<Object> get props => [
        id,
        name,
        color,
      ];
}
