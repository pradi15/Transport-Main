import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../Service/MediaQuery.dart';

class Pages extends StatefulWidget {
  final String title;
  final String description;
  final String lottie;

  Pages({required this.title, required this.description, required this.lottie});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
                width: double.infinity,
                height: 300,
                child: Lottie.asset('Assets/Lottie/${widget.lottie}.json',
                    repeat: false)),
          ),
          Text(
            widget.title,
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, fontFamily: ''),
          ),
          SizedBox(
            height: getProportionateScreenHeight(8),
          ),
          Container(
            width: getProportionateScreenWidth(100),
            height: getProportionateScreenHeight(2),
            color: Colors.yellow,
          ),
          SizedBox(
            height: getProportionateScreenHeight(8),
          ),
          SingleChildScrollView(
            child: Container(
              width: getProportionateScreenWidth(200),
              // height: getProportionateScreenHeight(200),
              child: Text(
                widget.description,
                // ignore: prefer_const_constructors
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 10,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
