// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_center_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SupportCenterListController on _SupportCenterListControllerBase, Store {
  final _$placesAtom = Atom(name: '_SupportCenterListControllerBase.places');

  @override
  ObservableList<SupportCenterPlaceEntity> get places {
    _$placesAtom.reportRead();
    return super.places;
  }

  @override
  set places(ObservableList<SupportCenterPlaceEntity> value) {
    _$placesAtom.reportWrite(value, super.places, () {
      super.places = value;
    });
  }

  final _$_SupportCenterListControllerBaseActionController =
      ActionController(name: '_SupportCenterListControllerBase');

  @override
  void selected(SupportCenterPlaceEntity place) {
    final _$actionInfo = _$_SupportCenterListControllerBaseActionController
        .startAction(name: '_SupportCenterListControllerBase.selected');
    try {
      return super.selected(place);
    } finally {
      _$_SupportCenterListControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
places: ${places}
    ''';
  }
}
