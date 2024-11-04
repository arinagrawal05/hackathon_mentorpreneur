import 'package:event_mvp_app/Boarding/controller/auth_controller.dart';
import 'package:event_mvp_app/Boarding/enter_otp.dart';
import 'package:event_mvp_app/Boarding/enter_phone.dart';
import 'package:event_mvp_app/Events/user_creds.dart';
import 'package:event_mvp_app/Utils/app_utils.dart';
import 'package:event_mvp_app/Utils/components.dart';
import 'package:event_mvp_app/theme_change_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class ProfileScreen extends StatefulWidget {
  // List<Contact> contacts;
  // ProfileScreen({super.key, required this.contacts});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   if (mounted) {
    //     setState(() {});
    //     print("object");
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    // var userProvider = Provider.of<UserDataProvider>(context, listen: true);
    // User? user = FirebaseAuth.instance.currentUser;
    final controller = Get.find<AuthController>();

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          title: Text("Profile",
              style: GoogleFonts.poppins(fontWeight: FontWeight.w400)),
          // centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: const [
            ThemeChangeButton(
              iconSize: 24,
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Ionicons.notifications_outline,
                size: 24,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Container(
                  // width: double.infinity,
                  margin: const EdgeInsets.only(top: 50),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(getUserImage(true)),
                        radius: 40,
                      ),
                      heading(controller.userModel.name.toString(), 22),
                      heading1(controller.userModel.type, 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          progressBar(context),
                          progressBar(context),
                          progressBar(context),
                          progressBar(context),
                          progressBar(context),
                          progressBar(context),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              // ElevatedButton(
              // onPressed: () {
              // print("dddd");
              // String ss;
              // int ee
              // print(ss);
              // print(ss);
              // FirebaseFirestore.instance.collection("Contacts").add({
              //   "timestamp": Timestamp.now(),
              // }).then((value) {
              //   print("ss");
              // });
              // },
              // child: Text(user!.uid.toString())),
              // profiletile("User Credential", false, ontap: () {
              //   navigateslide(const UserCredScreen(), context);
              // }),
              // profiletile("Add Personal Info", false, ontap: () {
              //   navigateslide(const TakePersonalScreen(), context);
              // }),
              // profiletile("Contacts Backup", false, ontap: () {
              //   navigateslide(
              //       ContactRetentionScreen(
              //         contact: widget.contacts,
              //       ),
              //       context);
              // }),
              // profiletile("Covid Stats", false, ontap: () {
              // navigateslide(
              //     const CovidStats(
              // activeCases: covidProvider.active,
              // deathCases: covidProvider.deaths,
              // recoveredCases: covidProvider.recovered,
              // ),
              // context);
              // }),
              // profiletile("Credit", false, ontap: () {
              //   print("object");
              //   navigateslide(HomePage(), context);
              // }),
              // profiletile("Add Phone", false, ontap: () {
              //   print("object");
              //   navigateslide(const AddPhone(), context);
              // }),
              // profiletile("Add FingerPrint", false, ontap: () {
              //   print("object");
              //   navigateslide(const FingerprintPage(), context);
              // }),
              profiletile("Account Details", false, ontap: () {
                AppUtils.navigateslide(const UserCredScreen(), context);
                // AppUtils.navigateslide(
                //     const EnterOtpPage(phone: "7898291900", verificationId: ""),
                //     context);
              }),
              // profiletile("Add FingerPrint", false, ontap: () {
              //   AppUtils.setUserdata(controller.userModel.toJson());
              // }),

              profiletile("Logout", true,
                  leadingWidget: Icon(
                    Icons.login,
                    size: 24,
                    // color: Theme.of(context).buttonTheme.colorScheme!.primary,
                  ), ontap: () {
                AppUtils.setpref(false);
                AppUtils.setUserdata("NA");
                Navigator.pop(context);
                AppUtils.navigatedirect(EnterPhonepage(), Get.context!);
              }),
            ],
          ),
        ));
  }

  Container progressBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      height: 6,
      width: 40,
      decoration: BoxDecoration(
          color: Theme.of(context).buttonTheme.colorScheme!.primary,
          borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget profiletile(String title, bool isDiff,
      {Widget? leadingWidget, ontap}) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            heading(title, 18),
            isDiff
                ? leadingWidget ?? Container()
                : representationIcon(Ionicons.chevron_forward)
          ],
        ),
      ),
    );
  }

  Widget representationIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Icon(
        icon,
        size: 12,
      ),
    );
  }
}
