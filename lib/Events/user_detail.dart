import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_mvp_app/Events/user_model.dart';
import 'package:event_mvp_app/Utils/app_utils.dart';
import 'package:event_mvp_app/Utils/components.dart';
import 'package:event_mvp_app/theme_change_button.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class UserDetailPage extends StatefulWidget {
  final UserModel user;
  const UserDetailPage({
    required this.user,
  });

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final CarouselController cardcarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    bool isMentor = widget.user.type == "Mentor" ? true : false;
    return Scaffold(
        // backgroundColor: const Color.fromRGBO(29, 29, 29, 1),
        body: SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // CarouselSlider(
                //   items: widget.event.images.map((imageUrl) {
                //     return ClipRRect(
                //       // borderRadius: BorderRadius.circular(10),
                //       child: cachedImage(
                //         imageUrl,
                //       ),
                //     );
                //   }).toList(),
                //   carouselController: cardcarouselController,
                //   options: CarouselOptions(
                //     height: MediaQuery.of(context).size.width,
                //     scrollPhysics: const BouncingScrollPhysics(),
                //     autoPlay: false,
                //     aspectRatio: 2,
                //     viewportFraction: 1,
                //     onPageChanged: (index, reason) {
                //       setState(() {
                //         _currentPage = index;
                //       });
                //     },
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: _buildIndicators(),
                // ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Stack(
                  children: [
                    Card(
                      // padding: const EdgeInsets.symmetric(
                      //     vertical: 10, horizontal: 10),
                      margin: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 10),
                      // decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     color: Theme.of(context).primaryColor),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 70,
                          ),
                          heading(widget.user.name.toString(), 20),
                          productTileText(widget.user.type, 14,
                              color: Colors.grey),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              actionCircularAvatar(
                                  Ionicons.chatbox_ellipses_outline, context,
                                  () {
                                AppUtils.launchURL("sms:${widget.user.phone}");
                              }),

                              actionCircularAvatar(
                                  Ionicons.call_outline, context, () {
                                AppUtils.launchURL("tel:${widget.user.phone}");
                              }),
                              actionCircularAvatar(
                                  Ionicons.logo_whatsapp, context, () {
                                AppUtils.launchURL(
                                    "whatsapp://send?phone=${widget.user.phone}&text=Hey,${AppUtils.getFirstWord(widget.user.name)},\n Let's Connect and make some deal!!");
                              }),
                              actionCircularAvatar(
                                  Ionicons.mail_open_outline, context, () {
                                AppUtils.launchURL(
                                    "mailto:${widget.user.phone}");
                              }),

                              // actionCircularAvatar(
                              //     Ionicons.chatbubble_ellipses_outline,
                              //     context, () {
                              //   navigateslide(
                              //       UserCallLogsScreen(
                              //         name: widget.contact!.displayName,
                              //         // photo: widget.contact!.photo!,
                              //         phone:
                              //             widget.contact!.phones.first.number,
                              //       ),
                              //       context);
                              // }),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 100,
                          width: 100,

                          // radius: 60,
                          child:
                              // widget.contact!.photo == null
                              //     ? Image.network(constuserimg)
                              //     :
                              Image.network(getUserImage(isMentor)),
                        ),
                      ),
                    ),
                  ],
                ),
                // GestureDetector(
                //   onTap: () {
                //     // AppUtils.launchURL(
                //     //     "https://www.google.com/maps?q=${widget.event.lat},${widget.event.long}");
                //   },
                //   child: productTileText("View on maps", 14,
                //       color: Colors.red.shade300),
                // ),

                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                heading(
                  isMentor ? "Skills" : "Skills Required",
                  16,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 25,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.user.skillsSelected
                          .length, // Change this to the desired number of items
                      itemBuilder: (context, index) {
                        return skillTag(
                          widget.user.skillsSelected[index],
                        );
                      }),
                ),
                const SizedBox(
                  height: 15,
                ),
                !isMentor
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          heading(
                            "Bussiness Model",
                            16,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          productTileText(widget.user.businessIdea, 14,
                              fontweight: FontWeight.w300, maxLines: 10)
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  // Widget _buildIndicators() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: List.generate(
  //       widget.event.images.length,
  //       (index) => AnimatedContainer(
  //         duration: const Duration(milliseconds: 400),
  //         margin: const EdgeInsets.symmetric(horizontal: 3.0),
  //         width: 5.0,
  //         height: 5.0,
  //         decoration: BoxDecoration(
  //           shape: BoxShape.circle,
  //           color: _currentPage == index
  //               ? Colors.white.withOpacity(0.7)
  //               : Colors.grey.withOpacity(0.7),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
