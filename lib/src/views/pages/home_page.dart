import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Model
import '../../models/character_model.dart';

// Controller
import '../../controllers/character_controller.dart';

// Components
import '../components/loading.dart';
import '../components/list.dart';
import '../components/search.dart';
import '../pages/map_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<LTACameraObject> _cameras = <LTACameraObject>[];
  List<LTACameraObject> _camerasDisplay = <LTACameraObject>[];
  bool _isLoading = true;
  bool _isGridView =
      false; // Add a boolean to toggle between list and grid view
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchCameraData();
  }

  Future<void> _fetchCameraData() async {
    setState(() {
      _isLoading = true;
    });

    getCameraObjectList().then((value) {
      setState(() {
        _isLoading = false;
        _cameras.clear();
        _cameras.addAll(value);
        _camerasDisplay = _cameras;
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Singapore Traffic Cameras'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const MyLoading()
            : IndexedStack(
                index: _selectedIndex,
                children: [
                  Column(
                    children: [
                      MySearch(
                        hintText: 'Search camera name',
                        onChanged: (searchText) {
                          searchText = searchText.toLowerCase();
                          setState(() {
                            _camerasDisplay = _cameras.where((u) {
                              var nameLowerCase = u.name.toLowerCase();
                              var nicknameLowerCase = u.cameraId.toLowerCase();
                              return nameLowerCase.contains(searchText) ||
                                  nicknameLowerCase.contains(searchText);
                            }).toList();
                          });
                        },
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: _fetchCameraData,
                          child:
                              _isGridView ? _buildGridView() : _buildListView(),
                        ),
                      ),
                    ],
                  ),
                  MapPage(cameras: _cameras),
                ],
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List/Grid View',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map View',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return MyList(camera: _camerasDisplay[index], isGridView: false);
      },
      itemCount: _camerasDisplay.length,
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0, // Adjust the maximum width of each item here
        childAspectRatio:
            0.75, // Adjust the aspect ratio to provide more height
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemBuilder: (context, index) {
        return MyList(camera: _camerasDisplay[index], isGridView: true);
      },
      itemCount: _camerasDisplay.length,
    );
  }
}
