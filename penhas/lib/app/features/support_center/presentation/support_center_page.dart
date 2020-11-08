import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:penhas/app/features/authentication/presentation/shared/page_progress_indicator.dart';
import 'package:penhas/app/features/authentication/presentation/shared/snack_bar_handler.dart';
import 'package:penhas/app/features/support_center/domain/states/support_center_state.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

import 'pages/support_center_general_error.dart';
import 'pages/support_center_gps_error.dart';
import 'pages/support_center_input_filter.dart';
import 'support_center_controller.dart';

class SupportCenterPage extends StatefulWidget {
  SupportCenterPage({Key key}) : super(key: key);

  @override
  _SupportCenterPageState createState() => _SupportCenterPageState();
}

class _SupportCenterPageState
    extends ModularState<SupportCenterPage, SupportCenterController>
    with SnackBarHandler {
  List<ReactionDisposer> _disposers;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
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

  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers ??= [
      reaction((_) => controller.errorMessage, (String message) {
        showSnackBar(scaffoldKey: _scaffoldKey, message: message);
      }),
    ];
  }
}

extension _SupportCenterPageStateBuilder on _SupportCenterPageState {
  Widget bodyBuilder(SupportCenterState state) {
    return state.when(
      initial: () => Container(color: Colors.yellowAccent),
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
    if (mapController != null) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            tilt: 75.0,
            zoom: 12.0,
            bearing: 15.0,
            target: controller.initialPosition,
          ),
        ),
      );
    }
    return PageProgressIndicator(
      progressState: controller.progressState,
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: controller.initialPosition),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
          ),
          SupportCenterInputFilter(
            totalOfFilter: controller.categoriesSelected,
            onFilterAction: controller.onFilterAction,
            onKeywordsAction: controller.onKeywordsAction,
          ),
          Positioned(
            bottom: 40,
            right: 0,
            child: Container(
              child: Column(
                children: [
                  FlatButton(
                    onPressed: controller.location,
                    child: CircleAvatar(
                      radius: 12,
                      child: SvgPicture.asset(
                          "assets/images/svg/support_center/location.svg"),
                      backgroundColor: DesignSystemColors.pumpkinOrange,
                    ),
                  ),
                  FlatButton(
                    onPressed: controller.listPlaces,
                    child: CircleAvatar(
                      radius: 12,
                      child: SvgPicture.asset(
                          "assets/images/svg/support_center/list.svg"),
                      backgroundColor: DesignSystemColors.pumpkinOrange,
                    ),
                  ),
                  FlatButton(
                    onPressed: controller.addPlace,
                    child: CircleAvatar(
                      radius: 20,
                      child: SvgPicture.asset(
                          "assets/images/svg/support_center/suggest_place.svg"),
                      backgroundColor: DesignSystemColors.pumpkinOrange,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
