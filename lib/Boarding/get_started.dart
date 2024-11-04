// ignore_for_file: must_be_immutable

import 'package:event_mvp_app/Boarding/enter_phone.dart';
import 'package:event_mvp_app/Utils/app_utils.dart';
import 'package:event_mvp_app/Utils/components.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/getStarted.png")),
            color: Color(0xff1D1D1D)),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(
                  //   height: 420,
                  // ),
                  // Image.asset("assets/getStarted.png"),
                  // AssetImage( "assets/splash.png"),
                  //     boldHeading("Sign up to ${AppConsts.appName}", 24),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: productTileText(
                  //           "Find and book the best events in your area.", 12),
                  //     ),
                  //     const SizedBox(
                  //       height: 20,
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // customCircularLoader("processing"),

                  boardingButton("Get Started", () {
                    AppUtils.navigateslide(EnterPhonepage(), context);
                  }, context),
                  const SizedBox(
                    height: 80,
                  )
                ])
          ],
        ),
      ),
    );
  }
}
