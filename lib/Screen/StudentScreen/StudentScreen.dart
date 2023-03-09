// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_key_in_widget_constructors
// import 'dart:convert';

// import 'dart:ui';

// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transport/Screen/StudentScreen/studentDetailsScreen.dart';
import 'package:transport/Screen/privacyPolicy.dart';
import 'package:transport/Screen/termsAndCondition.dart';
import 'dart:async';
import 'package:transport/provider/studentInfoProvider.dart';
import '../../Service/MediaQuery.dart';
import '../../provider/tokenProvider.dart';
import '../LoginScreen/DecisionScreen.dart';

class StudentScreen extends StatefulWidget {
  @override
  StudentScreenState createState() => StudentScreenState();
}

StreamController<LatLng> driverCurrentLocation = StreamController<LatLng>();

class StudentScreenState extends State<StudentScreen> {
  bool _mytraffic = false;
  int i = 1;
  bool loading = false;
  MapType _mapType = MapType.normal;
  LatLng? mylocation;
  GoogleMapController? _mygmapController;
  _onMapCreated(GoogleMapController _gController) {
    _mygmapController = _gController;
  }

  bool checkingService = true;

  @override
  void initState() {
    FlutterNativeSplash.remove();
    context.read<StudentInfoProvider>().getDirverLocation();
    super.initState();
  }

  startService() async {
    Location location = Location.instance;
    final result1 = await location.requestPermission();
    final bool service = await location.enableBackgroundMode();
    final bool result = await location.requestService();
    if (result && result1 == PermissionStatus.granted) {
      if (service) {
        // location.onLocationChanged.listen((event) {
        //   print(event);
        //   mylocation = LatLng(event.latitude!, event.longitude!);
        // });
      } else {
        checkingService = false;
      }
    }
  }

// ,
  @override
  void dispose() {
    _mygmapController!.dispose();
    super.dispose();
  }

  void AuthenticatonSignout() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: Text(
              'SignOut',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              'Do you want to SignOut!?',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: Color.fromARGB(255, 230, 15, 0)),
                  )),
              TextButton(
                onPressed: () {
                  context.read<AuthToken>().destroyToken();
                  context.read<StudentInfoProvider>().stopTimer();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (ctx) => Login()),
                      (route) => false);
                },
                child: Text(
                  'confirm',
                  style: TextStyle(color: Color.fromARGB(255, 230, 15, 0)),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<StudentInfoProvider>(builder: (context, value, child) {
      return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () {
                    AuthenticatonSignout();
                  },
                  child: FaIcon(
                    FontAwesomeIcons.signInAlt,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
            centerTitle: true,
            leading: Builder(
                builder: (context) => IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(Icons.menu),
                      color: Colors.black,
                    )),
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            title: Text(
              'Student Page',
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          drawer: Drawer(
            child: Container(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipOval(
                              child: SizedBox(
                                  width: getProportionateScreenWidth(80),
                                  height: getProportionateScreenHeight(80),
                                  child: Image(
                                      image:
                                          AssetImage('Assets/student3.png'))),
                            ),
                            Text(
                              value.studentInfo.name!,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            Text(
                              'Reg No :${value.studentInfo.regNo!}',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            RaisedButton(
                                child: Container(
                                    width: getProportionateScreenWidth(80),
                                    height: getProportionateScreenHeight(20),
                                    child: Center(
                                        child: Text(
                                      "Signout",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))),
                                color: Color.fromARGB(255, 240, 16, 0),
                                onPressed: () {
                                  AuthenticatonSignout();
                                }),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // ListTile(
                    //   textColor: Colors.white,
                    //   title: Text('My Bus'),
                    //   tileColor: Colors.white,
                    //   leading: Icon(
                    //     Icons.bus_alert,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => StudentDetailsScreen()));
                      },
                      child: ListTile(
                        textColor: Colors.white,
                        title: Text('User Profile'),
                        tileColor: Colors.white,
                        leading: Icon(
                          Icons.people,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => PrivacyPolicy()));
                      },
                      child: ListTile(
                        textColor: Colors.white,
                        title: Text('Privacy Ploicy'),
                        tileColor: Colors.white,
                        leading: Icon(
                          Icons.privacy_tip,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => TermsAndCondition()));
                      },
                      child: ListTile(
                        textColor: Colors.white,
                        title: Text('Term & Condition'),
                        tileColor: Colors.white,
                        leading: Icon(
                          Icons.rule,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(color: Colors.lightBlue),
              width: double.infinity,
              height: getProportionateScreenHeight(250),
            ),
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                elevation: 20,
                backgroundColor: Colors.white,
                onPressed: () {
                  if (_mapType == MapType.normal) {
                    setState(() {
                      _mapType = MapType.satellite;
                    });
                  } else {
                    setState(() {
                      _mapType = MapType.normal;
                    });
                  }
                },
                child: Icon(
                  FontAwesomeIcons.mapMarked,
                  color: Colors.lightBlue,
                ),
              ),
              FloatingActionButton(
                elevation: 20,
                backgroundColor: Colors.white,
                onPressed: () {
                  Location.instance.getLocation().then((value) {
                    _mygmapController?.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: LatLng(value.latitude!.toDouble(),
                                value.longitude!.toDouble()),
                            zoom: 18)));
                  });
                },
                child: Icon(
                  FontAwesomeIcons.locationArrow,
                  color: Colors.lightBlue,
                ),
              ),
              FloatingActionButton(
                elevation: 20,
                backgroundColor: Colors.white,
                onPressed: () {
                  _mygmapController?.animateCamera(
                      CameraUpdate.newCameraPosition(CameraPosition(
                          target: value.driverLocation, zoom: 18)));
                },
                child: Icon(
                  FontAwesomeIcons.bus,
                  color: Colors.lightBlue,
                ),
              ),
              FloatingActionButton(
                elevation: 20,
                backgroundColor: Colors.white,
                onPressed: () {
                  if (_mytraffic == true) {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Disabled Traffic mode",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        backgroundColor: Color.fromARGB(255, 0, 0, 0),
                      ));

                      _mytraffic = false;
                    });
                  } else {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "Enabled Traffic mode",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        backgroundColor: Color.fromARGB(255, 0, 0, 0),
                      ));
                      _mytraffic = true;
                    });
                  }
                },
                child: Icon(
                  FontAwesomeIcons.trafficLight,
                  color: Colors.lightBlue,
                ),
              ),
              FloatingActionButton(
                elevation: 20,
                backgroundColor: Colors.white,
                onPressed: () async {
                  if (value.locationProcess) {
                    value.stopTimer();
                  } else {
                    setState(() {
                      loading = true;
                    });
                    await value.getDirverLocation();
                    setState(() {
                      loading = false;
                    });
                  }
                },
                child: value.locationProcess
                    ? Icon(
                        FontAwesomeIcons.stop,
                        color: Colors.red,
                      )
                    : Icon(
                        FontAwesomeIcons.play,
                        color: Colors.lightBlue,
                      ),
              )
            ],
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              loading
                  ? SizedBox(
                      width: 100,
                      height: 100,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballTrianglePathColoredFilled,
                        colors: [Colors.red, Colors.yellow, Colors.green],
                        strokeWidth: 1,
                      ),
                    )
                  : Container(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 1,
                child: ClipRect(
                  child: GoogleMap(
                      myLocationEnabled: true,
                      mapToolbarEnabled: false,
                      buildingsEnabled: true,
                      zoomControlsEnabled: false,
                      tiltGesturesEnabled: true,
                      trafficEnabled: _mytraffic,
                      onMapCreated: _onMapCreated,
                      markers: {
                        ...value.marker,
                        Marker(
                            markerId: MarkerId('Driver'),
                            position: value.driverLocation,
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueBlue)),
                      },
                      // polygons: {
                      //   Polygon(
                      //       polygonId: PolygonId(value.studentInfo.name!),
                      //       points: [
                      //         value.driverLocation,
                      //         LatLng(12.34234324, 80.342234)
                      //       ],
                      //       strokeColor: Colors.red)
                      // },
                      mapType: _mapType,
                      initialCameraPosition: CameraPosition(
                          target: value.driverLocation, zoom: 8)),
                ),
              ),
            ],
          ));
    });
  }
}
