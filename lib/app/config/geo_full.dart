import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:times_up_flutter/common_widgets/jh_display_text.dart';
import 'package:times_up_flutter/common_widgets/jh_header_widget.dart';
import 'package:times_up_flutter/common_widgets/jh_pin_marker.dart';
import 'package:times_up_flutter/services/auth.dart';
import 'package:times_up_flutter/services/database.dart';
import 'package:times_up_flutter/services/geo_locator_service.dart';
import 'package:times_up_flutter/services/marker_generator_service.dart';
import 'package:times_up_flutter/theme/theme.dart';
import 'package:times_up_flutter/utils/constants.dart';

import '../../common_widgets/jh_animated_green_dot.dart';

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

class _GeoFullState extends State<GeoFull> with SingleTickerProviderStateMixin {
  final Completer<GoogleMapController> _controller = Completer();
  late final AnimationController _animationController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late bool isBottomSheetEnabled = false;
  late List<Marker> allMarkers = [];
  String childAddress = 'No Address !';
  String lightMapTheme = '';
  String darkMapTheme = '';

  @override
  void initState() {
    _init();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _init() {
    _setMapTheme();
    widget.geo.getCurrentLocation.listen(_centerScreen);
    MarkerGenerator(markerWidgets(), (bitmaps) {
      setState(() {
        mapBitmapsToMarkers(bitmaps, widget.locations);
      });
    }).generate(context);
  }

  void _setMapTheme() {
    DefaultAssetBundle.of(context)
        .loadString('assets/map_theme/light_theme.json')
        .then((value) => lightMapTheme = value);

    DefaultAssetBundle.of(context)
        .loadString('assets/map_theme/dark_theme.json')
        .then((value) => darkMapTheme = value);
  }

  Future<void> _getAddressName(Map<String, dynamic> child) async {
    final placeMarks = await placemarkFromCoordinates(
      child['position'].latitude as double,
      child['position'].longitude as double,
    );

    if (placeMarks.isNotEmpty) {
      childAddress =
          '${placeMarks.first.street} ${placeMarks.first.postalCode} '
          '${placeMarks.first.country}';
    }
  }

  List<Widget> markerWidgets() {
    return widget.locations
        .map((l) => MapMarker(l['image'].toString()))
        .toList();
  }

  void _showBottomSheet(BuildContext context, Map<String, dynamic> child) {
    if (!isBottomSheetEnabled) {
      _scaffoldKey.currentState?.showBottomSheet<void>(
        (context) => FutureBuilder<void>(
          future: _getAddressName(child),
          builder: (context, snapshot) {
            return BottomSheet(
              animationController: _animationController,
              dragHandleSize: const Size(60, 15),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              showDragHandle: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              onClosing: () {
                _dismissBottomSheet(context);
              },
              builder: (BuildContext context) => Container(
                height: 200,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        JHDisplayText(
                          text: child['id'].toString(),
                          fontSize: 23,
                          style: const TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w500,
                          ),
                        ).hP16,
                        AnimatedGreenDot()
                      ],
                    ).hP8,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 300,
                          child: HeaderWidget(
                            title: 'Address',
                            subtitle: childAddress,
                          ),
                        ),
                        Icon(
                          Icons.verified,
                          color: Colors.greenAccent.shade700,
                        ),
                        const SizedBox(width: 4)
                      ],
                    ),
                    HeaderWidget(
                      title: 'Child ',
                      subtitle: child['name'].toString(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      );
      isBottomSheetEnabled = !isBottomSheetEnabled;
    } else {
      _dismissBottomSheet(context);
    }
  }

  void _dismissBottomSheet(BuildContext context) {
    if (mounted) {
      setState(() {
        Navigator.of(context).pop();
        isBottomSheetEnabled = !isBottomSheetEnabled;
      });
    }
  }

  void mapBitmapsToMarkers(
    List<Uint8List> bitmaps,
    List<Map<String, dynamic>> data,
  ) {
    bitmaps.asMap().forEach((i, bmp) {
      allMarkers.add(
        Marker(
          onTap: () => _showBottomSheet(context, data[i]),
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
      child: Scaffold(
        key: _scaffoldKey,
        body: SizedBox(
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
              onMapCreated: (controller) async {
                if (Theme.of(context).brightness == Brightness.light) {
                  await controller.setMapStyle(lightMapTheme);
                } else {
                  await controller.setMapStyle(darkMapTheme);
                }
                _controller.complete;
              },
            ),
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
