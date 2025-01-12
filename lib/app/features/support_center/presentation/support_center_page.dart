import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

import '../../../shared/design_system/colors.dart';
import '../../authentication/presentation/shared/page_progress_indicator.dart';
import '../../authentication/presentation/shared/snack_bar_handler.dart';
import '../domain/states/support_center_state.dart';
import 'pages/support_center_general_error.dart';
import 'pages/support_center_gps_error.dart';
import 'pages/support_center_input_filter.dart';
import 'support_center_controller.dart';

class SupportCenterPage extends StatefulWidget {
  const SupportCenterPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SupportCenterController controller;

  @override
  _SupportCenterPageState createState() => _SupportCenterPageState();
}

class _SupportCenterPageState extends State<SupportCenterPage>
    with SnackBarHandler {
  List<ReactionDisposer>? _disposers;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController? mapController;

  // Getter para acessar o controller
  SupportCenterController get controller => widget.controller;

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
    if (controller.useLatLngBounds) {
      mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(controller.latLngBounds, 10),
      );
    } else {
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
    }
    return PageProgressIndicator(
      progressState: controller.progressState,
      progressMessage: 'Carregando',
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: GoogleMap(
                initialCameraPosition: CameraPosition(target: initialPosition),
                myLocationEnabled: true,
                markers: controller.placeMarkers,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                }),
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
                TextButton(
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
                TextButton(
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
                TextButton(
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
    _scaffoldKey.hideCurrentSnackBar();

    if (argument == null) {
      // ignore: avoid_dynamic_calls
      action();
    } else {
      // ignore: avoid_dynamic_calls
      action(argument);
    }
  }
}
