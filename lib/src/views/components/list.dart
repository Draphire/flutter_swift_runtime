import 'package:api_search_list/src/views/components/search.dart';
import 'package:flutter/material.dart';

// Model
import '../../models/character_model.dart';

// Page
import '../pages/character_details_page.dart';

class MyList extends StatelessWidget {
  final List<LTACameraObject> cameras;
  final Function() fetchCameraData;
  final Function(String) onSearch;
  const MyList(
      {Key? key,
      required this.cameras,
      required this.fetchCameraData,
      required this.onSearch})
      : super(key: key);

  // List<LTACameraObject> _camerasDisplay = <LTACameraObject>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Singapore Traffic Cameras'),
          // actions: [
          //   IconButton(
          //     icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
          //     onPressed: () {
          //       setState(() {
          //         _isGridView = !_isGridView;
          //       });
          //     },
          //   ),
          // ],
        ),
        body: Column(
          children: [
            MySearch(
              hintText: 'Search camera name',
              onChanged: (searchText) {
                onSearch(searchText);
              },
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => fetchCameraData(),
                child:
                    // MyList(
                    //     cameras: cameras,
                    //     isGridView: isGridView,),
                    // isGridView
                    //     ? _buildGridView(context)
                    //     :
                    _buildListView(context),
              ),
            ),
          ],
        ));
  }

  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      itemCount: cameras.length,
      itemBuilder: (context, index) {
        final camera = cameras[index];
        return _buildListItem(context, camera);
      },
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Adjust the number of columns as needed
        childAspectRatio: 0.75, // Adjust the aspect ratio as needed
      ),
      itemCount: cameras.length,
      itemBuilder: (context, index) {
        final camera = cameras[index];
        return _buildGridItem(context, camera);
      },
    );
  }

  Widget _buildListItem(BuildContext context, LTACameraObject camera) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: Hero(
            tag: camera.cameraId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                camera.image,
                fit: BoxFit.cover,
                width: 80.0,
                height: 80.0,
              ),
            ),
          ),
          title: Text(
            camera.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
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
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, LTACameraObject camera) {
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
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: camera.cameraId,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8.0),
                ),
                child: Image.network(
                  camera.image,
                  height: 120.0, // Adjust height as needed
                  fit: BoxFit.cover,
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
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    camera.cameraId,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
