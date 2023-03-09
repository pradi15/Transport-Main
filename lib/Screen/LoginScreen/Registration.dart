// // ignore_for_file: prefer_const_constructors

// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:transport/Screen/AuthScreen/Authentication.dart';
// import 'package:transport/Screen/ValidationScreen/validate.dart';
// import 'package:transport/Service/MediaQuery.dart';

// import '../../Widgets/Widget1.dart';

// class DriverLogin extends StatefulWidget {
//   const DriverLogin({Key? key}) : super(key: key);

//   @override
//   _DriverLoginState createState() => _DriverLoginState();
// }

// class _DriverLoginState extends State<DriverLogin> {
//   List DriverDetails = [];
//   List Roles = ['Student', 'Driver'];
//   String? _myLocationName;
//   String? _myRole;
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();

//   TextEditingController _busController = TextEditingController();
//   TextEditingController _RetypepasswordController = TextEditingController();
//   FocusNode? _passwordNode;
//   FocusNode? _emailNode;
//   FocusNode? _busNode;
//   FocusNode? _retypepasswordNode;
//   FocusNode? DropDown1;
//   FocusNode? DropDown2;

//   void clear() {
//     _passwordController.clear();
//     _emailController.clear();
//   }

//   @override
//   void dispose() {
//     _emailNode!.unfocus();
//     _passwordNode!.unfocus();
//     _busNode!.unfocus();
//     _retypepasswordNode!.unfocus();
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   void initState() {
//     _passwordNode = FocusNode();
//     _emailNode = FocusNode();
//     _busNode = FocusNode();
//     _retypepasswordNode = FocusNode();
//     DropDown1 = FocusNode();
//     DropDown2 = FocusNode();
//     FechingDriverDetails();
//     super.initState();
//   }

//   Future FechingDriverDetails() async {
//     await FirebaseFirestore.instance.collection('Userinfo').get().then((value) {
//       print(value.docs.length);
//       value.docs.forEach((element) {
//         if (element['role'] == 'Driver') {
//           DriverDetails.add(element['DriverBus'].toString());
//           print(DriverDetails);
//         }
//       });
//     });
//   }

//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//             colorFilter: ColorFilter.mode(Colors.black12, BlendMode.darken),
//             image: AssetImage("Assets/bus4.jpg"),
//             fit: BoxFit.cover,
//             opacity: 0.6),
//       ),
//       child: Scaffold(
//         backgroundColor: Color.fromARGB(0, 207, 204, 204),
//         body: SingleChildScrollView(
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         child: SafeArea(
//                             child: Icon(
//                           Icons.keyboard_arrow_left,
//                           size: 50,
//                           color: Color.fromARGB(221, 211, 204, 204),
//                         )),
//                       ),
//                     ),
//                     Container(
//                       alignment: Alignment.topRight,
//                       child: SafeArea(
//                         child: Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: FaIcon(
//                             FontAwesomeIcons.questionCircle,
//                             color: Color.fromARGB(171, 255, 255, 255),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Column(
//                       // ignore: prefer_const_literals_to_create_immutables
//                       children: [
//                         // ignore: prefer_const_constructors
//                         Text(
//                           'Transport',
//                           // ignore: prefer_const_constructors
//                           style: TextStyle(
//                               fontFamily: "Poppins",
//                               fontSize: 30,
//                               letterSpacing: 2,
//                               color: Color.fromARGB(255, 255, 255, 255)),
//                         ),
//                         // ignore: prefer_const_constructors
//                         Text(
//                           'Register Form',
//                           // ignore: prefer_const_constructors
//                           style: TextStyle(
//                               fontFamily: "Poppins",
//                               fontSize: 35,
//                               letterSpacing: 1,
//                               color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Container(
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                   width: 1,
//                                   color: Color.fromARGB(172, 224, 223, 223)),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20))),
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           child: TextField(
//                             cursorColor: Colors.white,
//                             focusNode: _emailNode,
//                             onSubmitted: (_) {
//                               _emailNode!.unfocus();

//                               FocusScope.of(context)
//                                   .requestFocus(_passwordNode);
//                             },
//                             style: TextStyle(
//                                 color: Colors.white, letterSpacing: 1),
//                             controller: _emailController,
//                             // textInputAction: TextInputAction.next,
//                             // ignore: prefer_const_constructors
//                             decoration: InputDecoration(
//                                 prefixIcon: Icon(
//                                   Icons.email,
//                                   color: Color.fromARGB(199, 255, 254, 254),
//                                 ),
//                                 hintText: 'Enter your Email',
//                                 enabledBorder: InputBorder.none,
//                                 focusedBorder: InputBorder.none,
//                                 hintStyle: TextStyle(
//                                     fontSize: 20,
//                                     color: Color.fromARGB(186, 226, 226, 226))),
//                           )),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Container(
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                   width: 1,
//                                   color: Color.fromARGB(172, 224, 223, 223)),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20))),
//                           child: TextField(
//                             cursorColor: Colors.white,
//                             focusNode: _passwordNode,
//                             style: TextStyle(
//                                 color: Colors.white, letterSpacing: 1),
//                             controller: _passwordController,
//                             // textInputAction: TextInputAction.done,
//                             // ignore: prefer_const_constructors
//                             decoration: InputDecoration(
//                                 prefixIcon: Icon(
//                                   Icons.password,
//                                   color: Color.fromARGB(199, 255, 254, 254),
//                                 ),
//                                 hintText: 'Enter your Password',
//                                 // ignore: prefer_const_constructors
//                                 hintStyle: TextStyle(
//                                     fontSize: 20,
//                                     color: Color.fromARGB(199, 255, 254, 254)),
//                                 enabledBorder: InputBorder.none,
//                                 focusedBorder: InputBorder.none),
//                             onSubmitted: (_) {
//                               FocusScope.of(context)
//                                   .requestFocus(_retypepasswordNode);
//                             },
//                           )),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Container(
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                   width: 1,
//                                   color: Color.fromARGB(172, 224, 223, 223)),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(20))),
//                           child: TextField(
//                             cursorColor: Colors.white,
//                             focusNode: _retypepasswordNode,
//                             style: TextStyle(
//                                 color: Colors.white, letterSpacing: 1),
//                             controller: _RetypepasswordController,
//                             // textInputAction: TextInputAction.done,
//                             // ignore: prefer_const_constructors
//                             decoration: InputDecoration(
//                                 prefixIcon: Icon(
//                                   Icons.password,
//                                   color: Color.fromARGB(199, 255, 254, 254),
//                                 ),
//                                 hintText: 'Enter ReType-Password',
//                                 // ignore: prefer_const_constructors
//                                 hintStyle: TextStyle(
//                                     fontSize: 20,
//                                     color: Color.fromARGB(199, 255, 254, 254)),
//                                 enabledBorder: InputBorder.none,
//                                 focusedBorder: InputBorder.none),
//                             onSubmitted: (_) {
//                               FocusScope.of(context).requestFocus(DropDown1);
//                             },
//                           )),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.8,
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                                 width: 1,
//                                 color: Color.fromARGB(172, 224, 223, 223)),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(20))),
//                         // ignore: prefer_const_constructors
//                         child: DropdownButton(
//                             isExpanded: true,
//                             hint: Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Text(
//                                 'Select',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                             icon: Icon(
//                               Icons.keyboard_arrow_down_sharp,
//                               color: Colors.white,
//                             ),
//                             underline: Container(
//                               color: Colors.transparent,
//                             ),
//                             borderRadius: BorderRadius.all(Radius.circular(20)),
//                             dropdownColor: Colors.black,
//                             menuMaxHeight:
//                                 MediaQuery.of(context).size.height * 0.2,
//                             items: Roles.map((e) {
//                               return DropdownMenuItem(
//                                 onTap: () {
//                                   setState(() {
//                                     if (_myRole == 'Student') {
//                                       FocusScope.of(context)
//                                           .requestFocus(_busNode);
//                                     }
//                                     _myRole = e;
//                                   });
//                                 },
//                                 child: Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Text(
//                                     e.toString(),
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                                 value: e,
//                               );
//                             }).toList(),
//                             onChanged: (_) {
//                               if (_myRole == 'Driver') {
//                                 FocusScope.of(context).requestFocus(_busNode);
//                               }
//                             },
//                             value: _myRole),
//                       ),
//                     ),
//                     _myRole == 'Student'
//                         ? Padding(
//                             padding: EdgeInsets.all(16.0),
//                             child: Container(
//                               width: MediaQuery.of(context).size.width * 0.8,
//                               decoration: BoxDecoration(
//                                   border: Border.all(
//                                       width: 1,
//                                       color:
//                                           Color.fromARGB(172, 224, 223, 223)),
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(20))),
//                               // ignore: prefer_const_constructors
//                               child: DropdownButton(
//                                   autofocus: true,
//                                   isExpanded: true,
//                                   focusNode: DropDown2,
//                                   onChanged: (_) {},
//                                   hint: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Text(
//                                       'Select Bus',
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                   icon: Icon(
//                                     Icons.keyboard_arrow_down_sharp,
//                                     color: Colors.white,
//                                   ),
//                                   underline: Container(
//                                     color: Colors.transparent,
//                                   ),
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(20)),
//                                   dropdownColor: Colors.black,
//                                   menuMaxHeight:
//                                       MediaQuery.of(context).size.height * 0.2,
//                                   items: DriverDetails.map((e) {
//                                     return DropdownMenuItem(
//                                       onTap: () {
//                                         setState(() {
//                                           _myLocationName = e;
//                                         });
//                                       },
//                                       child: Padding(
//                                         padding: EdgeInsets.all(8.0),
//                                         child: Text(
//                                           e.toString(),
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                       ),
//                                       value: e,
//                                     );
//                                   }).toList(),
//                                   value: _myLocationName),
//                             ),
//                           )
//                         : Padding(
//                             padding: EdgeInsets.all(16.0),
//                             child: Container(
//                                 width: MediaQuery.of(context).size.width * 0.8,
//                                 decoration: BoxDecoration(
//                                     border: Border.all(
//                                         width: 1,
//                                         color:
//                                             Color.fromARGB(172, 224, 223, 223)),
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(20))),
//                                 child: TextField(
//                                   cursorColor: Colors.white,
//                                   focusNode: _busNode,
//                                   // ignore: prefer_const_constructors
//                                   style: TextStyle(
//                                       color: Colors.white, letterSpacing: 1),
//                                   controller: _busController,
//                                   // ignore: prefer_const_constructors
//                                   decoration: InputDecoration(
//                                       prefixIcon: const Icon(
//                                         Icons.bus_alert,
//                                         color:
//                                             Color.fromARGB(199, 255, 254, 254),
//                                       ),
//                                       hintText: 'Enter Bus Name',
//                                       // ignore: prefer_const_constructors
//                                       hintStyle: TextStyle(
//                                           fontSize: 20,
//                                           color: Color.fromARGB(
//                                               199, 255, 254, 254)),
//                                       enabledBorder: InputBorder.none,
//                                       focusedBorder: InputBorder.none),
//                                 )),
//                           ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Container(
//                     child: RaisedButton.icon(
//                         color: Colors.yellow,
//                         splashColor: Color.fromARGB(255, 255, 255, 255),
//                         elevation: 30,
//                         onPressed: () {
//                           if (_myRole == 'Student') {
//                             Validating.ValidingStudentRegisterForm(
//                                     _emailController.text,
//                                     _passwordController.text,
//                                     _RetypepasswordController.text,
//                                     _myRole.toString(),
//                                     _myLocationName.toString())
//                                 .then(
//                               (value) {
//                                 if (value == 'Success') {
//                                   Authentication().signupFirebase(
//                                       _emailController.text,
//                                       _passwordController.text,
//                                       _myRole.toString(),
//                                       _myLocationName.toString(),
//                                       context);
//                                   _emailController.clear();
//                                   _passwordController.clear();
//                                   _RetypepasswordController.clear();
//                                 } else {
//                                   ScaffoldMessenger.of(context)
//                                       .showSnackBar(SnackBar(
//                                     behavior: SnackBarBehavior.floating,

//                                     margin: EdgeInsets.only(
//                                         bottom:
//                                             MediaQuery.of(context).size.height -
//                                                 100),
//                                     // ignore: prefer_const_constructors
//                                     content: Text(
//                                       'Alert! : ${value}',
//                                       style: TextStyle(
//                                           fontFamily: 'Poppins',
//                                           color:
//                                               Color.fromARGB(255, 255, 0, 0)),
//                                     ),
//                                     backgroundColor:
//                                         Color.fromARGB(255, 0, 0, 0),
//                                   ));
//                                 }
//                               },
//                             );
//                           } else {
//                             Validating.ValidingDriverRegisterForm(
//                                     _emailController.text,
//                                     _passwordController.text,
//                                     _RetypepasswordController.text,
//                                     _myRole.toString(),
//                                     _busController.text)
//                                 .then((value) {
//                               if (value == 'Success') {
//                                 Authentication().signupFirebase(
//                                     _emailController.text,
//                                     _passwordController.text,
//                                     _myRole.toString(),
//                                     _busController.text,
//                                     context);
//                                 _emailController.clear();
//                                 _passwordController.clear();
//                                 _RetypepasswordController.clear();
//                               } else {
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(SnackBar(
//                                   behavior: SnackBarBehavior.floating,

//                                   margin: EdgeInsets.only(
//                                       bottom:
//                                           MediaQuery.of(context).size.height -
//                                               100),
//                                   // ignore: prefer_const_constructors
//                                   content: Text(
//                                     'Alert! : ${value}',
//                                     style: TextStyle(
//                                         fontFamily: 'Poppins',
//                                         color: Color.fromARGB(255, 255, 0, 0)),
//                                   ),
//                                   backgroundColor: Color.fromARGB(255, 0, 0, 0),
//                                 ));
//                               }
//                             });
//                           }
//                         },
//                         icon: FaIcon(FontAwesomeIcons.solidRegistered,
//                             color: Color.fromARGB(255, 0, 0, 0), size: 20),
//                         label: Text(
//                           'Register',
//                           style: TextStyle(fontSize: 15),
//                         )),
//                     width: getProportionateScreenWidth(300),
//                     height: getProportionateScreenHeight(40),
//                   ),
//                 )
//               ]),
//         ),
//       ),
//     );
//   }
// }
