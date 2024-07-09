import 'package:api_search_list/src/views/components/image_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Model
import '../../models/character_model.dart';

class CharacterDetailsPage extends StatelessWidget {
  final LTACameraObject camera;
  final Function() fetchCameraData;

  const CharacterDetailsPage({
    Key? key,
    required this.camera,
    required this.fetchCameraData,
  }) : super(key: key);

  // const CharacterDetailsPage(required LTACameraObject camera, {
  //   Key? key,
  //   required this.camera,
  //   required this.fetchCameraData,
  // }) : super(key: key);

  String _formatTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    return DateFormat.yMMMd().add_jm().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Details'),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await fetchCameraData();
          },
          child: ListView(
            children: [
              Hero(
                tag: camera.cameraId,
                child: Container(
                  width: double.infinity,
                  height: 250.0, // Adjust the height as needed
                  color:
                      Colors.black, // Background color to highlight the image
                  child: Stack(
                    children: [
                      ImageWithPlaceholder(
                        imageUrl: camera.image,
                        fetchNewImageUrl: () async {
                          // Logic to fetch a new URL
                          return camera.image;
                        },
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: Icon(Icons.refresh, color: Colors.white),
                          onPressed: fetchCameraData,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      camera.name,
                      style: const TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      camera.cameraId,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      _formatTimestamp(camera.timestamp),
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchCameraData,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
