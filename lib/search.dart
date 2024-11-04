import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_mvp_app/Boarding/controller/auth_controller.dart';
import 'package:event_mvp_app/Events/user_card.dart';
import 'package:event_mvp_app/Events/user_model.dart';
import 'package:event_mvp_app/Utils/app_utils.dart';
import 'package:event_mvp_app/Utils/components.dart';
import 'package:event_mvp_app/theme_change_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchpage extends StatefulWidget {
  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  List<UserModel> totalUsers = [];
  List<UserModel> selectedEvents = [];
  String searchedTerm = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // randomOtp();
    // var s = FirebaseFirestore.instance
    //     .collection('Events')
    //     .where("isEditorPick", isEqualTo: true)
    //     .snapshots();

    // List<EventModel> events = snapsshot.data!.docs
    //     .map((doc) => EventModel.fromFirestore(doc))
    //     .toList();
    getAllEvents().then((value) {
      print("Got Total");
    });
  }

  Future<List<UserModel>> searchEvents(
      String searchTerm, AuthController controller) async {
    print(controller.userModel.type);
    try {
      // Ensure events are loaded before searching
      if (totalUsers.isEmpty) {
        await getAllEvents();
      }

      // Perform search on local list
      List<UserModel> searchResults = totalUsers
          .where((event) =>
              (event.name.toLowerCase().contains(searchTerm.toLowerCase()) ||

                  // event.description
                  //     .toLowerCase()
                  // .contains(searchTerm.toLowerCase()) ||
                  event.skillsSelected.any((tag) =>
                      tag.toLowerCase().contains(searchTerm.toLowerCase())) ||
                  event.occupation
                      .toLowerCase()
                      .contains(searchTerm.toLowerCase())) &&
              event.type != controller.userModel.type)
          .toList();

      return searchResults;
    } catch (e) {
      // Handle any errors that might occur
      print('Error searching events: $e');
      return [];
    }
  }

  Future<void> getAllEvents() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Users').get();
      setState(() {
        totalUsers = querySnapshot.docs
            .map((DocumentSnapshot doc) => UserModel.fromFirestore(doc))
            .toList();
      });
    } catch (e) {
      // Handle any errors that might occur
      print('Error getting events: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      // backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                const ThemeChangeButton(iconSize: 24),
                boldHeading("Search", 24),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: productTileText(
                      "Find yourself the best ${getOppositeType(controller.userModel.type)}s in your domain.",
                      12),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Container(
                      color: Theme.of(context)
                          .buttonTheme
                          .colorScheme!
                          .inversePrimary
                          .withOpacity(0.2),
                      height: 44,
                      child: TextField(
                        // enabled: !controller.isLoading,
                        // keyboardType: TextInputType.phone,
                        // controller: _phoneController,
                        onChanged: (value) {
                          setState(() {
                            searchedTerm = value;
                          });
                        },
                        decoration: const InputDecoration(
                            hintText: "Search Item",
                            // prefixIcon: Padding(
                            //   padding:
                            //       const EdgeInsets.only(top: 12, left: 10),
                            //   child: productTileText("+91 ", 14,
                            //       color: Colors.black),
                            // ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              borderSide: BorderSide(width: 0),
                            )),
                        // minLines: 1,
                        // maxLines: 1,
                        style: GoogleFonts.montserrat(
                            // color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            FutureBuilder<List<UserModel>>(
              initialData: totalUsers,
              future: searchEvents(searchedTerm, controller),
              builder: (context, snapshot) {
                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return Center(
                //     child: customCircularLoader("Events"),
                //   );
                // } else
                if (totalUsers.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: customCircularLoader("Fetching Mentors"),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: boldHeading('No Mentors available.', 20),
                  );
                } else {
                  List<UserModel> users = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      UserModel event = users[index];
                      // return boldHeading(event.name, 15);
                      return UserCard(context: context, user: event);
                    },
                  );
                }
              },
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
