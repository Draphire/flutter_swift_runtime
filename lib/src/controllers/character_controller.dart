import 'dart:convert';

// Foundation
import 'package:flutter/foundation.dart';

// Http
import 'package:http/http.dart' as http;

// Model
import '../models/character_model.dart';

// const String url = "https://6345b3cf745bd0dbd36f6dd5.mockapi.io/person";
// const String url = "http://datamall2.mytransport.sg/ltaodataservice/Traffic-Imagesv2"

List<String> name = [
  "KPE: KPE/ECP",
  "KPE: Kallang Bahru",
  "KPE: KPE/PIE",
  "KPE: Kallang Way Flyover",
  "KPE: Defu Flyover",
  "KPE: KPE 8.5km",
  "MCE: View from Maxwell Rd",
  "MCE: Marina Boulevard/Marina Coastal Drive",
  "MCE: 1.02km",
  "MCE: MCE/ECP",
  "MCE: Marina Boulevard",
  "CTE: Moulmain Flyover (Towards AYE)",
  "CTE: Braddell Flyover (Towards SLE)",
  "CTE: St George Rd (Towards SLE)",
  "CTE: Entrance from Chin Swee Rd",
  "CTE: AMK Ave 5 Flyover (Towards City)",
  "CTE: Bukit Merah Flyover",
  "CTE: Exit 6 to Bukit Timah Rd",
  "CTE: Ang Mo Kio Ave 1 Flyover",
  "NA",
  "Woodlands Causeway (Towards Johor)",
  "Near Woodlands Checkpoint (Towards BKE)",
  "BKE: Chantek Flyover",
  "BKE: Woodlands Flyover",
  "BKE: Dairy Farm Flyover",
  "BKE: After KJE Exit",
  "BKE: Mandai Rd Entrance",
  "BKE: Exit 5 to KJE (Towards Checkpoint)",
  "BKE: Woodlands South Flyover (Towards BKE)",
  "ECP: Entrance from PIE (Changi)",
  "ECP: Entrance from MCE",
  "ECP: Exit 2A to Changi Coast Rd",
  "ECP: Laguna Flyover (Towards Changi)",
  "ECP: Marine ParadeFlyover (Towards AYE)",
  "ECP: Tanjung Katong Flyover (Towards Changi)",
  "ECP: Tanjung Rhu (Towards AYE)",
  "ECP: Benjamin Sheares Bridge",
  "AYE: Alexandar Road (Towards ECP)",
  "AYE: Keppel Viaduct",
  "AYE: Lower Delta Road (Towards Tuas)",
  "AYE: Entrance from Yuan Ching Rd",
  "AYE: Near NUS (Towards Tuas)",
  "AYE: Entrance from Jin Ahmad Ibrahim",
  "AYE: Near Dover ITE (Towards ECP)",
  "NA",
  "AYE: Towards Pandan Gardens",
  "AYE: After Tuas West Road",
  "AYE: Near West Coast Walk",
  "AYE: Entrance from Benoi Rd",
  "Second Link at Tuas",
  "Tuas Checkpoint",
  "Sentosa Gateway: Towards HabourFont",
  "Sentosa Gateway: Towards Sentosa",
  "PIE: Bedok North (Towards Jurong)",
  "PIE: Eunos Flyover (Towards Jurong)",
  "PIE: Paya Lebar Flyover (Towards Jurong)",
  "PIE: Kallang",
  "PIE: Woodsvilie Flyover (Towards Changi)",
  "PIE: Kim Keat (Towards Changi)",
  "PIE: Thomson Rd",
  "PIE: Mount Pleasant (Towards Changi)",
  "PIE: Adam Rd (Towards Changi)",
  "PIE: BKE (Towards Changi)",
  "PIE: Jurong West St 81 (Towards Jurrong)",
  "PIE: Entrance from Jalan Anak Bukit",
  "PIE: Entrance to PIE from ECP Changi",
  "PIE: Exit 27 to Clementi Ave 6",
  "PIE: Entrance from Simei Aue",
  "PIE: Exit 35 to KJE",
  "PIE: Hong Kah Flyover",
  "PIE: Tuas Flyover",
  "TPE: Upper Changi Flyover",
  "TPE: Rivervale Drive (Towards SLE)",
  "NA",
  "NA",
  "NA",
  "NA",
  "KJE: Choa Chu Kang(Towards PIE)",
  "KJE: Exit to BKE",
  "KJE: Entrance From Choa Chu Kang Dr",
  "KJE: Tengah Flyover",
  "SLE: Selatar Flyover (Towards BKE)",
  "Lentor Flyover (Towards TPE)",
  "NA",
  "NA",
  "NA",
  "NA"
];

List<List<String>> name2 = [
  ["1001", "KPE: KPE/ECP"],
  ["1002", "KPE: Kallang Bahru"],
  ["1003", "KPE: KPE/PIE"],
  ["1004", "KPE: Kallang Way Flyover"],
  ["1005", "KPE: Defu Flyover"],
  ["1006", "KPE: KPE 8.5km"],
  ["1501", "MCE: View from Maxwell Rd"],
  ["1502", "MCE: Marina Boulevard/Marina Coastal Drive"],
  ["1503", "MCE: 1.02km"],
  ["1504", "MCE: MCE/ECP"],
  ["1505", "MCE: Marina Boulevard"],
  ["1701", "CTE: Moulmain Flyover (Towards AYE)"],
  ["1702", "CTE: Braddell Flyover (Towards SLE)"],
  ["1703", "CTE: St George Rd (Towards SLE)"],
  ["1704", "CTE: Entrance from Chin Swee Rd"],
  ["1705", "CTE: AMK Ave 5 Flyover (Towards City)"],
  ["1706", "CTE: Bukit Merah Flyover"],
  ["1707", "CTE: Exit 6 to Bukit Timah Rd"],
  ["1709", "CTE: Ang Mo Kio Ave 1 Flyover"],
  ["2701", "Woodlands Causeway (Towards Johor)"],
  ["2702", "Near Woodlands Checkpoint (Towards BKE)"],
  ["2703", "BKE: Chantek Flyover"],
  ["2704", "BKE: Woodlands Flyover"],
  ["2705", "BKE: Dairy Farm Flyover"],
  ["2706", "BKE: After KJE Exit"],
  ["2707", "BKE: Mandai Rd Entrance"],
  ["2708", "BKE: Exit 5 to KJE (Towards Checkpoint)"],
  ["9703", "BKE: Woodlands South Flyover (Towards BKE)"],
  ["3702", "ECP: Entrance from PIE (Changi)"],
  ["3704", "ECP: Entrance from MCE"],
  ["3705", "ECP: Exit 2A to Changi Coast Rd"],
  ["3793", "ECP: Laguna Flyover (Towards Changi)"],
  ["3795", "ECP: Marine ParadeFlyover (Towards AYE)"],
  ["3796", "ECP: Tanjung Katong Flyover (Towards Changi)"],
  ["3797", "ECP: Tanjung Rhu (Towards AYE)"],
  ["3798", "ECP: Benjamin Sheares Bridge"],
  ["4701", "AYE: Alexandar Road (Towards ECP)"],
  ["4702", "AYE: Keppel Viaduct"],
  ["4704", "AYE: Lower Delta Road (Towards Tuas)"],
  ["4705", "AYE: Entrance from Yuan Ching Rd"],
  ["4706", "AYE: Near NUS (Towards Tuas)"],
  ["4707", "AYE: Entrance from Jin Ahmad Ibrahim"],
  ["4708", "AYE: Near Dover ITE (Towards ECP)"],
  ["4710", "AYE: Towards Pandan Gardens"],
  ["4712", "AYE: After Tuas West Road"],
  ["4714", "AYE: Near West Coast Walk"],
  ["4716", "AYE: Entrance from Benoi Rd"],
  ["4703", "Second Link at Tuas"],
  ["4713", "Tuas Checkpoint"],
  ["4798", "Sentosa Gateway: Towards HabourFont"],
  ["4799", "Sentosa Gateway: Towards Sentosa"],
  ["5794", "PIE: Bedok North (Towards Jurong)"],
  ["5795", "PIE: Eunos Flyover (Towards Jurong)"],
  ["5797", "PIE: Paya Lebar Flyover (Towards Jurong)"],
  ["5798", "PIE: Kallang"],
  ["5799", "PIE: Woodsvilie Flyover (Towards Changi)"],
  ["6701", "PIE: Kim Keat (Towards Changi)"],
  ["6703", "PIE: Thomson Rd"],
  ["6704", "PIE: Mount Pleasant (Towards Changi)"],
  ["6705", "PIE: Adam Rd (Towards Changi)"],
  ["6706", "PIE: BKE (Towards Changi)"],
  ["6708", "PIE: Jurong West St 81 (Towards Jurrong)"],
  ["6710", "PIE: Entrance from Jalan Anak Bukit"],
  ["6711", "PIE: Entrance to PIE from ECP Changi"],
  ["6712", "PIE: Exit 27 to Clementi Ave 6"],
  ["6713", "PIE: Entrance from Simei Aue"],
  ["6714", "PIE: Exit 35 to KJE"],
  ["6715", "PIE: Hong Kah Flyover"],
  ["6716", "PIE: Tuas Flyover"],
  ["7791", "TPE: Upper Changi Flyover"],
  ["8701", "KJE: Choa Chu Kang(Towards PIE)"],
  ["8702", "KJE: Exit to BKE"],
  ["8704", "KJE: Entrance From Choa Chu Kang Dr"],
  ["8706", "KJE: Tengah Flyover"],
  ["9704", "SLE: Selatar Flyover (Towards BKE)"],
  ["9703", "Lentor Flyover (Towards TPE)"]
];

class CameraListSingleton {
  static final CameraListSingleton _instance = CameraListSingleton._internal();
  List<LTACameraObject> cameraList = [];

  factory CameraListSingleton() {
    return _instance;
  }

  CameraListSingleton._internal();

  void setCameraList(List<LTACameraObject> list) {
    cameraList = list;
  }

  List<LTACameraObject> getCameraList() {
    return cameraList;
  }
}

Future<List<LTACameraObject>> getCameraObjectList() async {
  CameraListSingleton cameraListSingleton = CameraListSingleton();
  String storeDate = DateTime.now().toIso8601String();

  List<LTACameraObject> mLTACameraObjectList = [];

  var url = Uri.parse(
      'http://datamall2.mytransport.sg/ltaodataservice/Traffic-Imagesv2');
  var headers = {
    'AccountKey': '63cUmVM5S6iIk162Td8u+g==',
    'accept': 'application/json',
  };

  try {
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var sonArray = jsonResponse['value'] as List;

      for (int i = 0; i < sonArray.length; i++) {
        var sonObject = sonArray[i];

        var cameraObject = LTACameraObject(
          timestamp: storeDate,
          cameraId: sonObject['CameraID'],
          image: sonObject['ImageLink'],
          lon: sonObject['Longitude'],
          lat: sonObject['Latitude'],
          name: i >= 0 && i < name.length ? name[i] : 'N/A',
        );

        mLTACameraObjectList.add(cameraObject);
      }

      mLTACameraObjectList.sort((a, b) => a.cameraId.compareTo(b.cameraId));

      for (var cameraObject in mLTACameraObjectList) {
        for (var namePair in name2) {
          if (cameraObject.cameraId == namePair[0]) {
            cameraObject.setName(namePair[1]);
          }
        }
      }

      cameraListSingleton.setCameraList(mLTACameraObjectList);
      return mLTACameraObjectList;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print(e);
    return [];
  }
}

// List<Character> parseCharacter(String responseBody) {
//   var list = json.decode(responseBody) as List<dynamic>;
//   var characters = list.map((e) => Character.fromJson(e)).toList();
//   return characters;
// }

// Future<List<Character>> fetchCharacters() async {
//   final http.Response response = await http.get(Uri.parse(url));

//   if (response.statusCode == 200) {
//     return compute(parseCharacter, response.body);
//   } else {
//     throw Exception(response.statusCode);
//   }
// }
