// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:async';
import 'dart:convert';

// import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transport/Api/apiFunction.dart';
import 'package:transport/Screen/DriverScreen/DriverScreen.dart';
import 'package:transport/Screen/IntroductionScreen/IntroScreen.dart';
import 'package:transport/Screen/LoginScreen/DecisionScreen.dart';
import 'package:transport/Screen/StudentScreen/StudentScreen.dart';
// import 'package:transport/Service/SharePrefernce.dart';
import 'package:transport/Service/saveToLocal.dart';
import 'package:transport/model/driverModel.dart';
import 'package:transport/model/studentModel.dart';
import 'package:transport/provider/driverInfoProvider.dart';
import 'package:transport/provider/studentInfoProvider.dart';
import 'package:transport/provider/tokenProvider.dart';
import 'package:transport/utils/constant.dart';

// import '../DriverScreen/DriverScreen.dart';
// import '../StudentScreen/StudentScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    check();

    super.initState();
  }

  Future<void> check() async {
    final token = await SaveToLocal.getAsString(key: Strings.token);
    final who = await SaveToLocal.getAsString(key: Strings.who);
    final isFirstTime = await SaveToLocal.getAsBool(key: Strings.isFirstTime);
    if (token != null && who != null) {
      context.read<AuthToken>().setToken(token: token, who: who);
      if (who == 'student') {
        final StudentModel result = StudentModel.fromjson(
            await ApiFunction.getStudentInfo(
                object: jsonEncode({"AuthKey": token})));
        context.read<StudentInfoProvider>().setStudentInfo(result);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (ctx) => StudentScreen()),
            (route) => false);
      } else if (who == 'driver') {
        final DriverModel result = DriverModel.fromJson(
            await ApiFunction.getDriverInfo(
                object: jsonEncode({"AuthKey": token})));
        context.read<DriverInfoProvider>().setDriverInfo(result);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (ctx) => DriverScreen()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (ctx) => Login()), (route) => false);
      }
    } else {
      if (isFirstTime != null) {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => Login()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => IntroductionScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 111, 190, 255),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('Assets/playstore.png'),
              width: 100,
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Transport',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold),
              ),
            ),
            // SizedBox(
            //   height: 30,
            // ),
            // Container(
            //     width: 30,
            //     height: 30,
            //     child: LoadingIndicator(
            //       indicatorType: Indicator.ballTrianglePathColored,
            //       colors: [Colors.white],
            //     )),
          ],
        ),
      ),
    );
  }
}
