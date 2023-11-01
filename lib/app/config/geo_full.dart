import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:times_up_flutter/common_widgets/jh_pin_marker.dart';
import 'package:times_up_flutter/services/auth.dart';
import 'package:times_up_flutter/services/database.dart';
import 'package:times_up_flutter/services/geo_locator_service.dart';
import 'package:times_up_flutter/services/marker_generator_service.dart';
import 'package:times_up_flutter/utils/constants.dart';

class GeoFull extends StatefulWidget {
  const GeoFull(
    this.initialPosition,
    this.database,
    this.auth,
    this.geo,
    this.locations, {
    Key? key,
  }) : super(key: key);
  final Position initialPosition;
  final Database database;
  final AuthBase auth;
  final GeoLocatorService geo;
  final List<Map<String, dynamic>> locations;

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
    widget.geo.getCurrentLocation.listen(_centerScreen);
    MarkerGenerator(markerWidgets(), (bitmaps) {
      setState(() {
        mapBitmapsToMarkers(bitmaps, widget.locations);
      });
    }).generate(context);
  }

  List<Widget> markerWidgets() {
    return widget.locations
        .map((l) => MapMarker(l['image'].toString()))
        .toList();
  }

  void mapBitmapsToMarkers(
    List<Uint8List> bitmaps,
    List<Map<String, dynamic>> data,
  ) {
    bitmaps.asMap().forEach((i, bmp) {
      allMarkers.add(
        Marker(
          infoWindow: InfoWindow(
            title: data[i]['id'] as String,
            snippet: data[i]['name'] as String,
          ),
          markerId: MarkerId(data[i]['id'] as String),
          position: LatLng(
            // ignore: avoid_dynamic_calls
            data[i]['position'].latitude as double,
            // ignore: avoid_dynamic_calls
            data[i]['position'].longitude as double,
          ),
          icon: BitmapDescriptor.fromBytes(bmp),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
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
            myLocationEnabled: true,
            markers: Set<Marker>.of(allMarkers),
            onMapCreated: _controller.complete,
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
          zoom: 16,
        ),
      ),
    );
  }
}
