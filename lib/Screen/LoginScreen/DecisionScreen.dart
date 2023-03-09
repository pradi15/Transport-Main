// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:transport/Screen/DriverScreen/driverLogin.dart';
import 'package:transport/Screen/StudentScreen/studentLogin.dart';
// import 'package:transport/Screen/LoginScreen/StudentLogin.dart';
// import 'package:transport/Widgets/Widget2.dart';

import '../../Service/MediaQuery.dart';
import 'Registration.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
     FlutterNativeSplash.remove();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Color.fromARGB(182, 0, 0, 0), BlendMode.darken),
                  image: AssetImage("Assets/school.jfif"),
                  fit: BoxFit.cover,
                  opacity: 1),
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PhysicalModel(
                      shape: BoxShape.circle,
                      elevation: 50,
                      color: Color.fromARGB(97, 0, 0, 0),
                      child: Image.asset(
                        'Assets/playstore.png',
                        scale: 3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      // ignore: prefer_const_constructors
                      child: Text(
                        'Transport',
                        style: TextStyle(
                          color: Color.fromARGB(190, 255, 235, 59),
                          fontWeight: FontWeight.w600,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.yellow.withOpacity(0.7),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => DriverLogin()));
                        },
                        child: Text('Driver Login'),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.yellow.withOpacity(0.7),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => StudentLogin()));
                        },
                        child: Text(
                          'Student Login',
                          // style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => StudentLogin()));
                    //     },
                    //     child: RectangleLabelWidget1(
                    //       LabelName: 'Login ',
                    //       LabelIcon: Icons.people_alt,
                    //     ),
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
