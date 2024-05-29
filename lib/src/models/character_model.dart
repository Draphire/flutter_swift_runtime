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

class LTACameraObject {
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
