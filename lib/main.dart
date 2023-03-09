import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:transport/Screen/SplashScreen/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:transport/provider/driverInfoProvider.dart';
import 'package:transport/provider/studentInfoProvider.dart';
import 'package:transport/provider/tokenProvider.dart';

void main(List<String> args) async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

/// hi testing
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthToken()),
        ChangeNotifierProvider(create: (_) => DriverInfoProvider()),
        ChangeNotifierProvider(create: (_) => StudentInfoProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "Poppins",
          inputDecorationTheme: InputDecorationTheme(
            isDense: true,
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(
                    width: 1, color: Colors.white, style: BorderStyle.solid)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(
                    width: 1, color: Colors.white, style: BorderStyle.solid)),
            labelStyle: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.white),
              borderRadius: BorderRadius.circular(7),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7),
                borderSide: const BorderSide(width: 1, color: Colors.white)),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
