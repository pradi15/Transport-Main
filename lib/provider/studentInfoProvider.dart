// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transport/Api/apiFunction.dart';
import 'package:transport/model/studentModel.dart';

class StudentInfoProvider extends ChangeNotifier {
  bool _locationProcess = false;
  late Timer _myTimer;
  Set<Marker> _marker = {};
  LatLng _driverLocation = LatLng(12.3234234234, 80.35235234);
  LatLng get driverLocation {
    return _driverLocation;
  }

  bool get locationProcess {
    return _locationProcess;
  }
   Set<Marker> get marker {
    return _marker;
  }

  StudentModel _studentInfo = StudentModel.empty();
  StudentModel get studentInfo {
    return _studentInfo;
  }

  void setStudentInfo(StudentModel value) {
      for (var i = 0; i < value.stops!.length; i++) {
      _marker.add(Marker(
          markerId: MarkerId(value.stops![i].stop_name!),
          infoWindow: InfoWindow(title: '${value.stops![i].stop_name}'),
          position:
              LatLng(value.stops![i].lattitude!, value.stops![i].longitude!),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen)));
    }
    _studentInfo = value;
    notifyListeners();
  }

  Future<void> getDirverLocation() async {
    _locationProcess = true;
    _myTimer = Timer.periodic(Duration(seconds: 1), (_) async {
      final result = await ApiFunction.getDriverLocation(
          object: jsonEncode({"busid": _studentInfo.busId}));
      _driverLocation = LatLng(double.parse(result['last_lattitude']),
          double.parse(result['last_longitude']));
      print(_driverLocation);
      notifyListeners();
    });
  }

  void stopTimer() {
    _myTimer.cancel();
    _locationProcess = false;
    notifyListeners();
  }
}
