import 'package:equatable/equatable.dart';
import 'package:penhas/app/core/entities/user_location.dart';

class SupportCenterFetchRequest extends Equatable {
  final UserLocationEntity? userLocation;
  final String? locationToken;
  final List<String>? categories;
  final String? keywords;
  final String? nextPage;
  final int? rows;

  const SupportCenterFetchRequest({
    this.userLocation,
    this.locationToken,
    this.categories,
    this.keywords,
    this.nextPage,
    this.rows = 5000,
  });

  final UserLocationEntity? userLocation;
  final String? locationToken;
  final List<String>? categories;
  final String? keywords;
  final String? nextPage;
  final int? rows;

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        userLocation!,
        locationToken!,
        categories!,
        keywords!,
        nextPage!,
        rows!
      ];

  SupportCenterFetchRequest copyWith({
    UserLocationEntity? userLocation,
    String? locationToken,
    List<String>? categories,
    String? keywords,
    String? nextPage,
    int? rows,
  }) {
    return SupportCenterFetchRequest(
      userLocation: userLocation ?? this.userLocation,
      locationToken: locationToken ?? this.locationToken,
      categories: categories ?? this.categories,
      keywords: keywords ?? this.keywords,
      nextPage: nextPage ?? this.nextPage,
      rows: rows ?? rows,
    );
  }
}
