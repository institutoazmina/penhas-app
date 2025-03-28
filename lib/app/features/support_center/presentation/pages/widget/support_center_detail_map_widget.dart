import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../shared/design_system/colors.dart';
import '../../../domain/entities/support_center_place_detail_entity.dart';

class SupportCenterDetailMapWidget extends StatelessWidget {
  const SupportCenterDetailMapWidget({
    super.key,
    required this.detail,
  });

  final SupportCenterPlaceDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    final LatLng position = LatLng(
      detail.place!.latitude!,
      detail.place!.longitude!,
    );

    final cameraPosition = CameraPosition(
      zoom: 15.0,
      target: position,
    );

    final placeColor = HSLColor.fromColor(
      DesignSystemColors.hexColor(detail.place!.category.color!),
    );

    final Set<Marker> markers = <Marker>{
      Marker(
        position: position,
        markerId: MarkerId(position.toString()),
        infoWindow: InfoWindow(title: detail.place!.name),
        icon: BitmapDescriptor.defaultMarkerWithHue(placeColor.hue),
      )
    };

    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 160,
            child: GoogleMap(
              initialCameraPosition: cameraPosition,
              compassEnabled: false,
              myLocationButtonEnabled: false,
              scrollGesturesEnabled: false,
              markers: markers,
              zoomGesturesEnabled: false,
              zoomControlsEnabled: false,
            ),
          ),
        ],
      ),
    );
  }
}
