// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transport/Screen/StudentScreen/StudentScreen.dart';
import 'package:transport/Service/MediaQuery.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:transport/Api/apiFunction.dart';
import 'package:transport/model/studentModel.dart';
import 'package:transport/provider/studentInfoProvider.dart';
import 'package:transport/provider/tokenProvider.dart';

class StudentLogin extends StatefulWidget {
  @override
  _StudentLoginState createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);
  final passwordController = TextEditingController();
  final studentIdController = TextEditingController();

  bool _hiddepassword = true;
  @override
  void dispose() {
    passwordController.clear();
    studentIdController.clear();
    super.dispose();
  }

  message(String txt) {
    // loading.value = false;
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        txt,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
            image: AssetImage("Assets/bus4.jpg"),
            fit: BoxFit.cover,
            opacity: 0.5),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Color.fromARGB(0, 207, 204, 204),
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Transport',
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 30,
                                letterSpacing: 2,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.bubble_chart,
                            color: Colors.yellowAccent,
                            size: 50,
                          )
                        ],
                      ),
                      Text(
                        ' Student Login',
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 35,
                            letterSpacing: 1,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextField(
                          cursorColor: Colors.white,
                          style:
                              TextStyle(color: Colors.white, letterSpacing: 1),
                          controller: studentIdController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Color.fromARGB(199, 255, 254, 254),
                              ),
                              labelText: 'Student Id',
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(186, 226, 226, 226))),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: 300,
                          child: TextField(
                            cursorColor: Colors.white,
                            obscureText: _hiddepassword,
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 1),
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: 'password',
                              prefixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _hiddepassword = !_hiddepassword;
                                    });
                                  },
                                  child: Icon(
                                    _hiddepassword == true
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white,
                                  )),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        color: Colors.yellow,
                        splashColor: Color.fromARGB(255, 255, 255, 255),
                        elevation: 30,
                        onPressed: () async {
                          if (studentIdController.text.isEmpty &&
                              passwordController.text.isEmpty) {
                            return message('please fill everything');
                          }
                          Map<String, dynamic> object = {
                            "StuID": studentIdController.text,
                            "password": passwordController.text
                          };
                          loading.value = true;
                          final result = await ApiFunction.studentLogin(
                              object: jsonEncode(object));
                          if (result['key'] != null) {
                            context.read<AuthToken>().setToken(
                                token: result['key'], who: result['role']);
                            final StudentModel result1 = StudentModel.fromjson(
                                await ApiFunction.getStudentInfo(
                                    object: jsonEncode({"AuthKey":result['key']})));
                            context
                                .read<StudentInfoProvider>()
                                .setStudentInfo(result1);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StudentScreen()));
                          } else {
                            message(result['error']);
                          }
                          loading.value = false;
                        },
                        icon: FaIcon(FontAwesomeIcons.signInAlt,
                            color: Color.fromARGB(255, 0, 0, 0), size: 20),
                        label: Text(
                          'Login',
                          style: TextStyle(fontSize: 15),
                        )),
                    width: getProportionateScreenWidth(300),
                    height: getProportionateScreenHeight(40),
                  )
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: loading,
              builder: (BuildContext context, bool value, Widget? child) {
                return value
                    ? SizedBox(
                        width: 100,
                        height: 100,
                        child: LoadingIndicator(
                          indicatorType:
                              Indicator.ballTrianglePathColoredFilled,
                          colors: const [
                            Colors.red,
                            Colors.yellow,
                            Colors.green
                          ],
                          strokeWidth: 1,
                        ),
                      )
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
