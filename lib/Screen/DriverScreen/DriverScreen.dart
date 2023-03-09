// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:transport/Screen/AuthScreen/Authentication.dart';
import 'package:transport/Screen/DriverScreen/Mypullingo.dart';
import 'package:transport/Screen/DriverScreen/driverDetails.dart';
import 'package:transport/Screen/LoginScreen/DecisionScreen.dart';
import 'package:transport/Screen/StudentScreen/Lottie.dart';
import 'package:transport/Screen/privacyPolicy.dart';
import 'package:transport/Screen/termsAndCondition.dart';
import 'package:transport/Service/MediaQuery.dart';
import 'package:transport/provider/driverInfoProvider.dart';
import 'package:transport/provider/tokenProvider.dart';

class DriverScreen extends StatefulWidget {
  // final String driver;
  // final String email;
  // DriverScreen({required this.driver, required this.email});
  DriverScreen();

  @override
  _DriverScreenState createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  StreamSubscription? LocationSubscription;
  bool _mytraffic = false;
  ValueNotifier<bool> loading = ValueNotifier(false);
  final Location _location = Location();
  bool checkingLocation = false;
  Timer? _mytimer;
  // Marker _myMarker = Marker(
  //     markerId: MarkerId(''),
  //     position: LatLng(0, 0),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
  bool changeMap = false;
  bool service = false;
  GoogleMapController? _mygmapController;
  _onMapCreated(GoogleMapController _gController) {
    _mygmapController = _gController;
  }

  Future<bool> backgroundService() async {
    return Location.instance.serviceEnabled().then((value) {
      return value;
    });
  }

  @override
  void initState() {
    FlutterNativeSplash.remove();
    _location.serviceEnabled().then((value) {
      if (value) {
        setState(() {
          checkingLocation = true;
        });
      }
    });
    super.initState();
  }

  Future<BitmapDescriptor> bitMapIcons() async {
    return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), 'Assets/busbit.jpg');
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
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: Color.fromARGB(255, 230, 15, 0)),
                  )),
              TextButton(
                onPressed: () {
                  context.read<AuthToken>().destroyToken();
                  // context.read<DriverInfoProvider>().stopSubscription();
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
    // ignore: prefer_const_constructors
    return Consumer<DriverInfoProvider>(builder: (context, value, child) {
      return Scaffold(
          appBar: AppBar(
            // ignore: prefer_const_literals_to_create_immutables
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
              'Driver Panel',
              style: TextStyle(color: Colors.black),
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
                              value.driverInfo.name!,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            Text(
                              '${value.driverInfo.role}',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            Text(
                              'Bus No :${value.driverInfo.routeNo}',
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
                    //   title: Text('My Student'),
                    //   tileColor: Colors.white,
                    //   leading: Icon(
                    //     Icons.bus_alert,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => DriverDetailsScreen()));
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
                  setState(() {
                    changeMap = !changeMap;
                  });
                },
                child: Icon(
                  FontAwesomeIcons.mapMarked,
                  color: Colors.lightBlue,
                ),
              ),
              FloatingActionButton(
                elevation: 20,
                backgroundColor: Colors.white,
                onPressed: () async {
                  await Location.instance.getLocation().then((result) {
                    _mygmapController?.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: LatLng(result.latitude!, result.longitude!),
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
                onPressed: () {},
                child: Icon(
                  Icons.people,
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
                    value.stopSubscription();
                  } else {
                    loading.value = true;
                    await value.updateMyLocation();
                    loading.value = false;
                  }
                },
                child: ValueListenableBuilder(
                  valueListenable: loading,
                  builder: (BuildContext context, bool value1, Widget? child) {
                    return !value1
                        ? value.locationProcess
                            ? Icon(
                                FontAwesomeIcons.stop,
                                color: Colors.red,
                              )
                            : Icon(
                                FontAwesomeIcons.play,
                                color: Colors.lightBlue,
                              )
                        : CircularProgressIndicator();
                  },
                ),
              )
            ],
          ),
          body: Stack(
            alignment: Alignment.topRight,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 1,
                child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    trafficEnabled: _mytraffic,
                    zoomControlsEnabled: false,
                    circles: value.circle,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    markers: {...value.marker},
                    mapType: !changeMap ? MapType.normal : MapType.satellite,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(12.324234234, 80.23424), zoom: 8)),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Column(
              //     children: [
              //       FloatingActionButton(
              //         backgroundColor: Colors.white,
              //         onPressed: () {
              //           _mygmapController!.
              //         },
              //         child: Icon(
              //           Icons.add,
              //           color: Colors.lightBlue,
              //         ),
              //       ),
              //       SizedBox(
              //         height: 5,
              //       ),
              //       FloatingActionButton(
              //          backgroundColor: Colors.white,
              //           onPressed: () {},
              //           child: Icon(
              //             Icons.remove,
              //             color: Colors.lightBlue,
              //           ))
              //     ],
              //   ),
              // ),
            ],
          )
          // : Lottiemap(),
          );
    });
  }
}
