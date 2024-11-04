import 'dart:convert';

import 'package:event_mvp_app/Boarding/controller/auth_controller.dart';
import 'package:event_mvp_app/Boarding/enter_phone.dart';
import 'package:event_mvp_app/Boarding/get_started.dart';
import 'package:event_mvp_app/Events/user_model.dart';
import 'package:event_mvp_app/bottom_nav.dart';
import 'package:event_mvp_app/Utils/app_utils.dart';
import 'package:event_mvp_app/Utils/colors.dart';
import 'package:event_mvp_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AuthController auth = Get.put<AuthController>(AuthController());

    SharedPreferences.getInstance().then((prefs) {
      final userDataJson = prefs.getString('userdata') ?? "NA";

      if (userDataJson != "NA") {
        Map<String, dynamic> userModelMap = json.decode(userDataJson);
        print("$userDataJson is my json");
        auth.feedUserModel(UserModel.fromMap(userModelMap));
      } else {
        print("user data json is null");
      }
    });
    Future.delayed(const Duration(seconds: 3), () async {
      SharedPreferences.getInstance().then((prefs) {
        final isLogged = prefs.getBool('isLogged') ?? false;
        print(" this is log state$isLogged");
        if (isLogged) {
          AppUtils.navigatedirect(HomePage(), Get.context!);
        } else {
          AppUtils.navigatedirect(EnterPhonepage(), Get.context!);
        }
      });
    });
  }

  // String currentAddress = 'My Address';
  // late Position currentposition;

  // Future<Position> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     AppUtils.showSnackMessage('Please enable Your Location Service');
  //     // Fluttertoast.showToast(msg: 'Please enable Your Location Service');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       AppUtils.showSnackMessage('Location permissions are denied');

  //       // Fluttertoast.showToast(msg: '');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     AppUtils.showSnackMessage(
  //         'Location permissions are permanently denied, we cannot request permissions.');

  //     // Fluttertoast.showToast(
  //     //     msg:
  //     //         '');
  //   }

  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   try {
  //     List<Placemark> placemarks =
  //         await placemarkFromCoordinates(position.latitude, position.longitude);

  //     Placemark place = placemarks[0];

  //     setState(() {
  //       currentposition = position;
  //       currentAddress =
  //           "${place.locality}, ${place.postalCode}, ${place.country}";
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  //   return position;
  // }

  @override
  Widget build(BuildContext context) {
    var container = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(currentAddress),
          // currentposition != null
          //     ? Text('Latitude = ' + currentposition.latitude.toString())
          //     : Container(),
          // currentposition != null
          //     ? Text('Longitude = ' + currentposition.longitude.toString())
          //     : Container(),
          // TextButton(
          //     onPressed: () {
          //       // determinePosition();
          //     },
          //     child: Text('Locate me'))
        ],
      ),
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/MP_dark_bg.png"))),
    );
    return Scaffold(
      // backgroundColor: ColorPalatte.dimprimaryColor,
      body: container,
    );
  }
}
