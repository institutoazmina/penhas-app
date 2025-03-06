// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mainboard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainboardStore on _MainboardStoreBase, Store {
  late final _$pagesAtom =
      Atom(name: '_MainboardStoreBase.pages', context: context);

  @override
  ObservableList<MainboardState> get pages {
    _$pagesAtom.reportRead();
    return super.pages;
  }

  @override
  set pages(ObservableList<MainboardState> value) {
    _$pagesAtom.reportWrite(value, super.pages, () {
      super.pages = value;
    });
  }

  late final _$selectedPageAtom =
      Atom(name: '_MainboardStoreBase.selectedPage', context: context);

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

  late final _$changePageAsyncAction =
      AsyncAction('_MainboardStoreBase.changePage', context: context);

  @override
  Future<dynamic> changePage({required MainboardState to}) {
    return _$changePageAsyncAction.run(() => super.changePage(to: to));
  }

  @override
  String toString() {
    return '''
pages: ${pages},
selectedPage: ${selectedPage}
    ''';
  }
}
