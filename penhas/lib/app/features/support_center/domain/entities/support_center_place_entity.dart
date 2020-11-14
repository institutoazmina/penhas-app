import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:penhas/app/core/extension/safetly_parser.dart';

class SupportCenterPlaceEntity extends Equatable {
  final int id;
  final String rate;
  final int ratedByClient;
  final String distance;
  final double latitude;
  final double longitude;
  final String name;
  final String uf;
  final String fullStreet;
  final String typeOfPlace;
  final String htmlContent;
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
    @required this.fullStreet,
    @required this.category,
    @required this.typeOfPlace,
    @required this.htmlContent,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        this.id,
        this.rate,
        this.ratedByClient,
        this.distance,
        this.latitude,
        this.longitude,
        this.name,
        this.uf,
        this.fullStreet,
        this.category,
        this.typeOfPlace,
        this.htmlContent,
      ];

  static SupportCenterPlaceEntity fromJson(Map<String, Object> jsonData) {
    final id = jsonData["id"].safeParseInt();
    final rate = jsonData["avaliacao"];
    final ratedByClient = jsonData["cliente_avaliacao"].safeParseInt() ?? 0;
    final distance = jsonData["distancia"];
    final latitude = jsonData["latitude"].safeParseDouble();
    final longitude = jsonData["longitude"].safeParseDouble();
    final name = jsonData["nome"];
    final uf = jsonData["uf"];
    final category = _SupportCenterPlaceCategoryEntityParse.fromJson(
        jsonData["categoria"] as Map<String, Object>);

    final String fullStreet = _Parse.getFullAddress(jsonData);
    final typeOfPlace = jsonData["natureza"];
    final htmlContent = jsonData["content_html"];

    return SupportCenterPlaceEntity(
      id: id,
      rate: rate,
      ratedByClient: ratedByClient,
      distance: distance,
      latitude: latitude,
      longitude: longitude,
      name: name,
      uf: uf,
      fullStreet: fullStreet,
      category: category,
      typeOfPlace: typeOfPlace,
      htmlContent: htmlContent,
    );
  }
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

extension _SupportCenterPlaceCategoryEntityParse
    on SupportCenterPlaceCategoryEntity {
  static SupportCenterPlaceCategoryEntity fromJson(
      Map<String, Object> jsonData) {
    return SupportCenterPlaceCategoryEntity(
      id: jsonData['id'],
      color: jsonData['cor'],
      name: jsonData['nome'],
    );
  }
}

extension _Parse on SupportCenterPlaceEntity {
  static String getFullAddress(Map<String, Object> jsonData) {
    final String neighborhood = jsonData["bairro"] ?? "";
    final String cep = jsonData["cep"] ?? "";
    final String city = jsonData["municipio"] ?? "";
    String number = jsonData["numero"].toString() ?? "";
    final String streetName = jsonData["nome_logradouro"] ?? "";
    final String streetType = jsonData["tipo_logradouro"] ?? "";
    final String uf = jsonData["uf"] ?? "";

    final bool withoutStreetNumber = jsonData["numero_sem_numero"] == 1;
    if (withoutStreetNumber || number.isEmpty) {
      number = "s/n";
    }

    String name;
    if (streetType.isNotEmpty && streetName.isNotEmpty) {
      name = "$streetType $streetName, $number";
    }

    if (neighborhood.isNotEmpty && city.isNotEmpty && name != null) {
      name = "$name - $neighborhood, $city - ";
    }

    if (name != null && name.isNotEmpty) {
      name = "$name $uf, $cep";
    }

    return name;
  }
}
