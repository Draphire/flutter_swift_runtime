import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';

// Model
import '../../models/character_model.dart';
import '../../views/components/custom_info_window.dart';
import '../../views/components/list.dart'; // Import the new list view

class MapPage extends StatefulWidget {
  final List<LTACameraObject> cameras;
  final Function() fetchCameraData;
  final Function(String) onSearch;

  const MapPage(
      {Key? key,
      required this.cameras,
      required this.fetchCameraData,
      required this.onSearch})
      : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  late ClusterManager _manager;
  Set<Marker> markers = Set();
  bool _isInfoWindowVisible = false;
  LatLng? _infoWindowPosition;
  LTACameraObject? _selectedCamera;

  @override
  void initState() {
    super.initState();
    _manager = _initClusterManager();
  }

  ClusterManager _initClusterManager() {
    return ClusterManager<LTACameraObject>(widget.cameras, _updateMarkers,
        markerBuilder: _markerBuilder, stopClusteringZoom: 13.0);
  }

  void _updateMarkers(Set<Marker> markers) {
    print('Updated ${markers.length} markers');
    setState(() {
      this.markers = markers;
    });
  }

  void _updateClusterManager() {
    setState(() {
      _manager = _initClusterManager();
      _manager.updateMap();
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    _manager.setMapId(controller.mapId);
  }

  Future<Marker> Function(Cluster<LTACameraObject>) get _markerBuilder =>
      (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () => _onClusterTapped(cluster),
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
              text: cluster.isMultiple ? cluster.count.toString() : null),
        );
      };

  // void _onClusterTapped(Cluster<LTACameraObject> cluster) {
  //   if (cluster.isMultiple) {
  //     // Navigator.push(
  //     //   context,
  //     //   MaterialPageRoute(
  //     //     builder: (context) => MyList(
  //     //       cameras: cluster.items.toList(),
  //     //       fetchCameraData: () => widget.fetchCameraData(),
  //     //       onSearch: (input) => widget.onSearch(
  //     //           input), // Set this to true if you want to show grid view
  //     //     ),
  //     //   ),
  //     // );
  //     showModalBottomSheet(
  //       context: context,
  //       builder: (context) => MyList(
  //         cameras: cluster.items.toList(),
  //         fetchCameraData: () => widget.fetchCameraData(),
  //         onSearch: (input) => widget.onSearch(input),
  //       ),
  //     ).whenComplete(() {
  //       // Re-initialize the cluster manager with the updated camera data
  //       _manager = _initClusterManager();
  //     });
  //     ;
  //   } else {
  //     _onMarkerTapped(cluster.items.first);
  //   }
  // }

  void _onClusterTapped(Cluster<LTACameraObject> cluster) {
    if (cluster.isMultiple) {
      showModalBottomSheet(
        context: context,
        builder: (context) => MyList(
          cameras: cluster.items.toList(),
          fetchCameraData: () {
            widget.fetchCameraData();
            // _updateClusterManager();
          },
          onSearch: (input) {
            widget.onSearch(input);
            // _updateClusterManager();
          },
        ),
      ).whenComplete(() {
        // _updateClusterManager();
      });
    } else {
      _onMarkerTapped(cluster.items.first);
    }
  }

  void _onMarkerTapped(LTACameraObject camera) {
    setState(() {
      _isInfoWindowVisible = true;
      _infoWindowPosition = LatLng(camera.lat, camera.lon);
      _selectedCamera = camera;
    });
  }

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.cyan;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  void _showCameraDetails(LTACameraObject camera) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(camera.image),
              SizedBox(height: 16.0),
              Text(camera.name,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text(camera.timestamp),
              SizedBox(height: 8.0),
              Text('Camera ID: ${camera.cameraId}'),
            ],
          ),
        );
      },
    );
  }

  void _closeInfoWindow() {
    if (_isInfoWindowVisible) {
      setState(() {
        _isInfoWindowVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: LatLng(
                  1.3521, 103.8198), // Singapore's latitude and longitude
              zoom: 11,
            ),
            markers: markers,
            onCameraMove: _manager.onCameraMove,
            onCameraIdle: _manager.updateMap,

            // onCameraMoveStarted: () {
            //   if (_isInfoWindowVisible) _closeInfoWindow();
            // },
            trafficEnabled: true,
            onTap: (LatLng position) {
              _closeInfoWindow();
            },
          ),
          if (_isInfoWindowVisible && _selectedCamera != null)
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 100,
              top: MediaQuery.of(context).size.height / 2 - 150,
              child: GestureDetector(
                onTap: () => _showCameraDetails(_selectedCamera!),
                child: CustomInfoWindow(
                  title: _selectedCamera!.name,
                  timestamp: _selectedCamera!.timestamp,
                  imageUrl: _selectedCamera!.image,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
