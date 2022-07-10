import 'package:aalbaya/src/pages/home_page.dart';
import 'package:aalbaya/src/styles/colors.dart';
import 'package:aalbaya/src/styles/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2340),
      builder: (context, child) {
        return GetMaterialApp(
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!);
          },
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            // if it's a RTL language
          ],
          supportedLocales: const [
            Locale('ko', 'KR'),

            // include country code too
          ],
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontSize: textsize * 0.9,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              elevation: 0,
              backgroundColor: pointcolor,
            ),
          ),
        );
      },
    );
  }
}
