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
  bool _isGridView = false;
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

    List<LTACameraObject> cameras = await getCameraObjectList();
    setState(() {
      _isLoading = false;
      _cameras.clear();
      _cameras.addAll(cameras);
      _camerasDisplay = _cameras;
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
      ),
      body: SafeArea(
        child: _isLoading
            ? const MyLoading()
            : IndexedStack(
                index: _selectedIndex,
                children: [
                  MyList(
                    cameras: _camerasDisplay,
                    fetchCameraData: _fetchCameraData,
                  ),
                  MapPage(
                    cameras: _camerasDisplay,
                    fetchCameraData: _fetchCameraData,
                  ),
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
}
