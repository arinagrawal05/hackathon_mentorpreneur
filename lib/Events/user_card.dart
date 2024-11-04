import 'package:event_mvp_app/Events/user_detail.dart';
import 'package:event_mvp_app/Events/user_model.dart';
import 'package:event_mvp_app/Utils/app_utils.dart';
import 'package:event_mvp_app/Utils/components.dart';
import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  const UserCard({
    super.key,
    required this.context,
    // required this.context,
    required this.user,
  });

  final BuildContext context;
  // final BuildContext context;
  final UserModel user;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppUtils.navigateslide(UserDetailPage(user: widget.user), context);
      },
      child: Card(
        // height: 193,
        // width: MediaQuery.of(context).size.width - 32,
        // margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(15),
        // ),
        margin: EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(getUserImage(widget.user.isMale)),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stack(
                  //   alignment: Alignment.bottomCenter,
                  //   children: [
                  //     CarouselSlider(
                  //       items: widget.event.images.map((imageUrl) {
                  //         return ClipRRect(
                  //           borderRadius: BorderRadius.circular(10),
                  //           child: cachedImage(
                  //             imageUrl,
                  //           ),
                  //         );
                  //       }).toList(),
                  //       carouselController: cardcarouselController,
                  //       options: CarouselOptions(
                  //         height: MediaQuery.of(context).size.width - 32,
                  //         scrollPhysics: const BouncingScrollPhysics(),
                  //         autoPlay: false,
                  //         aspectRatio: 2,
                  //         viewportFraction: 1,
                  //         onPageChanged: (index, reason) {
                  //           setState(() {
                  //             _currentPage = index;
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: _buildIndicators(),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    // width: MediaQuery.of(context).size.width,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        boldHeading(
                          widget.user.name,
                          16,
                        ),
                        Text(widget.user.occupation),
                        // skillTag(widget.user.type),

                        // boldHeading(
                        //   widget.event.price == 0
                        //       ? "Free entry"
                        //       : "Rs. ${widget.event.price}",
                        //   12,
                        // ),
                      ],
                    ),
                  ),
                  // boldHeading(
                  //   widget.user.skillsSelected.toString(),
                  //   12,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
