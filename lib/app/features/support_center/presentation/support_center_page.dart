import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/support_center/domain/states/support_center_state.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_general_error.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_gps_error.dart';
import 'package:penhas/app/features/support_center/presentation/pages/support_center_input_filter.dart';
import 'package:penhas/app/features/support_center/presentation/support_center_controller.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class SupportCenterPage extends StatefulWidget {
  const SupportCenterPage({Key? key}) : super(key: key);

  @override
  _SupportCenterPageState createState() => _SupportCenterPageState();
}

class _SupportCenterPageState
    extends ModularState<SupportCenterPage, SupportCenterController>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: height,
      width: width,
      child: Scaffold(
        key: _scaffoldKey,
        body: Observer(
          builder: (_) {
            return bodyBuilder(controller.state);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final d in _disposers!) {
      d();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => controller.errorMessage, (String? message) {
        showSnackBar(
          scaffoldKey: _scaffoldKey,
          message: message,
          duration: const Duration(seconds: 2),
        );
      }),
    ];
  }
}

extension _SupportCenterPageStateBuilder on _SupportCenterPageState {
  Widget bodyBuilder(SupportCenterState state) {
    return state.when(
      loaded: () => loadedSupportCenterPage(),
      error: (message) => SupportCenterGeneralError(
        message: message,
        onPressed: controller.retry,
      ),
      gpsError: (message) => SupportCenterGpsError(
        message: message,
        onPressed: controller.location,
      ),
    );
  }

  Widget loadedSupportCenterPage() {
    final initialPosition = controller.initialPosition;
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          tilt: 75.0,
          zoom: 12.0,
          bearing: 15.0,
          target: initialPosition,
        ),
      ),
    );
    return PageProgressIndicator(
      progressState: controller.progressState,
      progressMessage: 'Carregando',
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: initialPosition),
            myLocationEnabled: true,
            markers: controller.placeMarkers,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            onCameraMove: (CameraPosition position) {
              controller.setMapPosition(
                  LatLng(position.target.latitude, position.target.longitude));
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SupportCenterInputFilter(
                initialValue: controller.currentKeywords,
                totalOfFilter: controller.categoriesSelected,
                onFilterAction: () =>
                    _dismissSnackBarForAction(controller.onFilterAction),
                onKeywordsAction: (keywords) => _dismissSnackBarForAction(
                  controller.onKeywordsAction,
                  argument: keywords,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            right: 0,
            child: Column(
              children: [
                FlatButton(
                  onPressed: () {
                    controller.requestLocation((LatLng location) {
                      mapController!.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            tilt: 75.0,
                            zoom: 12.0,
                            bearing: 15.0,
                            target: location,
                          ),
                        ),
                      );
                    });
                  },
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: DesignSystemColors.pumpkinOrange,
                    child: SvgPicture.asset(
                      'assets/images/svg/support_center/location.svg',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () =>
                      _dismissSnackBarForAction(controller.listPlaces),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: DesignSystemColors.pumpkinOrange,
                    child: SvgPicture.asset(
                      'assets/images/svg/support_center/list.svg',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () =>
                      _dismissSnackBarForAction(controller.addPlace),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: DesignSystemColors.pumpkinOrange,
                    child: SvgPicture.asset(
                      'assets/images/svg/support_center/suggest_place.svg',
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _dismissSnackBarForAction(Function action, {dynamic argument}) {
    _scaffoldKey.currentState?.hideCurrentSnackBar();

    if (argument == null) {
      // ignore: avoid_dynamic_calls
      action();
    } else {
      // ignore: avoid_dynamic_calls
      action(argument);
    }
  }
}
