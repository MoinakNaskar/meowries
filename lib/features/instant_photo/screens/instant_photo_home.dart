import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InstantPhotoHome extends StatefulWidget {
  const InstantPhotoHome({super.key});

  @override
  State<InstantPhotoHome> createState() => _InstantPhotoHomeState();
}

class _InstantPhotoHomeState extends State<InstantPhotoHome> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(37.122215222222, -122.256525478965), zoom: 14.4856);

  final List<Marker> _marker = [
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(37.122215222222, -122.256525478965),
      infoWindow: InfoWindow(title: "hello"),
    ),
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(38.122215222222, -122.256525478965),
        infoWindow: InfoWindow(title: 'bye')),
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(54, 100),
        infoWindow: InfoWindow(title: 'fuck'))
  ];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(39.122215222222, -122.256525478965),
        infoWindow: InfoWindow(title: 'bye'))
  ];
  @override
  void initstate() {
    super.initState();
    _marker.addAll(_list);
    print(_marker.toString());
  }

  @override
  // ignore: unused_element
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          compassEnabled: true,
          myLocationButtonEnabled: true,
          markers: Set<Marker>.of(_marker),
          mapType: MapType.hybrid,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(
            const CameraPosition(target: LatLng(54, 100), zoom: 14)));
        setState(() {});
      }),
    );
  }
}
