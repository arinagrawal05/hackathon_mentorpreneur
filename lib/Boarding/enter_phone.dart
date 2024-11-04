import 'package:event_mvp_app/Boarding/controller/auth_controller.dart';
import 'package:event_mvp_app/Boarding/enter_details.dart';
import 'package:event_mvp_app/Utils/app_utils.dart';
import 'package:event_mvp_app/Utils/components.dart';
import 'package:event_mvp_app/Utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterPhonepage extends StatefulWidget {
  String? phone;
  EnterPhonepage({this.phone});

  @override
  _EnterPhonepageState createState() => _EnterPhonepageState();
}

class _EnterPhonepageState extends State<EnterPhonepage> {
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // randomOtp();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<AuthController>(builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 420,
                    ),
                    boldHeading("Sign up to ${AppConsts.appName}", 24),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: productTileText(
                          "Find and Connect with the best Partners.", 12),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    customTextfield(
                      "0000000000",
                      _phoneController,
                      enabled: !controller.isLoading,
                      keyboardType: TextInputType.phone,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(top: 12, left: 10),
                        child: productTileText(
                          "+91 ",
                          14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                // customCircularLoader("processing"),
                controller.isLoading == true
                    ? customCircularLoader("sending otp")
                    : boardingButton("Sign up with phone", () {
                        // AppUtils.navigateslide(
                        //     EnterDetailspage(phone: "7898291900"), context);
                        // FirebaseFirestore.instance
                        //     .collection("Demo")
                        //     .add({"name": "Arin"}).then((value) {
                        //   print("hello its done");
                        // });
                        sendPhoneNumber(_phoneController.text);
                        // AppUtils.navigateslide(
                        //     EnterDetailspage(phone: "9898989"), context);
                      }, context),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  void sendPhoneNumber(String phone) {
    String phoneNumber = phone.trim();
    if (phoneNumber.length == 10) {
      Get.find<AuthController>().signInWithPhone(context, "+91$phoneNumber");
    } else {
      AppUtils.showSnackMessage("Enter 10 Digit phone number");
    }
  }
}
