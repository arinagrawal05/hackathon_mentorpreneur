import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_mvp_app/Boarding/controller/auth_controller.dart';
import 'package:event_mvp_app/Utils/app_utils.dart';
import 'package:event_mvp_app/Utils/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:contacto_app/services/telephonyss.dart';
// import 'package:contacto_app/shared/components.dart';
// import 'package:contacto_app/services/telephony_provider.dart';

class UserCredScreen extends StatefulWidget {
  const UserCredScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserCredScreenState createState() => _UserCredScreenState();
}

class _UserCredScreenState extends State<UserCredScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  // final Telephony telephony = Telephony.instance;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        credInfoTile("Name", controller.userModel.name.toString()),
        credInfoTile("Phone", controller.userModel.phone),

        // credInfoTile("Email", controller.userModel.e),

        credInfoTile("Registered as", controller.userModel.type.toString()),
        credInfoTile("Registered on",
            AppUtils.formatDateTime(controller.userModel.timestamp.toDate())),
        // credInfoTile("tenantId", user!.tenantId!),

        // Spacer(),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child:
        //       boardingButton("Delete my Account Permanantly", () {}, context),
        // ),
        // credInfoTile("Phone Type", provider.phoneType),
        // credInfoTile("Sim Name", provider.simName),
        // credInfoTile("Sim Operator", provider.simOperator),
        // credInfoTile("Sim State", provider.simState),
        // credInfoTile("Signal Strenght", provider.signalStrength),
        // credInfoTile("data Network Type", provider.dataNetworkType),
        // credInfoTile("data Activity", provider.dataActivity),

        // credInfoTile("Cellular data State", provider.cellulardataState),
        // credInfoTile("Phone Type", provider.phoneType),
        // credInfoTile("Phone Type", provider.phoneType),
        // credInfoTile("Phone Type", provider.phoneType),

        // Spacer(),
        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 22),
        //   child: StandardButton(
        //       ontap: () {
        //         print("dddd");
        //         FirebaseFirestore.instance
        //             .collection("Users")
        //             .doc(user!.uid)
        //             .update({
        //           "last_refreshed": Timestamp.now(),
        //         }).then((value) {
        //           print("ss");
        //         });
        //       },
        //       title: "Refresh"),
        // ),
      ],
    ));
  }

  Widget credInfoTile(String title, String value,
      {Widget? leadingWidget, ontap, bool isDiff = false}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            heading(title, 17),
            isDiff
                ? leadingWidget!
                : Text(
                    value.toString(),
                    style: GoogleFonts.poppins(color: Colors.grey),
                  )
          ],
        ),
      ),
    );
  }
}
