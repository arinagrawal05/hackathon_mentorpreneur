import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_mvp_app/Utils/app_utils.dart';
import 'package:event_mvp_app/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Widget boldHeading(String text, double fontSize,
    {Color? color = null, bool center = false}) {
  return Text(text,
      textAlign: center ? TextAlign.center : null,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.none,
      ));
}

Widget heading(String text, double fontSize,
    {Color? color, bool center = false}) {
  return Text(text,
      textAlign: center ? TextAlign.center : null,
      style: GoogleFonts.montserrat(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.none,
      ));
}

Widget heading1(String text, double fontSize,
    {TextOverflow overF = TextOverflow.ellipsis,
    bool center = false,
    Color? color}) {
  return Text(
    text,
    maxLines: 2,
    style: GoogleFonts.nunito(
        color: color ?? Colors.grey,
        fontSize: fontSize,
        fontWeight: FontWeight.w500),
    overflow: overF,
    textAlign: center ? TextAlign.center : TextAlign.justify,
  );
}

Widget productTileText(String text, double fontSize,
    {TextOverflow overF = TextOverflow.ellipsis,
    bool center = false,
    Color? color = null,
    FontWeight fontweight = FontWeight.w500,
    int? maxLines,
    FontStyle? fontStyle}) {
  return Text(
    text,
    softWrap: true,
    overflow: overF,
    maxLines: maxLines,
    textAlign: center ? TextAlign.center : TextAlign.justify,
    style: GoogleFonts.manrope(
        fontStyle: fontStyle,
        fontSize: fontSize,
        fontWeight: fontweight,
        color: color),
  );
}

Widget simpleText(String text, double fontSize,
    {TextAlign align = TextAlign.left}) {
  return Text(
    text,
    textAlign: align,
    style: GoogleFonts.nunito(
      fontSize: fontSize,
    ),
  );
}

Widget boardingButton(
  String text,
  void Function()? ontap,
  BuildContext context, {
  bool isExpanded = true,
  double? height,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
    child: SizedBox(
      height: height,
      width: isExpanded ? double.infinity : null,
      child: ElevatedButton(
        // elevation: 6,
        // style: ButtonStyle(backgroundColor: ),
        // height: ,
        // height: height,

        // minWidth: isExpanded ? MediaQuery.of(context).size.width : null,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(42),
        // ),

        // color: ColorPalatte.secondaryColor2,
        onPressed: ontap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: buttonText(text, 14),
        ),
      ),
    ),
  );
}

Widget mcustomButton(
  String text,
  void Function()? ontap,
  BuildContext context, {
  bool isExpanded = true,
  double? height,
  Color color = Colors.white,
}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: MaterialButton(
      // height: ,
      height: height,
      minWidth: isExpanded ? MediaQuery.of(context).size.width : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: color,
      onPressed: ontap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: buttonText(text, 14),
      ),
    ),
  );
}

Widget buttonText(
  String text,
  double fontSize, {
  Color color = const Color(0xffFEF5EA),
}) {
  return Text(
    text,
    style: GoogleFonts.nunito(
        color: color, fontSize: fontSize, fontWeight: FontWeight.w600),
  );
}

Widget customCircularLoader(String? term) {
  return Center(
    child: Column(
      children: [
        const CircularProgressIndicator(
          strokeCap: StrokeCap.round,
          strokeWidth: 3,
          // backgroundColor: Colors.grey,
          // color: ColorPalatte.secondaryColor,
        ),
        const SizedBox(
          height: 10,
        ),
        term != null
            ? productTileText(
                term,
                15,
              )
            : Container()
      ],
    ),
  );
}

Widget cachedImage(String companyImg, {String? loaderName}) {
  return
      // Image.network(companyImg);

      CachedNetworkImage(
    imageUrl: companyImg,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)
        ),
      ),
    ),
    placeholder: (context, url) => customCircularLoader(loaderName),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}

Widget skillTag(String term) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
    margin: const EdgeInsets.symmetric(horizontal: 3),
    decoration: BoxDecoration(
      // border: Border.all(
      //     color: isActive ? ColorPalatte.secondaryColor : Colors.white),
      color: Theme.of(Get.context!)
          .buttonTheme
          .colorScheme!
          .inversePrimary
          .withOpacity(0.3),
      borderRadius: BorderRadius.circular(8),
    ),
    child: productTileText(
      term,
      10,
      fontweight: FontWeight.w400,
    ),
  );
}

Widget infoTag(String term) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    margin: const EdgeInsets.symmetric(
      horizontal: 6,
    ),
    child: Row(
      children: [
        const Icon(
          Icons.check_box,
          color: Color(0xffFEF5EA),
        ),
        const SizedBox(
          width: 10,
        ),
        productTileText(term, 10,
            fontweight: FontWeight.w400, color: const Color(0xffFEF5EA)),
      ],
    ),
  );
}

Widget dateTag(DateTime term) {
  return Container(
    // padding: const EdgeInsets.symmetric(horizontal: 8),
    margin: const EdgeInsets.symmetric(
        // horizontal: 6,
        ),
    child: Row(
      children: [
        const Icon(
          Icons.date_range,
          color: Color(0xffFEF5EA),
          size: 22,
        ),
        const SizedBox(
          width: 10,
        ),
        productTileText(AppUtils.eventDateFormater(term), 14,
            fontweight: FontWeight.w400, color: const Color(0xffFEF5EA)),
      ],
    ),
  );
}

Widget customTextfield(String hintText, TextEditingController? controller,
    {void Function(String)? onChanged,
    Widget? prefixIcon,
    bool? enabled,
    int? minLine,
    TextInputType? keyboardType,
    bool isBorderNone = false}) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(Get.context!)
                .buttonTheme
                .colorScheme!
                .inversePrimary
                .withOpacity(0.2),
          ),
          height: minLine == null ? 44 : 25 * minLine.toDouble(),
          child: TextField(
            // minLines: 2,
            maxLines: minLine,
            controller: controller,
            enabled: enabled,
            keyboardType: keyboardType,
            // controller: _phoneController,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon,
              // decoration: const InputDecoration(),
              // border:,
              // prefixIcon: Padding(
              //   padding:
              //       const EdgeInsets.only(top: 12, left: 10),
              //   child: productTileText("+91 ", 14,
              //       color: Colors.black),
              // ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              border: isBorderNone
                  ? InputBorder.none
                  : const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(width: 0),
                    ),
              // minLines: 1,
              // maxLines: 1,
              // style: GoogleFonts.montserrat(
              // color: Colors.black,
              // fontWeight: FontWeight.w400,
              // fontSize: 14),
            ),
          ),
        ),
      ));
}

Widget actionCircularAvatar(IconData icondata, BuildContext context, ontap) {
  return GestureDetector(
      onTap: ontap,
      child: CircleAvatar(
        radius: 26,
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icondata,
            size: 20,
          ),
        ),
      ));
}
