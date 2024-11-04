import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:event_mvp_app/Boarding/splash_screen.dart';
import 'package:event_mvp_app/Utils/const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(MyApp(
    savedThemeMode: savedThemeMode,
  ));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});
  @override
  Widget build(BuildContext context) {
    // const MyApp({this.savedThemeMode});

    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.workSans().fontFamily,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.indigo,
      ),
      dark: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.workSans().fontFamily,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.indigo,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior:
            ScrollConfiguration.of(context).copyWith(scrollbars: false),
        theme: theme,
        darkTheme: darkTheme,
        title: AppConsts.appName,
        // highContrastTheme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        home: SplashScreen(),
      ),
    );

    // return GetMaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   scrollBehavior:
    //       ScrollConfiguration.of(context).copyWith(scrollbars: false),
    //   theme: theme,
    //   darkTheme: darkTheme,
    //   title: AppConsts.appName,
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const SplashScreen(),
    // );
  }
}
