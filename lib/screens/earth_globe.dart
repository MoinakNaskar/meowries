import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';

class EarthGlobe extends StatelessWidget {
  const EarthGlobe({super.key});

  @override
  Widget build(BuildContext context) {
    return Cube(
      onSceneCreated: (Scene scene) {
        scene.world.add(Object(fileName: 'assets/earth.glb'));
        scene.camera.zoom = 10;
      },
    );
  }
}
