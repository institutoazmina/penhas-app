// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter_test/flutter_test.dart';
import 'package:penhas/app/core/entities/user_location.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_fetch_request.dart';

void main() {
  group(SupportCenterFetchRequest, () {
    test('copyWith updates specified fields', () {
      final request = SupportCenterFetchRequest(
        userLocation: UserLocationEntity(latitude: 1.0, longitude: 2.0),
        locationToken: 'token',
        categories: ['cat1', 'cat2'],
        keywords: 'keyword',
        nextPage: 'next',
        rows: 5000,
      );

      final copied = request.copyWith(
        userLocation: UserLocationEntity(latitude: 3.0, longitude: 4.0),
        locationToken: 'newToken',
        categories: ['cat3', 'cat4'],
        keywords: 'newKeyword',
        nextPage: 'newNext',
        rows: 3000,
      );

      expect(copied.userLocation,
          equals(UserLocationEntity(latitude: 3.0, longitude: 4.0)));
      expect(copied.locationToken, 'newToken');
      expect(copied.categories, equals(['cat3', 'cat4']));
      expect(copied.keywords, 'newKeyword');
      expect(copied.nextPage, 'newNext');
      expect(copied.rows, 3000);

      // Check for equality when instances have the same properties
      expect(copied, equals(copied.copyWith()));

      // Check for non-equality when instances have different properties
      expect(copied, isNot(equals(request)));
    });

    test('copyWith does not change unspecified fields', () {
      final request = SupportCenterFetchRequest(
        userLocation: UserLocationEntity(latitude: 1.0, longitude: 2.0),
        locationToken: 'token',
        categories: ['cat1', 'cat2'],
        keywords: 'keyword',
        nextPage: 'next',
        rows: 5000,
      );

      final copied = request.copyWith();

      expect(copied.userLocation,
          equals(UserLocationEntity(latitude: 1.0, longitude: 2.0)));
      expect(copied.locationToken, 'token');
      expect(copied.categories, equals(['cat1', 'cat2']));
      expect(copied.keywords, 'keyword');
      expect(copied.nextPage, 'next');
      expect(copied.rows, 5000);

      // Check for equality when instances have the same properties
      expect(copied, equals(request));

      // Check for non-equality when instances have different properties
      expect(copied, isNot(equals(request.copyWith(keywords: 'newKeyword'))));
    });
  });
}
