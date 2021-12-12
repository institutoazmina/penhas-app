import 'package:equatable/equatable.dart';
import 'package:penhas/app/core/extension/safetly_parser.dart';

class SupportCenterPlaceEntity extends Equatable {
  final int? id;
  final String? rate;
  final int ratedByClient;
  final String? distance;
  final double? latitude;
  final double? longitude;
  final String? name;
  final String? uf;
  final String? fullStreet;
  final String? typeOfPlace;
  final String? htmlContent;
  final SupportCenterPlaceCategoryEntity category;

  SupportCenterPlaceEntity({
    required this.id,
    required this.rate,
    required this.ratedByClient,
    required this.distance,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.uf,
    required this.fullStreet,
    required this.category,
    required this.typeOfPlace,
    required this.htmlContent,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        this.id!,
        this.rate!,
        this.ratedByClient,
        this.distance!,
        this.latitude!,
        this.longitude!,
        this.name!,
        this.uf!,
        this.fullStreet!,
        this.category,
        this.typeOfPlace!,
        this.htmlContent!,
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

    final String? fullStreet = _Parse.getFullAddress(jsonData);
    final typeOfPlace = jsonData["natureza"];
    final htmlContent = jsonData["content_html"];

    return SupportCenterPlaceEntity(
      id: id,
      rate: rate as String?,
      ratedByClient: ratedByClient,
      distance: distance as String?,
      latitude: latitude,
      longitude: longitude,
      name: name as String?,
      uf: uf as String?,
      fullStreet: fullStreet,
      category: category,
      typeOfPlace: typeOfPlace as String?,
      htmlContent: htmlContent as String?,
    );
  }

class SupportCenterPlaceCategoryEntity extends Equatable {
  final int? id;
  final String? name;
  final String? color;

  SupportCenterPlaceCategoryEntity({
    required this.id,
    required this.name,
    required this.color,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id!,
        name!,
        color!,
      ];
}

class SupportCenterPlaceCategoryEntity extends Equatable {
  const SupportCenterPlaceCategoryEntity({
    required this.id,
    required this.name,
    required this.color,
  });

  final int? id;
  final String? name;
  final String? color;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, color];
}

extension _SupportCenterPlaceCategoryEntityParse
    on SupportCenterPlaceCategoryEntity {
  static SupportCenterPlaceCategoryEntity fromJson(
    Map<String, dynamic> jsonData,
  ) {
    return SupportCenterPlaceCategoryEntity(
      id: jsonData['id'] as int?,
      color: jsonData['cor'] as String?,
      name: jsonData['nome'] as String?,
    );
  }
}

extension _Parse on SupportCenterPlaceEntity {
  static String? getFullAddress(Map<String, dynamic> jsonData) {
    final String neighborhood = jsonData["bairro"] as String? ?? "";
    final String cep = jsonData["cep"] as String? ?? "";
    final String city = jsonData["municipio"] as String? ?? "";
    String number = jsonData.containsKey("numero") && jsonData["numero"] != null
        ? "${jsonData["numero"]}"
        : "";
    final String streetName = jsonData["nome_logradouro"] as String? ?? "";
    final String streetType = jsonData["tipo_logradouro"] as String? ?? "";
    final String uf = jsonData["uf"] as String? ?? "";

    final bool withoutStreetNumber = jsonData["numero_sem_numero"] == 1;
    if (withoutStreetNumber || number.isEmpty) {
      number = 's/n';
    }

    String? name;
    if (streetType.isNotEmpty && streetName.isNotEmpty) {
      name = '$streetType $streetName, $number';
    }

    if (neighborhood.isNotEmpty && city.isNotEmpty && name != null) {
      name = '$name - $neighborhood, $city - ';
    }

    if (name != null && name.isNotEmpty) {
      name = '$name $uf, $cep';
    }

    return name;
  }
}
