// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_center_location_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SupportCenterLocationController
    on _SupportCenterLocationControllerBase, Store {
  Computed<PageProgressState> _$progressStateComputed;

  @override
  PageProgressState get progressState => (_$progressStateComputed ??=
          Computed<PageProgressState>(() => super.progressState,
              name: '_SupportCenterLocationControllerBase.progressState'))
      .value;

  final _$_getGeoTokenAtom =
      Atom(name: '_SupportCenterLocationControllerBase._getGeoToken');

  @override
  ObservableFuture<Either<Failure, GeolocationEntity>> get _getGeoToken {
    _$_getGeoTokenAtom.reportRead();
    return super._getGeoToken;
  }

  @override
  set _getGeoToken(ObservableFuture<Either<Failure, GeolocationEntity>> value) {
    _$_getGeoTokenAtom.reportWrite(value, super._getGeoToken, () {
      super._getGeoToken = value;
    });
  }

  final _$stateAtom = Atom(name: '_SupportCenterLocationControllerBase.state');

  @override
  SupportCenterLocationState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(SupportCenterLocationState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$seletedAddressAsyncAction =
      AsyncAction('_SupportCenterLocationControllerBase.seletedAddress');

  @override
  Future<void> seletedAddress() {
    return _$seletedAddressAsyncAction.run(() => super.seletedAddress());
  }

  final _$_SupportCenterLocationControllerBaseActionController =
      ActionController(name: '_SupportCenterLocationControllerBase');

  @override
  void setCep(String cep) {
    final _$actionInfo = _$_SupportCenterLocationControllerBaseActionController
        .startAction(name: '_SupportCenterLocationControllerBase.setCep');
    try {
      return super.setCep(cep);
    } finally {
      _$_SupportCenterLocationControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
progressState: ${progressState}
    ''';
  }
}
