import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latlng = [
    const LatLng(33.6941, 72.2562),
    const LatLng(33.6941, 72.236545),
    const LatLng(33.6941, 72.2556)
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < _latlng.length; i++) {
      if (i % 2 == 0) {
        _markers.add(
          Marker(
              markerId: MarkerId(i.toString()),
              icon: BitmapDescriptor.defaultMarker,
              position: _latlng[i],
              onTap: () {
                _customInfoWindowController.addInfoWindow!(
                    Container(
                      height: 300,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: const Center(
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue,
                        ),
                      ),
                    ),
                    _latlng[i]);
              }),
        );
      } else {
        _markers.add(Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: _latlng[i],
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                  Container(
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 300,
                            height: 100,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://picsum.photos/250?image=9'),
                                  fit: BoxFit.fitWidth,
                                  filterQuality: FilterQuality.high),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
                  _latlng[i]);
            }));

        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition:
              const CameraPosition(target: LatLng(33.6941, 72.25689), zoom: 15),
          markers: Set<Marker>.of(_markers),
          onTap: (position) {
            _customInfoWindowController.hideInfoWindow!();
          },
          onCameraMove: (position) {
            _customInfoWindowController.onCameraMove!();
          },
          onMapCreated: (GoogleMapController controller) {
            _customInfoWindowController.googleMapController = controller;
          },
        ),
        CustomInfoWindow(
          controller: _customInfoWindowController,
          height: 200,
          width: 300,
          offset: 35,
        ),
      ],
    );
  }
}
