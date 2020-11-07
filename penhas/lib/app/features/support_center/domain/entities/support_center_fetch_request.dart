import 'package:equatable/equatable.dart';
import 'package:penhas/app/core/entities/user_location.dart';

class SupportCenterFetchRequest extends Equatable {
  final UserLocationEntity userLocation;
  final String locationToken;
  final List<String> categories;
  final String keywords;
  final String nextPage;
  final int rows;

  SupportCenterFetchRequest({
    this.userLocation,
    this.locationToken,
    this.categories,
    this.keywords,
    this.nextPage,
    this.rows = 5000,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        this.userLocation,
        this.locationToken,
        this.categories,
        this.keywords,
        this.nextPage,
        this.rows
      ];
}
