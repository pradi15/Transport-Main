import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:transport/Api/apiUrl.dart';

class ApiFunction {
  static Future<Map<String, dynamic>> driverLogin({String? object}) async {
    final response = await http.post(ApiUrl.DriverLogin,
        body: object, headers: {'content-Type': 'application/json'});
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> studentLogin({String? object}) async {
    final response = await http.post(ApiUrl.StudentLogin,
        body: object, headers: {'content-Type': 'application/json'});
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getData({String? object}) async {
    final response = await http.post(ApiUrl.StudentLogin,
        body: object, headers: {'content-Type': 'application/json'});
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> getDriverInfo({String? object}) async {
    // print(object);

    final response = await http.post(ApiUrl.GetDriverInfo,
        body: object, headers: {'content-Type': 'application/json'});
    return jsonDecode(response.body)['DriverInfo'][0];
  }

  static Future<Map<String, dynamic>> getStudentInfo({String? object}) async {
    final response = await http.post(ApiUrl.GetStudentInfo,
        body: object, headers: {'content-Type': 'application/json'});
    return jsonDecode(response.body)['StudentInfo'][0];
  }

  static Future<Map<String,dynamic>> getDriverLocation({String? object}) async {
    final response = await http.post(ApiUrl.LocationBelongToStudent,
        body: object, headers: {'content-Type': 'application/json'});
    return jsonDecode(response.body)['buslocation'];
  }

  static Future<String> locationUpdate({String? object}) async {
    final response = await http.post(ApiUrl.DriverLocationUpdate,
        body: object, headers: {'content-Type': 'application/json'});
    if (response.statusCode == 201) {
      return 'okay';
    } else {
      return 'cant update';
    }
  }
}
