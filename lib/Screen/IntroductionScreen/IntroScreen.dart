// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:transport/Screen/LoginScreen/DecisionScreen.dart';
import 'package:transport/Service/saveToLocal.dart';
// import 'package:transport/Screen/LoginScreen/StudentLogin.dart';
import 'package:transport/Widgets/Widget1.dart';
import 'package:transport/utils/constant.dart';

import '../../Service/MediaQuery.dart';
import 'IntroPages.dart';

class IntroductionScreen extends StatefulWidget {
  List<String> titles = [
    "Mapping",
    "Transport",
    "Student",
  ];
  List<String> description = [
    "Extend Beyond the sunday mornings & amp;the four wall of your church .Everything you need to communicate and engage with a mobile-Focused world",
    "We have brought together all of the top features that your chruch app must have.Events,Devotionals,Notifications,Notes and Multi-version Bible",
    "Allow user across the globe watch Videos,lister to audio message and watch live streams of your churuch services",
  ];
  List<String> lottie = ['Map', 'Bus', 'Student'];

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  void initState() {
     FlutterNativeSplash.remove();
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  // ignore: non_constant_identifier_names
  int CurrentPageIndex = 0;
  PageController pageControl = PageController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.close,
                    color: Color.fromRGBO(176, 176, 176, 1),
                  )
                ],
              ),
            ),
            Expanded(
              child: PageView(
                  controller: pageControl,
                  onPageChanged: (index) {
                    setState(() {
                      CurrentPageIndex = index;
                    });
                  },
                  children: List.generate(widget.lottie.length, (index) {
                    return Pages(
                      title: widget.titles[index],
                      description: widget.description[index],
                      lottie: widget.lottie[index],
                    );
                  })),
            ),
            Container(
              margin: const EdgeInsets.all(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.lottie.length, (int DotIndex) {
                  return DotColorChange(DotIndex);
                }),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: CurrentPageIndex == widget.lottie.length - 1
                    ? InkWell(
                        onTap: () {
                          SaveToLocal.saveAsBool(
                              key: Strings.isFirstTime, value: true);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  // ignore: prefer_const_constructors
                                  builder: (context) => Login()),
                              (route) => false);
                        },
                        child: RectangleLableWidget(LableName: 'Lets Go'))
                    : InkWell(
                        onTap: () {
                          pageControl.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.ease);
                        },
                        child: RectangleLableWidget(LableName: 'Next Page')))
          ],
        ),
      ),
    );
  }

  Padding DotColorChange(DotIndex) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
          width: CurrentPageIndex == DotIndex ? 20 : 10,
          height: 10,
          decoration: BoxDecoration(
              color: CurrentPageIndex == DotIndex
                  ? Colors.yellow
                  : const Color.fromRGBO(176, 176, 176, 1),
              borderRadius: const BorderRadius.all(Radius.circular(40)))),
    );
  }
}
