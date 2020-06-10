// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mainboard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainboardStore on _MainboardStoreBase, Store {
  final _$selectedPageAtom = Atom(name: '_MainboardStoreBase.selectedPage');

  @override
  MainboardState get selectedPage {
    _$selectedPageAtom.reportRead();
    return super.selectedPage;
  }

  @override
  set selectedPage(MainboardState value) {
    _$selectedPageAtom.reportWrite(value, super.selectedPage, () {
      super.selectedPage = value;
    });
  }

  final _$_MainboardStoreBaseActionController =
      ActionController(name: '_MainboardStoreBase');

  @override
  void changePage({@required MainboardState to}) {
    final _$actionInfo = _$_MainboardStoreBaseActionController.startAction(
        name: '_MainboardStoreBase.changePage');
    try {
      return super.changePage(to: to);
    } finally {
      _$_MainboardStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedPage: ${selectedPage}
    ''';
  }
}
