import 'package:flutter/material.dart';

// Model
import '../../models/character_model.dart';

// Page
import '../pages/character_details_page.dart';

class MyList extends StatelessWidget {
  final LTACameraObject camera;
  final bool isGridView;

  const MyList({Key? key, required this.camera, this.isGridView = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isGridView
        ? _buildGridViewItem(context)
        : _buildListViewItem(context);
  }

  Widget _buildListViewItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 2.0, // Reduced elevation for a cleaner look
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CharacterDetailsPage(camera: camera),
              ),
            );
          },
          child: Row(
            children: [
              Hero(
                tag: camera.cameraId,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                  ),
                  child: Image.network(
                    camera.image,
                    width: 120.0, // Fixed width for the image
                    height: 120.0, // Fixed height for the image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        camera.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                        maxLines: 2, // Limit the number of lines for the name
                        overflow: TextOverflow
                            .ellipsis, // Add ellipsis if text overflows
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        camera.cameraId,
                        maxLines:
                            1, // Limit the number of lines for the cameraId
                        overflow: TextOverflow
                            .ellipsis, // Add ellipsis if text overflows
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        camera.timestamp,
                        maxLines:
                            1, // Limit the number of lines for the timestamp
                        overflow: TextOverflow
                            .ellipsis, // Add ellipsis if text overflows
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridViewItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailsPage(camera: camera),
          ),
        );
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 2.0, // Reduced elevation for a cleaner look
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: camera.cameraId,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child: Image.network(
                  camera.image,
                  fit: BoxFit.cover,
                  height: 150.0, // Increased height for larger image
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    camera.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    maxLines: 2, // Limit the number of lines for the name
                    overflow:
                        TextOverflow.ellipsis, // Add ellipsis if text overflows
                  ),
                  Text(
                    camera.cameraId,
                    maxLines: 1, // Limit the number of lines for the cameraId
                    overflow:
                        TextOverflow.ellipsis, // Add ellipsis if text overflows
                  ),
                  Text(
                    camera.timestamp,
                    maxLines: 1, // Limit the number of lines for the timestamp
                    overflow:
                        TextOverflow.ellipsis, // Add ellipsis if text overflows
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
