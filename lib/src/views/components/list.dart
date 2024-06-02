import 'package:flutter/material.dart';

// Model
import '../../models/character_model.dart';

// Page
import '../pages/character_details_page.dart';
import '../components/search.dart';

class MyList extends StatefulWidget {
  final List<LTACameraObject> cameras;
  final Function() fetchCameraData;

  const MyList({
    Key? key,
    required this.cameras,
    required this.fetchCameraData,
  }) : super(key: key);

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  bool isGridView = false;
  List<LTACameraObject> _camerasDisplay = [];

  @override
  void initState() {
    super.initState();
    _camerasDisplay = widget.cameras;
  }

  void _onSearch(String searchText) {
    searchText = searchText.toLowerCase();
    setState(() {
      _camerasDisplay = widget.cameras.where((u) {
        var nameLowerCase = u.name.toLowerCase();
        var nicknameLowerCase = u.cameraId.toLowerCase();
        return nameLowerCase.contains(searchText) ||
            nicknameLowerCase.contains(searchText);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: MySearch(
                    hintText: 'Search camera name',
                    onChanged: (searchText) {
                      _onSearch(searchText);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(isGridView ? Icons.list : Icons.grid_view),
                  onPressed: () {
                    setState(() {
                      isGridView = !isGridView;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await widget.fetchCameraData();
                setState(() {
                  _camerasDisplay = widget.cameras;
                });
              },
              child: isGridView
                  ? _buildGridView(context)
                  : _buildListView(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      itemCount: _camerasDisplay.length,
      itemBuilder: (context, index) {
        final camera = _camerasDisplay[index];
        return _buildListItem(context, camera);
      },
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Adjust the number of columns as needed
        childAspectRatio: 0.75, // Adjust the aspect ratio as needed
      ),
      itemCount: _camerasDisplay.length,
      itemBuilder: (context, index) {
        final camera = _camerasDisplay[index];
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
