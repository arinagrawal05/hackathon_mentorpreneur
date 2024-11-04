import 'package:event_mvp_app/Boarding/enter_details.dart';
import 'package:event_mvp_app/Utils/app_utils.dart';
import 'package:event_mvp_app/Boarding/controller/auth_controller.dart';
import 'package:event_mvp_app/Utils/colors.dart';
import 'package:event_mvp_app/Utils/components.dart';
import 'package:event_mvp_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class EnterOtpPage extends StatefulWidget {
  final String verificationId, phone;
  const EnterOtpPage(
      {super.key, required this.verificationId, required this.phone});

  @override
  State<EnterOtpPage> createState() => _EnterOtpPageState();
}

class _EnterOtpPageState extends State<EnterOtpPage> {
  String? otpCode;

  @override
  Widget build(BuildContext context) {
    // bool isLoading = Get.put<AuthController>(AuthController()).isLoading;
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<AuthController>(builder: (controller) {
          return SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  boldHeading("Verify Phone Number", 24),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        productTileText(
                            "Please enter the 4 digit OTP sent to", 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            productTileText(
                              widget.phone, 12,
                              // color: ColorPalatte.secondaryColor
                            ),
                            productTileText(" through SMS", 12)
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                  Pinput(
                    length: 6,
                    showCursor: true,
                    defaultPinTheme: PinTheme(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        // color: ColorPalatte.primaryColor.withOpacity(0.1),
                        // borderRadius: BorderRadius.circular(10),
                        border: Border(
                          bottom: BorderSide(
                              width: 1,
                              color: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .primary),
                          // color: Colors.purple.shade200,
                        ),
                      ),
                      textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    onChanged: (value) {
                      setState(() {
                        otpCode = value;
                      });
                    },
                    // onCompleted: (value) {
                    //   setState(() {
                    //     otpCode = value;
                    //   });
                    // },
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      productTileText(
                        "Didn’t receive OTP?",
                        14,
                      ),
                      GestureDetector(
                        onTap: () {
                          sendPhoneNumber(widget.phone);
                        },
                        child: productTileText("  Resend OTP", 14,
                            color: Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .primary),
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  controller.isLoading
                      ? customCircularLoader("Verifying")
                      : boardingButton("Verify number", () {
                          if (otpCode != null && otpCode!.length == 6) {
                            verifyOtp(context, otpCode!);
                          } else {
                            AppUtils.showSnackMessage("Enter 6-Digit code");
                          }
                        }, context),
                  const SizedBox(height: 25),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          "By continuing you’re indicating that you accept\nour ",
                      style: GoogleFonts.montserrat(
                          color: const Color(0xff7E7E7E),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Terms of Use",
                          style: GoogleFonts.montserrat(
                              decoration: TextDecoration.underline,
                              color: const Color(0xff7E7E7E),
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: " and our ",
                          style: GoogleFonts.montserrat(
                              color: const Color(0xff7E7E7E),
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: GoogleFonts.montserrat(
                              decoration: TextDecoration.underline,
                              color: const Color(0xff7E7E7E),
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // verify otp
  void verifyOtp(BuildContext context, String userOtp) {
    final controller = Get.find<AuthController>();

    controller.verifyOtp(
      context: Get.context!,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        // checking whether user exists in the db
        // ap.checkExistingUser().then(
        //   (value) async {
        // if (value == true) {
        //   // user exists in our app
        //   ap.getDataFromFirestore().then(
        //         (value) => ap.setSignIn().then(
        //           (value) {
        print("otp Success");

        controller.isUserMatch(widget.phone).then((isOldUser) {
          if (isOldUser) {
            print("its a old user");
            controller.getUserModel(widget.phone).then((model) {
              print("Got existing user model");

              controller.feedUserModel(model);
              AppUtils.setUserdata(model.toJson());
            });
            AppUtils.setpref(true);
            Navigator.pop(context);
            AppUtils.navigatedirect(HomePage(), Get.context!);
          } else {
            print("its a new user");

            AppUtils.navigatedirect(
                EnterDetailspage(phone: widget.phone), context);
          }
        });
        // AppUtils.showSnackMessage("you are logged Succesfully");
        //     },
        //   ),
        // );
        // } else {
        //   // new user
        //   Get.toNamed(RouteConstants.referral);
        // }
        // },
        // );
      },
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
