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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: isGridView
          ? _buildGridViewItem(context)
          : _buildListViewItem(context),
    );
  }

  Widget _buildListViewItem(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Hero(
            tag: camera.cameraId,
            child: CircleAvatar(
              backgroundImage: NetworkImage(camera.image),
            ),
          ),
          title: Text(camera.name),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(camera.cameraId),
              Text(camera.timestamp),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CharacterDetailsPage(camera: camera),
              ),
            );
          },
        ),
        const Divider(
          thickness: 2.0,
        ),
      ],
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: camera.cameraId,
              child: Image.network(
                camera.image,
                fit: BoxFit.cover,
                height: 100.0, // Set a fixed height for the image
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    camera.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
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

  // Widget _buildGridViewItem(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => CharacterDetailsPage(camera: camera),
  //         ),
  //       );
  //     },
  //     child: Card(
  //       child: Column(
  //         children: [
  //           Hero(
  //             tag: camera.cameraId,
  //             child: Image.network(
  //               camera.image,
  //               fit: BoxFit.cover,
  //               height: 100.0,
  //               width: double.infinity,
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   camera.name,
  //                   style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 Text(camera.cameraId),
  //                 Text(camera.timestamp),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
