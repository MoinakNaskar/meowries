import 'dart:async';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class getUserLocation extends StatefulWidget {
  const getUserLocation({super.key});

  @override
  State<getUserLocation> createState() => _getUserLocationState();
}

class _getUserLocationState extends State<getUserLocation> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(33.6848, 73.0479), zoom: 14);

  final List<Marker> _marker = [
    const Marker(
      markerId: MarkerId('2'),
      position: LatLng(37.122215222222, -122.256525478965),
      infoWindow: InfoWindow(title: "hello"),
    ),
    const Marker(
        markerId: MarkerId('2'),
        position: LatLng(38.122215222222, -122.256525478965),
        infoWindow: InfoWindow(title: 'bye')),
    const Marker(
        markerId: MarkerId('2'),
        position: LatLng(54, 100),
        infoWindow: InfoWindow(title: 'fuck'))
  ];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(39.122215222222, -122.256525478965),
        infoWindow: InfoWindow(title: 'bye'))
  ];

  loaddata() {
    getUserCurrentLocation().then((value) async {
      print('my current location ');
      print(value.latitude.toString() + "" + value.longitude.toString());

      _marker.add(Marker(
          markerId: const MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: "my current location")));
      CameraPosition cameraPosition = CameraPosition(
          zoom: 14, target: LatLng(value.latitude, value.longitude));

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((Value) {})
        .onError((error, StackTrace) {
      print("error" + error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initstate() {
    super.initState();
    loaddata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getUserCurrentLocation().then((value) async {
            print('my current location ');
            print(value.latitude.toString() + "" + value.longitude.toString());

            _marker.add(Marker(
                markerId: const MarkerId('2'),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: const InfoWindow(title: "my current location")));
            CameraPosition cameraPosition = CameraPosition(
                zoom: 14, target: LatLng(value.latitude, value.longitude));

            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: const Icon(Icons.local_activity),
      ),
    );
  }
}
