import 'package:flutter/material.dart';

// Model
import '../../models/character_model.dart';

// Controller
import '../../controllers/character_controller.dart';

// Components
import '../components/loading.dart';
import '../components/list.dart';
import '../components/search.dart';
import '../pages/map_view_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<LTACameraObject> _cameras = <LTACameraObject>[];
  List<LTACameraObject> _camerasDisplay = <LTACameraObject>[];

  bool _isLoading = true;
  bool _isGridView = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });
    final value = await getCameraObjectList();
    setState(() {
      _isLoading = false;
      _cameras.clear();
      _cameras.addAll(value);
      _camerasDisplay = _cameras;
    });
  }

  void _toggleView() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }

  void _navigateToMap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapViewPage(cameras: _cameras),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Singapore Traffic Cameras'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: _toggleView,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
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
                onRefresh: _loadData,
                child: _isLoading
                    ? const Center(child: MyLoading())
                    : _isGridView
                        ? GridView.builder(
                            padding: const EdgeInsets.all(8.0),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemBuilder: (context, index) {
                              return MyList(
                                  camera: _camerasDisplay[index],
                                  isGridView: true);
                            },
                            itemCount: _camerasDisplay.length,
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return MyList(
                                  camera: _camerasDisplay[index],
                                  isGridView: false);
                            },
                            itemCount: _camerasDisplay.length,
                          ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
        ],
        currentIndex: _isGridView ? 1 : 0,
        onTap: (index) {
          if (index == 0 && _isGridView) {
            _toggleView();
          } else if (index == 1 && !_isGridView) {
            _toggleView();
          } else if (index == 1) {
            _navigateToMap();
          }
        },
      ),
    );
  }
}
