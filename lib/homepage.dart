import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_mvp_app/Boarding/controller/auth_controller.dart';
import 'package:event_mvp_app/Events/profile.dart';
import 'package:event_mvp_app/Events/user_card.dart';
import 'package:event_mvp_app/Events/user_model.dart';
import 'package:event_mvp_app/Utils/dummy.dart';
import 'package:event_mvp_app/search.dart';
import 'package:event_mvp_app/Utils/app_utils.dart';
import 'package:event_mvp_app/Utils/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController controller = ScrollController();
  // late String aa = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AdaptiveTheme.getThemeMode().then((value) {
      setState(() {
        isDark = value!.isDark;
      });
    });
  }

  late bool isDark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return SafeArea(
      child: Scaffold(
        // backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 150,
                        // height: 41,
                        // child:
                        //  Row(
                        //   children: [
                        //     Text(
                        //       "Mentor",
                        //       style: GoogleFonts.averageSans(
                        //           fontSize: 20,
                        //           color: Theme.of(context).indicatorColor),
                        //     ),
                        //     Text(
                        //       " Preneur",
                        //       style: GoogleFonts.averageSans(
                        //           fontSize: 20,
                        //           color: Theme.of(context).secondaryHeaderColor),
                        //     ),
                        //   ],
                        // ),
                        child: Image.asset(
                          isDark
                              ? "assets/dark_text_only.png"
                              : "assets/light_text_only.png",
                        )),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          // SharedPreferences.getInstance().then((prefs) {
                          //   final userDataJson =
                          //       prefs.getString('userdata') ?? "NA";

                          //   print(userDataJson);
                          //   print(controller.userModel.name);
                          // });
                          // pushDummyEventsToFirestore(generateDummyUsers(5));
                          AppUtils.navigateslide(Searchpage(), Get.context!);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.search,
                            size: 26,
                            // color: ColorPalatte.secondaryColor2,
                          ),
                        )),
                    GestureDetector(
                        onTap: () {
                          AppUtils.navigateslide(ProfileScreen(), Get.context!);
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(),
                          child: Icon(
                            Icons.person_rounded,
                            size: 26,
                            // color: ColorPalatte.secondaryColor2,
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Text(
                  "Personalised Picks".toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    // color: ColorPalatte.secondaryColor
                  ),
                ),
              ),
              // heading(
              //     "Hello" + AppUtils.getFirstWord(controller.userModel.name),
              //     20),
              horizontalSlider(context, controller),
              const SizedBox(
                height: 10,
              ),

              const Divider(
                thickness: 5,
                // color: ColorPalatte.secondaryColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Text(
                  "Explore Likely ${controller.userModel.type}s".toUpperCase(),
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    // color: ColorPalatte.secondaryColor
                  ),
                ),
              ),

              verticalSlider(context, controller),

              // NoticeSliderWidget(),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width,
              //   child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       // mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 8, vertical: 20),
              //           child: Row(
              //             children: [
              //               tagchip(
              //                 "All",
              //               ),
              //               tagchip(
              //                 "Today",
              //               ),
              //               tagchip(
              //                 "Tomorrow",
              //               ),
              //               tagchip(
              //                 "This Weekend",
              //               ),
              //             ],
              //           ),
              //         ),
              //         Container(
              //           margin: const EdgeInsets.symmetric(
              //             horizontal: 15,
              //           ),
              //           child: Text(
              //             "Upcoming Events".toUpperCase(),
              //             style: GoogleFonts.poppins(
              //               fontSize: 13,
              //               fontWeight: FontWeight.w400,
              //               // color: ColorPalatte.secondaryColor
              //             ),
              //           ),
              //         ),
              //       ]),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // homeEventSlider(currentStream),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pushDummyEventsToFirestore(List<UserModel> dummyEvents) async {
    try {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('Users');

      for (UserModel event in dummyEvents) {
        String docID = event.userId;
        await usersCollection.doc(docID).set(event.toMap()).then((value) {
          updateFieldInAllDocuments();
        });
      }

      print('Dummy user added to Firestore successfully!');
    } catch (error) {
      print('Error adding dummy events to Firestore: $error');
    }
    updateFieldInAllDocuments();
  }

  Widget horizontalSlider(BuildContext context, AuthController controller) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 110,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .where("skills_selected",
                  arrayContainsAny: controller.userModel.skillsSelected)
              .where("type",
                  isEqualTo: getOppositeType(controller.userModel.type))
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: customCircularLoader("Events"),
              );
            }
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return UserCard(
                      context: context,
                      user:
                          UserModel.fromFirestore(snapshot.data!.docs[index]));
                });
          }),
    );
  }

  Widget verticalSlider(BuildContext context, AuthController controller) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: 110,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .where("skills_selected",
                  arrayContainsAny: controller.userModel.skillsSelected)
              // .where("type", isEqualTo: controller.userModel.type)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: customCircularLoader("Events"),
              );
            }
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return UserCard(
                      context: context,
                      user:
                          UserModel.fromFirestore(snapshot.data!.docs[index]));
                });
          }),
    );
  }

  Future<void> updateFieldInAllDocuments() async {
    try {
      // Retrieve all documents from the collection
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Users').get();

      // Iterate over each document
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        // Update the specific field in each document
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(documentSnapshot.id)
            .update({
          "timestamp": DateTime.now(),
        });
      }

      print('Field updated in all documents');
    } catch (e) {
      print('Error updating field: $e');
    }
  }
}
