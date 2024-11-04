import 'package:event_mvp_app/Utils/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class FundamentalFunctions {
  static List extractKeySkills(String paragraph) {
    List<String> extractedWords =
        extractWords(paragraph.toLowerCase(), SkillsConst.allItems);

    if (extractedWords.isNotEmpty) {
      return extractedWords;
      // print("Target words found: $extractedWords");
    } else {
      return [];
      // print("No target words found in the paragraph.");
    }
  }

  static List<String> extractWords(String text, List<String> targetWords) {
    List<String> extractedWords = [];
    for (String word in targetWords) {
      if (text.contains(word.toLowerCase())) {
        extractedWords.add(word);
      }
    }

    return extractedWords;
  }
}

class AppUtils {
  static String getFirstWord(String fullName) {
    List local = fullName.split(" ");
    return local[0];
  }

  // static String getStatsControllerTag() {
  //   ProductType type = Get.find<DashProvider>().currentDashBoard;

  //   // GeneralStatsProvider statsController =
  //   //     Get.find<GeneralStatsProvider>(tag: 'statsFor${type.name}');

  //   return 'statsFor${type.name}';
  // }

  static String formatAmount(int number) {
    final NumberFormat numberFormat = NumberFormat("#,##0", "en_US");
    return numberFormat.format(number);
  }

  static void showSnackMessage(String title) {
    final snackBar = SnackBar(
      content: Text(title),

      // action: SnackBarAction(
      //   label: 'Undo',
      //   onPressed: () {
      //     print("object");
      //    },
      // ),
    );

    ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);

    // Get.snackbar(title, subtitle,
    //     snackPosition: SnackPosition.BOTTOM,
    //     barBlur: 3,
    //     margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20));
  }

  static List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  static String dateTimetoText(DateTime dateTime, {bool onlyDate = false}) {
    // final format = DateFormat('E, MMM d, y, h:mm a z', 'en_US');
    // Define day and month names
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    // Extract date components
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String period = hour < 12 ? 'AM' : 'PM';

    // Adjust hour for PM format
    if (hour > 12) {
      hour -= 12;
    }

    // Get the day of the week and month
    String dayOfWeek = days[dateTime.weekday - 1];
    String monthName = months[month - 1];

    // Create the formatted string
    String formattedDateTime =
        '$dayOfWeek, $monthName $day, $year, $hour:${minute.toString().padLeft(2, '0')} $period IST';

    if (onlyDate) {
      formattedDateTime = '$dayOfWeek, $monthName $day, $year';
    }
    // int month = date.month < 10
    //     ? int.parse(date.month.toString().padLeft(2, "0"))
    //     : date.month;
    return formattedDateTime;
    // return format.format(date);
  }

  static String eventDateFormater(DateTime dateTime) {
    // Format the date in the desired format
    String formattedDate =
        '${days[dateTime.weekday - 1]} ${dateTime.day} ${getMonthAbbreviation(dateTime.month)} ${dateTime.year}';

    // Format the time in the desired format
    String formattedTime = DateFormat.jm().format(dateTime);

    // Combine the formatted date and time
    return '$formattedDate at $formattedTime';
  }

  static String formatDateTime(DateTime dateTime) {
    // Format day and month
    String day = dateTime.day.toString().padLeft(2, '0');
    String month = getMonthAbbreviation(dateTime.month);

    // Format hour and AM/PM
    String hour = (dateTime.hour % 12).toString().padLeft(2, '0');
    String period = dateTime.hour < 12 ? 'AM' : 'PM';

    return '$day $month $hour$period';
  }

  static String getMonthAbbreviation(int month) {
    switch (month) {
      case 1:
        return 'JAN';
      case 2:
        return 'FEB';
      case 3:
        return 'MAR';
      case 4:
        return 'APR';
      case 5:
        return 'MAY';
      case 6:
        return 'JUN';
      case 7:
        return 'JUL';
      case 8:
        return 'AUG';
      case 9:
        return 'SEP';
      case 10:
        return 'OCT';
      case 11:
        return 'NOV';
      case 12:
        return 'DEC';
      default:
        return '';
    }
  }

  void main() {
    DateTime dateTime = DateTime.now();
    String formattedString = formatDateTime(dateTime);
    print(formattedString); // Output: 23 JAN 05PM
  }

  static String dateTimetoTimeFullFormat(DateTime dateTime) {
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String period = hour < 12 ? 'AM' : 'PM';

    // Adjust hour for PM format
    if (hour > 12) {
      hour -= 12;
    }
    // Create the formatted string
    String formattedDateTime =
        '$hour:${minute.toString().padLeft(2, '0')} $period IST';

    // int month = date.month < 10
    //     ? int.parse(date.month.toString().padLeft(2, "0"))
    //     : date.month;
    return formattedDateTime;
    // return format.format(date);
  }

  // static String todayTextFormat() {
  //   DateTime date = DateTime.now();
  //   int month = date.month;
  //   // < 10
  //   //     ? int.parse(date.month.toString().padLeft(2, "0"))
  //   //     : date.month;
  //   return "${date.day}/$month/${date.year}";
  // }

  static DateTime textToDateTime(String text) {
    List data = text.split("/");

    return DateTime(
      int.parse(data[2]),
      int.parse(data[1]),
      int.parse(data[0]),
    );
  }

  static Future<Future> navigate(
    Widget pagename,
    BuildContext context,
  ) async {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => pagename,
      ),
    );
  }

  static void navigateslide(Widget page, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static void navigatedirect(Widget page, BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static launchURL(String url) async {
    var link = Uri.parse(url);
    if (!await launchUrl(link)) {
      throw Exception('Could not launch $link');
    }
  }

  static setpref(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("isLogged", status);
    print("Now it is set${prefs.getBool("isLogged")}");
  }

  static setUserdata(String json) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("userdata", json);
    print(json);
    print("new user data json set");
  }
}

String getUserImage(bool isMale) {
  if (isMale) {
    return "https://www.shareicon.net/data/512x512/2016/05/26/771188_man_512x512.png";
  } else {
    return "https://img.freepik.com/premium-vector/avatar-icon002_750950-52.jpg";
  }
}

String getOppositeType(String currentType) {
  return currentType == "Mentor" ? "Entrepreneur" : "Mentor";
}
