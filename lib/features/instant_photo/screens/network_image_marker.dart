import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NetworkImageCustomMarker extends StatefulWidget {
  const NetworkImageCustomMarker({super.key});

  @override
  State<NetworkImageCustomMarker> createState() =>
      _NetworkImageCustomMarkerState();
}

class _NetworkImageCustomMarkerState extends State<NetworkImageCustomMarker> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGoogleplex =
      CameraPosition(target: LatLng(33.6941, 72.9734));

  final List<Marker> _markers = <Marker>[];

  final List<LatLng> _latlng = [
    const LatLng(33.2568, 72.2569),
    const LatLng(33.7568, 72.2669),
    const LatLng(33.5568, 72.2169),
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < _latlng.length; i++) {
      Uint8List? image = await loadNetworkImage(
          'https://cdn.pixabay.com/photo/2024/02/15/15/46/cat-8575641_640.jpg');
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
          image!.buffer.asUint8List(),
          targetHeight: 100,
          targetWidth: 100);
      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData =
          await frameInfo.image.toByteData(format: ui.ImageByteFormat.png);

      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();
      _markers.add(Marker(
          markerId: MarkerId(i.toString()),
          position: _latlng[i],
          icon: BitmapDescriptor.fromBytes(resizedImageMarker),
          infoWindow: InfoWindow(snippet: 'title of snippet' + i.toString())));
      setState(() {});
    }
  }

  Future<Uint8List> loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);

    image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));

    final imageInfo = await completer.future;
    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GoogleMap(
        initialCameraPosition: _kGoogleplex,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      )),
    );
  }
}
