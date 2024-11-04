// import 'package:event_mvp_app/Events/user_detail.dart';
// import 'package:event_mvp_app/Events/event_model.dart';
// import 'package:event_mvp_app/Utils/app_utils.dart';
// import 'package:event_mvp_app/Utils/components.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_fonts/google_fonts.dart';

// class EditorsPickSlider extends StatefulWidget {
//   final String term;

//   const EditorsPickSlider({super.key, required this.term});
//   @override
//   _EditorsPickSliderState createState() => _EditorsPickSliderState();
// }

// class _EditorsPickSliderState extends State<EditorsPickSlider> {
//   // late Stream<QuerySnapshot> _imageStream;

//   @override
//   void initState() {
//     super.initState();
//     // _imageStream = ;
//   }

//   @override
//   int _currentPage = 0;

//   Widget build(BuildContext context) {
//     return Container(
//       // width: MediaQuery.of(context).size.width,
//       // height: 500,
//       child: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('Events')
//             .where("browse_tag_list", arrayContains: widget.term)
//             .where("isEditorPick", isEqualTo: true)
//             .snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return SizedBox(
//               height: MediaQuery.of(context).size.height * 0.5,
//               child: Center(
//                 child: customCircularLoader("Events"),
//               ),
//             );
//           }

//           List<EventModel> events = snapshot.data!.docs
//               .map((doc) => EventModel.fromFirestore(doc))
//               .toList();
//           if (events.isEmpty) {
//             return Container(
//               height: MediaQuery.of(context).size.width * 0.95,
//             );
//           }
//           // if (events.length == 1) {
//           //   return Container(
//           //     child: boldHeading("data", 22),
//           //   );
//           // }
//           return sliderChild(events);
//         },
//       ),
//     );
//   }

//   Widget sliderChild(List<EventModel> modelList) {
//     return GestureDetector(
//       onTap: () {
//         AppUtils.navigateslide(
//             EventDetailPage(event: modelList[_currentPage]), context);
//       },
//       child: Column(
//         // crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CarouselSlider(
//             items: modelList.map((event) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 9),
//                 // padding: _currentPage == 0
//                 //     ? EdgeInsets.only(
//                 //         left: 12,
//                 //       )
//                 //     : _currentPage == modelList.length
//                 //         ? EdgeInsets.only(
//                 //             right: 12,
//                 //           )
//                 //         : EdgeInsets.symmetric(
//                 //             horizontal: 12,
//                 //           ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: cachedImage(
//                     event.images[0],
//                     // fit: BoxFit.cover,
//                   ),
//                   // child: boldHeading(event.images.length.toString(), 22),
//                 ),
//               );
//             }).toList(),
//             options: CarouselOptions(
//               height: MediaQuery.of(context).size.width * 0.85,
//               scrollPhysics: const BouncingScrollPhysics(),
//               // autoPlay: false,
//               aspectRatio: 1,
//               enableInfiniteScroll: false,
//               // padEnds: false,
//               viewportFraction: 0.85,
//               enlargeCenterPage: true,
//               // enlargeFactor: 3,
//               enlargeStrategy: CenterPageEnlargeStrategy.height,
//               onPageChanged: (index, reason) {
//                 setState(() {
//                   _currentPage = index;
//                 });
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 40),
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       boldHeading(
//                         modelList[_currentPage].name,
//                         12,
//                       ),
//                       boldHeading(
//                         modelList[_currentPage].price == 0
//                             ? "Free entry"
//                             : "Rs. " + modelList[_currentPage].price.toString(),
//                         12,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   margin: const EdgeInsets.only(
//                     top: 7,
//                   ),
//                   child: Row(
//                     children: [
//                       Text(
//                         modelList[_currentPage].location,
//                         style: GoogleFonts.montserrat(
//                           color: Colors.white,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const Spacer(),
//                       // boldHeading(
//                       //   AppUtils.formatDateTime(
//                       //       modelList[_currentPage].eventTime.toDate()),
//                       //   12,
//                       // ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                     margin: const EdgeInsets.only(
//                       top: 7,
//                     ),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width - 100,
//                           child: productTileText(
//                               modelList[_currentPage].description, 10,
//                               fontweight: FontWeight.w300,
//                               maxLines: 2,
//                               fontStyle: FontStyle.italic),
//                         ),
//                       ],
//                     )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
