// import 'package:upes_go/Screens/Restaurants/food_home.dart';

// import 'package:upes_go/mess_menu.dart';
// import 'package:upes_go/profile.dart';
// import 'package:upes_go/settings.dart';
import 'package:event_mvp_app/homepage.dart';
import 'package:event_mvp_app/Utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class BottomNav extends StatefulWidget {
  final int index;
  BottomNav({required this.index});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  PageController controller = PageController();
  var currentPageValue = 0.0;

  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.index;
    controller = PageController(initialPage: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        pageSnapping: false,
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        onPageChanged: (n) {
          setState(() {
            _selectedIndex = n;
          });
        },
        children: [
          HomePage(),
          HomePage(),

          // MessMenuscreen(),
          // FoodHomeScreen(),
          // ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        // color: ColorPalatte.secondaryColor2,
        padding: const EdgeInsets.only(top: 1),
        height: 50,
        child: Stack(
          alignment: Alignment.center,
          children: [
            BottomNavigationBar(
              mouseCursor: MouseCursor.uncontrolled,

              // useLegacyColorScheme: true,
              // backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
              selectedLabelStyle: GoogleFonts.montserrat(
                  // color: ColorPalatte.secondaryColor2,
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
              unselectedFontSize: 12,

              selectedFontSize: 12,
              type: BottomNavigationBarType.fixed,
              // selectedItemColor: ColorPalatte.secondaryColor2,
              // unselectedItemColor: ColorPalatte.secondaryColor2,
              unselectedLabelStyle: GoogleFonts.montserrat(
                  // color: ColorPalatte.secondaryColor2,
                  fontWeight: FontWeight.w700,
                  fontSize: 12),
              elevation: 0,

              // landscapeLayout: BottomNavigationBarLandscapeLayout.values.firs,
              enableFeedback: false,

              // fixedColor: Color.fromRGBO(29, 29, 29, 1),
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                  controller.jumpToPage(index);
                });
              },
              iconSize: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'EXPLORE DELHI',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: Colors.transparent,
                  ),
                  label: 'COLLEGE FESTS',
                ),
              ],
            ),
            Container(
              width: 1,
              height: 50,
              // color: ColorPalatte.secondaryColor2,
            )
          ],
        ),
      ),
    );
  }
}

// class BottomNav extends StatefulWidget {
//   @override
//   _BottomNavState createState() => _BottomNavState();
// }

// class _BottomNavState extends State<BottomNav> {
//   int _selectedIndex = 0;

//   static List<Widget> _widgetOptions = <Widget>[
//     HomePage(term: "exploredelhi"),
//     HomePage(term: "collegefest"),
//   ];

//   void _onItemTapped(int index) {
//     // addSearchTagToEvents().then((value) {
//     //   print("object");
//     // });
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: Container(
//         color: Color(0xff9A9FFF),
//         padding: EdgeInsets.only(top: 1),
//         height: 50,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             BottomNavigationBar(
//               mouseCursor: MouseCursor.defer,

//               useLegacyColorScheme: true,
//               backgroundColor: Color.fromRGBO(29, 29, 29, 1),
//               selectedLabelStyle: GoogleFonts.montserrat(
//                   color: Color(0xff9A9FFF),
//                   fontWeight: FontWeight.w700,
//                   fontSize: 12),
//               unselectedFontSize: 12,

//               selectedFontSize: 12,
//               type: BottomNavigationBarType.fixed,
//               selectedItemColor: Color(0xff9A9FFF),
//               unselectedItemColor: Color(0xff9A9FFF),
//               unselectedLabelStyle: GoogleFonts.montserrat(
//                   color: Color(0xff9A9FFF),
//                   fontWeight: FontWeight.w700,
//                   fontSize: 12),
//               elevation: 0,

//               // landscapeLayout: BottomNavigationBarLandscapeLayout.values.firs,
//               enableFeedback: false,

//               // fixedColor: Color.fromRGBO(29, 29, 29, 1),
//               currentIndex: _selectedIndex,
//               onTap: _onItemTapped,
//               iconSize: 0,
//               items: const [
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   label: 'EXPLORE DELHI',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.search,
//                     color: Colors.transparent,
//                   ),
//                   label: 'COLLEGE FESTS',
//                 ),
//               ],
//             ),
//             Container(
//               width: 1,
//               height: 50,
//               color: Color(0xff9A9FFF),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// Future<void> addSearchTagToEvents() async {
//   try {
//     // Get reference to the "Events" collection
//     CollectionReference eventsRef =
//         FirebaseFirestore.instance.collection('Events');

//     // Fetch all documents from the "Events" collection
//     QuerySnapshot eventsQuery = await eventsRef.get();

//     // Iterate through each document and update it
//     for (QueryDocumentSnapshot docSnapshot in eventsQuery.docs) {
//       print("hello");
//       // Get the document ID
//       String docId = docSnapshot.id;

//       // Get the existing data

//       // Extract relevant data for search tags (example: event name)

//       // Add searchTag field (you can modify this according to your search logic)
//       List<String> searchTags = ["collegefest", "exploredelhi"];

//       // Update the document with searchTag field
//       await eventsRef.doc(docId).update({'browse_tag_list': searchTags});
//     }

//     print(
//         'SearchTag added to all documents in "Events" collection successfully.');
//   } catch (e) {
//     print('Error adding searchTag to documents: $e');
//   }
// }
