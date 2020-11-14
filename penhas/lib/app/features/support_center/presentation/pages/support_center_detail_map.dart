import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:penhas/app/features/support_center/domain/entities/support_center_place_detail_entity.dart';
import 'package:penhas/app/shared/design_system/colors.dart';

class SupportCenterDetailMap extends StatelessWidget {
  final SupportCenterPlaceDetailEntity detail;

  const SupportCenterDetailMap({
    Key key,
    @required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LatLng position = LatLng(
      detail.place.latitude,
      detail.place.longitude,
    );

    final cameraPosition = CameraPosition(
      zoom: 15.0,
      target: position,
    );

    final placeColor = HSLColor.fromColor(
      DesignSystemColors.hexColor(detail.place.category.color),
    );

    final Set<Marker> markers = Set<Marker>.from(
      [
        Marker(
          position: position,
          markerId: MarkerId(position.toString()),
          infoWindow: InfoWindow(title: detail.place.name),
          icon: BitmapDescriptor.defaultMarkerWithHue(placeColor.hue),
        )
      ],
    );

    return SafeArea(
        child: Column(
      children: [
        Container(
          height: 160,
          child: GoogleMap(
            initialCameraPosition: cameraPosition,
            compassEnabled: false,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            scrollGesturesEnabled: false,
            mapType: MapType.normal,
            markers: markers,
            zoomGesturesEnabled: false,
            zoomControlsEnabled: false,
          ),
        ),
      ],
    ));
  }
}
