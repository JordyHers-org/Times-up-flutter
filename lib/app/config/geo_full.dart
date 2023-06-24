import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parental_control/common_widgets/jh_pin_marker.dart';
import 'package:parental_control/services/auth.dart';
import 'package:parental_control/services/database.dart';
import 'package:parental_control/services/geo_locator_service.dart';
import 'package:parental_control/services/marker_generator_service.dart';
import 'package:parental_control/utils/constants.dart';
import 'package:provider/provider.dart';

class GeoFull extends StatefulWidget {
  final Position initialPosition;
  final Database database;
  final AuthBase auth;
  final GeoLocatorService geo;
  final List<Map<String, dynamic>> locations;

  GeoFull(
    this.initialPosition,
    this.database,
    this.auth,
    this.geo,
    this.locations,
  );

  static Widget create(
    BuildContext context, {
    required Position position,
    required Database database,
    required AuthBase auth,
    required List<Map<String, dynamic>> locations,
  }) {
    final geoService = Provider.of<GeoLocatorService>(
      context,
      listen: false,
    );

    return GeoFull(
      position,
      database,
      auth,
      geoService,
      locations,
    );
  }

  @override
  State<StatefulWidget> createState() => _GeoFullState();
}

class _GeoFullState extends State<GeoFull> {
  final Completer<GoogleMapController> _controller = Completer();
  late List<Marker> allMarkers = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() {
    widget.geo.getCurrentLocation.listen((position) {
      _centerScreen(position);
    });
    MarkerGenerator(markerWidgets(), (bitmaps) {
      setState(() {
        mapBitmapsToMarkers(bitmaps, widget.locations);
      });
    }).generate(context);
  }

  List<Widget> markerWidgets() {
    return widget.locations.map((l) => MapMarker(l['image'])).toList();
  }

  void mapBitmapsToMarkers(
    List<Uint8List> bitmaps,
    List<Map<String, dynamic>> data,
  ) {
    bitmaps.asMap().forEach((i, bmp) {
      allMarkers.add(
        Marker(
          infoWindow: InfoWindow(
            title: data[i]['id'],
            snippet: data[i]['name'],
          ),
          draggable: false,
          markerId: MarkerId(data[i]['id']),
          position: LatLng(
            data[i]['position'].latitude,
            data[i]['position'].longitude,
          ),
          icon: BitmapDescriptor.fromBytes(bmp),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        child: Center(
          child: GoogleMap(
            key: Keys.googleMapKeys,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                widget.initialPosition.latitude,
                widget.initialPosition.longitude,
              ),
              zoom: 15,
            ),
            mapType: MapType.normal,
            myLocationEnabled: true,
            markers: Set<Marker>.of(allMarkers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
    );
  }

  Future<void> _centerScreen(Position position) async {
    final controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 16.0,
        ),
      ),
    );
  }
}
