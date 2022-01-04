import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'adapters/presentation/common/scheme/flex_scheme.dart';
import 'adapters/presentation/routes/app_pages.dart';
import 'adapters/presentation/services/barcode_service.dart';
import 'adapters/presentation/services/bottom_navi_service.dart';
import 'adapters/presentation/services/pb_product_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await GetStorage.init();

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
      initialBinding: BindingsBuilder(
        () {
          Get.put(BarcodeService());
          Get.put(BottomNaviService());
          Get.put(PbProductSerivce());
        },
      ),
      theme: FlexThemeData.light(
        scheme: usedScheme,
        appBarElevation: 0.5,
        appBarStyle: FlexAppBarStyle.material,

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
