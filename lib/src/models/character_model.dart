import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

class Character {
  int charId = 0;
  String name = "";
  String img = "";
  String nickname = "";
  String portrayed = "";

  Character(this.charId, this.name, this.img, this.nickname, this.portrayed);

  Character.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    img = json['img'];
    nickname = json['nickname'];
    portrayed = json['portrayed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['char_id'] = charId;
    data['name'] = name;
    data['img'] = img;
    data['nickname'] = nickname;
    data['portrayed'] = portrayed;
    return data;
  }
}

class LTACameraObject with ClusterItem {
  String timestamp;
  String cameraId;
  String image;
  double lon;
  double lat;
  String name;

  LTACameraObject({
    required this.timestamp,
    required this.cameraId,
    required this.image,
    required this.lon,
    required this.lat,
    required this.name,
  });

  @override
  LatLng get location => LatLng(lat, lon);

  void setTimestamp(String timestamp) {
    this.timestamp = timestamp;
  }

  void setCameraId(String cameraId) {
    this.cameraId = cameraId;
  }

  void setImage(String image) {
    this.image = image;
  }

  void setLon(double lon) {
    this.lon = lon;
  }

  void setLat(double lat) {
    this.lat = lat;
  }

  void setName(String name) {
    this.name = name;
  }
}


// class LTACameraObject {
//   String timestamp;
//   String cameraId;
//   String image;
//   double lon;
//   double lat;
//   String name;

//   LTACameraObject({
//     required this.timestamp,
//     required this.cameraId,
//     required this.image,
//     required this.lon,
//     required this.lat,
//     required this.name,
//   });

//   void setTimestamp(String timestamp) {
//     this.timestamp = timestamp;
//   }

//   void setCameraId(String cameraId) {
//     this.cameraId = cameraId;
//   }

//   void setImage(String image) {
//     this.image = image;
//   }

//   void setLon(double lon) {
//     this.lon = lon;
//   }

//   void setLat(double lat) {
//     this.lat = lat;
//   }

//   void setName(String name) {
//     this.name = name;
//   }
// }
