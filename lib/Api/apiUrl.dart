import 'package:transport/Api/apiRoutes.dart';

class ApiUrl {
  static Uri DriverLogin = Uri.parse('${ApiRoutes.Api}/login');
  static Uri StudentLogin = Uri.parse('${ApiRoutes.Api}/stulogin');
  static Uri GetDriverInfo = Uri.parse('${ApiRoutes.Api}/driver');
  static Uri GetStudentInfo = Uri.parse('${ApiRoutes.Api}/student');
  static Uri LocationBelongToStudent = Uri.parse('${ApiRoutes.Api}/getlocation');
  static Uri DriverLocationUpdate = Uri.parse('${ApiRoutes.Api}/locationupdate');
}
