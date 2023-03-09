// // ignore_for_file: prefer_const_constructors

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:transport/Screen/DriverScreen/DriverScreen.dart';
// import 'package:transport/Screen/LoginScreen/DecisionScreen.dart';
// import 'package:transport/Screen/StudentScreen/StudentScreen.dart';
// import 'package:transport/Service/SharePrefernce.dart';
// // import 'package:transport/provider/loading.dart';

// // import '../LoginScreen/StudentLogin.dart';

// class Authentication {
//   final FirebaseAuthentication = FirebaseAuth.instance;

//   Future LoginUser(TextEditingController emailController, _email,
//       TextEditingController passwordController, _password, context) async {
//     try {

//       await FirebaseAuthentication.signInWithEmailAndPassword(
//               email: _email, password: _password)
//           .then((value) {
//         CheckingRole(value.user?.uid, context, _email);
//         emailController.clear();
//         passwordController.clear();

//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(
//             "Sucess!!,just wait we are processing on it",
//             style: TextStyle(color: Colors.black),
//           ),
//           backgroundColor: Colors.white,
//         ));
//       });
//     } catch (e) {

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(

//         content: Text(
//           "Invalid userName or Password",
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//       ));
//     }
//   }

//   Future signupFirebase(
//       _email, _password, String role, String placeorBusName, context) async {
//     try {
//       await FirebaseAuthentication.createUserWithEmailAndPassword(
//               email: _email, password: _password)
//           .then((value) {
//         print(value.user?.email);
//         print(value.user?.uid);
//         print(placeorBusName);
//         print(role == 'Driver');
//         print(role);
//         final email = value.user?.email.toString();
//         final userid = value.user?.uid.toString();
//         if (role == 'Driver') {
//           setupDriverinFirebase(email, userid, role, placeorBusName, context);
//         } else {
//           setupStudentinFirebase(email, userid, role, placeorBusName, context);
//         }
//       });
//       return true;
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   void CheckingRole(userId, context, email) async {
//     print('=============================================${userId}');
//     await FirebaseFirestore.instance
//         .collection('Userinfo')
//         .doc(userId)
//         .get()
//         .then((value) {
//       print(value['role']);
//       Caches().saveString('Email', email);
//       switch (value['role']) {
//         case "Student":
//           Caches().saveString('Role', value["role"]);
//           Caches().saveString('BusName', value["BusName"]);
//           // Navigator.pushAndRemoveUntil(
//           //     context,
//           //     MaterialPageRoute(
//           //         builder: (context) => StudentScreen(
//           //               email: email,
//           //               BusName: value['BusName'],
//           //             )),
//           //     (route) => false);
//           break;
//         case "Driver":
//           Caches().saveString('Role', value["role"]);
//           Caches().saveString('DriverBus', value["DriverBus"]);
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => DriverScreen(
//                         email: email,
//                         driver: value['DriverBus'],
//                       )),
//               (route) => false);
//           break;
//         default:
//           print('Did not Register');
//       }
//     });
//   }

//   void setupDriverinFirebase(email, uid, role, BusName, context) async {
//     await FirebaseFirestore.instance.collection('Userinfo').doc(uid).set({
//       'email': email,
//       'role': role,
//       'DriverBus': BusName,
//     }).whenComplete(() {
//       setupDriverTracking(uid, context, BusName);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         // ignore: prefer_const_constructors
//         content: Text(
//           "Successfully Added",
//           style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
//         ),
//         backgroundColor: Color.fromARGB(255, 255, 255, 255),
//       ));
//     });
//   }

//   void setupStudentinFirebase(email, uid, role, place, context) async {
//     await FirebaseFirestore.instance.collection('Userinfo').doc(uid).set({
//       'email': email,
//       'role': role,
//       'BusName': place,
//     }).whenComplete(() {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         // ignore: prefer_const_constructors
//         content: Text(
//           "Successfully Added",
//           style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
//         ),
//         backgroundColor: Color.fromARGB(255, 255, 255, 255),
//       ));
//     });
//   }

//   void setupDriverTracking(uid, context, BusName) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('DriverTracking')
//           .doc(BusName)
//           .set({
//         'Lat': 13.22.toString(),
//         'Long': 22.44.toString(),
//       }).whenComplete(() {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(
//             "Successfully Added Driver Tracking",
//             style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
//           ),
//           backgroundColor: Color.fromARGB(255, 255, 255, 255),
//         ));
//       });
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   void signout(context) {
//     FirebaseAuth.instance.signOut().then((value) {
//       Caches().removeCaches('Email');
//       Caches().removeCaches('BusName');
//       Caches().removeCaches('DriverBus');

//       Navigator.pushAndRemoveUntil(context,
//           MaterialPageRoute(builder: (context) {
//         return Login();
//       }), (route) => false);
//     });
//   }
// }
