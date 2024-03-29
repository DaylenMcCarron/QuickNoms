import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:quicknoms/controller/services/locationServices/locationServices.dart';

class FullMap extends StatefulWidget {
  const FullMap();

  @override
  State createState() => FullMapState();
}

class FullMapState extends State<FullMap> {
  MapboxMap? mapboxMap;

  _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;
    var crrPositon = await LocationServices.getCurrentLocation();
    Position crrLngLat = Position(
      crrPositon.longitude,
      crrPositon.latitude,
    );
    mapboxMap.flyTo(
        CameraOptions(
            anchor: ScreenCoordinate(x: 0, y: 0),
            zoom: 15,
            pitch: 0,
            bearing: 0),
        MapAnimationOptions(duration: 2000, startDelay: 0));

    mapboxMap.setCamera(CameraOptions(
      center: Point(coordinates: crrLngLat).toJson(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapWidget(
        key: const ValueKey("mapWidget"),
        onMapCreated: _onMapCreated,
        styleUri: "mapbox://styles/daylenmccarron/clucvwagm010z01prbjl6gwsz",
        onRenderFrameStartedListener: () {}(),
      ),
    );
  }
}
