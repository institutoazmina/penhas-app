// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserProfileController on _UserProfileControllerBase, Store {
  final _$personAtom = Atom(name: '_UserProfileControllerBase.person');

  @override
  UserDetailProfileEntity get person {
    _$personAtom.reportRead();
    return super.person;
  }

  @override
  set person(UserDetailProfileEntity value) {
    _$personAtom.reportWrite(value, super.person, () {
      super.person = value;
    });
  }

  @override
  String toString() {
    return '''
person: ${person}
    ''';
  }
}
