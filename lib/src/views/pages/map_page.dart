import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/character_model.dart';

class MapPage extends StatelessWidget {
  final List<LTACameraObject> cameras;

  const MapPage({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map View'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(1.3521, 103.8198), // Singapore coordinates
          zoom: 12,
        ),
        markers: cameras
            .map(
              (camera) => Marker(
                markerId: MarkerId(camera.cameraId),
                position: LatLng(camera.lat, camera.lon),
                infoWindow: InfoWindow(
                  title: camera.name,
                  snippet: camera.cameraId,
                  onTap: () {
                    // Handle marker tap
                  },
                ),
                onTap: () {
                  // Handle marker tap
                },
              ),
            )
            .toSet(),
      ),
    );
  }
}
