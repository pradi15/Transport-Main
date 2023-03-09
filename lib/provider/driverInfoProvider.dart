// ignore_for_file: unrelated_type_equality_checks, prefer_final_fields, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:transport/Api/apiFunction.dart';
import 'package:transport/model/driverModel.dart';

class DriverInfoProvider extends ChangeNotifier {
  DriverModel _driverModel = DriverModel.empty();
  bool _locationProcess = false;
  Marker _myLocationMarker = Marker(
      markerId: MarkerId(''),
      position: LatLng(0, 0),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
  // Circle _myLcoationCirle = Circle(
  //     circleId: CircleId(''),
  //     radius: 12,
  //     fillColor: Colors.red,
  //     center: LatLng(0, 0));
  Set<Marker> _marker = {};
  Set<Polygon> _polygons = {};
  Set<Circle> _circle = {};
  Timer? _myTimer;
  // StreamSubscription<LocationData>? _streamSubscription;
  DriverModel get driverInfo {
    return _driverModel;
  }

  Marker get myLocationMarker {
    return _myLocationMarker;
  }

  Set<Marker> get marker {
    return _marker;
  }

  Set<Circle> get circle {
    return _circle;
  }
  Set<Polygon> get polygons {
    return _polygons;
  }

  Set<Polyline> _polylines = {};

  bool get locationProcess {
    return _locationProcess;
  }

  Future setDriverInfo(DriverModel value) async {
    for (var i = 0; i < value.stops!.length; i++) {
      _marker.add(Marker(
          markerId: MarkerId(value.stops![i].stop_name!),
          infoWindow: InfoWindow(title: '${value.stops![i].stop_name}'),
          position:
              LatLng(value.stops![i].lattitude!, value.stops![i].longitude!),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen)));
      _circle.add(Circle(
          circleId: CircleId(driverInfo.name!),
          strokeWidth: 1,
          radius: 15,
          visible: true,
          fillColor: Color.fromARGB(176, 161, 243, 164),
          center:
              LatLng(value.stops![i].lattitude!, value.stops![i].longitude!)));
    }
    _driverModel = value;
    notifyListeners();
  }

  Future<void> updateMyLocation() async {
    Location myLocation = Location.instance;
    if (await myLocation.requestService()) {
      _locationProcess = true;
      // _streamSubscription = myLocation.onLocationChanged.listen((event) async {

      // });
      _myTimer = Timer.periodic(Duration(seconds: 1), (_) {
        Location.instance.getLocation().then((event) async {
          // _myLocationMarker = Marker(
          //     markerId: MarkerId(driverInfo.name!),
          //     position: LatLng(event.latitude!, event.longitude!),
          //     icon: BitmapDescriptor.defaultMarkerWithHue(
          //         BitmapDescriptor.hueBlue));
          final result = await ApiFunction.locationUpdate(
              object: jsonEncode({
            "busid": driverInfo.busId,
            "last_lattitude": event.latitude,
            "last_longitude": event.longitude
          }));

          if (result == 'cant update') {
            _myTimer!.cancel();
            _locationProcess = false;
          }
          notifyListeners();
        });
      });
    } else {
      myLocation.requestPermission().then((value) async {
        bool result = await myLocation.requestService();
        if (result) {
          myLocation.enableBackgroundMode(enable: true);
        } else {
          _myTimer!.cancel();
          _locationProcess = false;
        }
      });
    }
  }

  void stopSubscription() {
    _myTimer!.cancel();
    _locationProcess = false;
    notifyListeners();
  }
}
