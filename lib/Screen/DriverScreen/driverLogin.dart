import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:transport/Screen/DriverScreen/DriverScreen.dart';
import 'package:transport/model/driverModel.dart';
import 'package:transport/provider/tokenProvider.dart';

import '../../Service/MediaQuery.dart';
import '../../Api/apiFunction.dart';
import '../../provider/driverInfoProvider.dart';

class DriverLogin extends StatefulWidget {
  const DriverLogin({Key? key}) : super(key: key);

  @override
  State<DriverLogin> createState() => _DriverLoginState();
}

class _DriverLoginState extends State<DriverLogin> {
  ValueNotifier<bool> loading = ValueNotifier<bool>(false);
  final passwordController = TextEditingController();
  final driverIdController = TextEditingController();

  bool _hiddepassword = true;
  @override
  void dispose() {
    passwordController.clear();
    driverIdController.clear();
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
      decoration: const BoxDecoration(
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
                      const Text(
                        'Driver Login',
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
                          style: const TextStyle(
                              color: Colors.white, letterSpacing: 1),
                          controller: driverIdController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Color.fromARGB(199, 255, 254, 254),
                              ),
                              labelText: 'Driver Id',
                              hintStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(186, 226, 226, 226))),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: 300,
                          child: TextField(
                            cursorColor: Colors.white,
                            obscureText: _hiddepassword,
                            style: const TextStyle(
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
                    // ignore: deprecated_member_use
                    child: RaisedButton.icon(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        color: Colors.yellow,
                        splashColor: const Color.fromARGB(255, 255, 255, 255),
                        elevation: 30,
                        onPressed: () async {
                          Map<String, dynamic> object = {
                            "DriverID": driverIdController.text,
                            "password": passwordController.text
                          };
                          loading.value = true;
                          final result = await ApiFunction.driverLogin(
                              object: jsonEncode(object));

                          if (result['key'] != null) {
                            context.read<AuthToken>().setToken(
                                token: result['key'], who: result['role']);
                            final DriverModel result1 = DriverModel.fromJson(
                                await ApiFunction.getDriverInfo(
                                    object: jsonEncode(
                                        {"AuthKey": result['key']})));
                            context
                                .read<DriverInfoProvider>()
                                .setDriverInfo(result1);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DriverScreen()));
                          } else {
                            loading.value = false;
                            message(result['error']);
                          }

                          // loading.value = true;
                        },
                        icon: const FaIcon(FontAwesomeIcons.signInAlt,
                            color: Color.fromARGB(255, 0, 0, 0), size: 20),
                        label: const Text(
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
                    ? const SizedBox(
                        width: 100,
                        height: 100,
                        child: LoadingIndicator(
                          indicatorType:
                              Indicator.ballTrianglePathColoredFilled,
                          colors: [Colors.red, Colors.yellow, Colors.green],
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
