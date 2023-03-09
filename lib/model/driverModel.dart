// Generated by https://quicktype.io

import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverModel {
  String? name;
  String? phone;
  String? role;
  String? routeNo;
  String? routeName;
  String? busId;
  LatLng? origin;
  LatLng? destination;
  LatLng? lastUpdatedLocation;
  List<StopsModel>? stops;

  DriverModel({
    this.name,
    this.phone,
    this.role,
    this.routeNo,
    this.routeName,
    this.stops,
    this.busId,
    this.origin,
    this.destination,
    this.lastUpdatedLocation,
  });

  factory DriverModel.fromJson(Map<String, dynamic> value) {
    return DriverModel(
        routeName: value['routeName'],
        routeNo: value['route_no'],
        name: value['Name'] ?? '',
        phone: value['Phone'] ?? '',
        role: value['role'] ?? '',
        busId: value['bus_id'] ?? '',
        stops: <StopsModel>[
          ...value['stop'].map((e) => StopsModel.fromJson(e))
        ],
        destination: LatLng(double.parse(value['dest_lattitude']),
            double.parse(value['dest_longtitiute'])),
        origin: LatLng(double.parse(value['source_lattitude']),
            double.parse(value['source_longtitiude'])),
        lastUpdatedLocation: LatLng(double.parse(value['last_loc_lattitude']),
            double.parse(value['last_loc_longitude'])));
  }
  factory DriverModel.empty() {
    return DriverModel(
      busId: '',
      destination: const LatLng(0.00, 0.00),
      lastUpdatedLocation: const LatLng(0.00, 0.00),
      name: '',
      origin: const LatLng(0.00, 0.00),
      phone: '',
      role: '',
      routeName: '',
      routeNo: '',
    );
  }
}

class StopsModel {
  String? stop_id;
  String? stop_name;
  double? lattitude;
  double? longitude;

  StopsModel({this.lattitude, this.longitude, this.stop_id, this.stop_name});

  factory StopsModel.fromJson(Map<String, dynamic> value) {
    return StopsModel(
        lattitude:double.parse(value['lattitude']),
        longitude: double.parse(value['longitude']),
        stop_id: value['stop_id'],
        stop_name: value['stop_name']);
  }
}

// {
//   "DriverInfo": [
//     {
//       "Name": "TVS",
//       "Phone": "9789606019",
//       "role": "Driver",
//       "route_no": "2",
//       "route_name": "two",
//       "bus_id": "76",
//       "source_longtitiude": "77.60690307617188",
//       "source_lattitude": "11.274208068847656",
//       "dest_longtitiute": "77.73222351074219",
//       "dest_lattitude": "11.343222618103027",
//       "last_loc_lattitude": "11.298383712768555",
//       "last_loc_longitude": "77.63670349121094",
//       "stop": [
//         {
//           "0": "1",
//           "1": "Arachalur",
//           "2": "123457000",
//           "3": "123457000",
//           "4": "1",
//           "stop_id": "1",
//           "stop_name": "Arachalur",
//           "lattitude": "123457000",
//           "longitude": "123457000",
//           "display_order": "1"
//         }
//       ]
//     }
//   ]
// }