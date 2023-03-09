// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:transport/Service/MediaQuery.dart';

class Lottiemap extends StatelessWidget {
  const Lottiemap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            // ignore: deprecated_member_use
            child: RaisedButton(
                // ignore: sized_box_for_whitespace
                child: Container(
                    width: getProportionateScreenWidth(200),
                    height: getProportionateScreenHeight(50),
                    child: Center(
                        child: Text(
                      "Click Me to Enable Location",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ))),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                color: Color.fromARGB(255, 240, 16, 0),
                onPressed: () {
                  Location.instance.requestService().then((value) {
                    if (value == false) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Can't Able to Enable Location",
                          style:
                              TextStyle(color: Color.fromARGB(255, 240, 0, 0)),
                        ),
                        backgroundColor: Color.fromARGB(255, 0, 0, 0),
                      ));
                    }
                  });
                }),
          ),
          Lottie.asset('Assets/map1.json')
        ],
      ),
    );
  }
}
