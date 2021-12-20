import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'adapter/presentation/common/scheme/flex_scheme.dart';
import 'adapter/presentation/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const usedScheme = FlexScheme.rosewood;

    return GetMaterialApp.router(
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
      theme: FlexThemeData.light(
        scheme: usedScheme,
        appBarElevation: 0.5,

        /// 폰트
        fontFamily: GoogleFonts.gamjaFlower().fontFamily,

        /// 커스텀 색상
        colors: flexScheme.light,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: usedScheme,
        appBarElevation: 2,

        /// 폰트
        fontFamily: GoogleFonts.gamjaFlower().fontFamily,

        /// 커스텀 색상
        // colors: flexScheme.dark,
      ),
      themeMode: ThemeMode.system,
      getPages: AppPages.routes,
    );
  }
}
