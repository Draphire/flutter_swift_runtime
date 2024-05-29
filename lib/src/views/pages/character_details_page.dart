import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Model
import '../../models/character_model.dart';

class CharacterDetailsPage extends StatelessWidget {
  final LTACameraObject camera;

  const CharacterDetailsPage({Key? key, required this.camera})
      : super(key: key);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Hero(
                tag: camera.cameraId,
                child: Container(
                  width: double.infinity,
                  child: Image.network(
                    camera.image,
                    fit: BoxFit.cover,
                  ),
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
    );
  }
}
