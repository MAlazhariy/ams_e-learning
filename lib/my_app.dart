import 'package:ams_garaihy/utils/constants.dart';
import 'package:ams_garaihy/utils/resources/assets_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ams_garaihy/helper/router_helper.dart';
import 'package:ams_garaihy/utils/resources/theme_manager.dart';
import 'package:ams_garaihy/utils/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage(ImageRes.logoReversed), context);
    precacheImage(const AssetImage(ImageRes.splashBG), context);
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: AppUri.ROOT.startsWith('http://192'),
      theme: ThemeManager.light,
      // localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: Routes.splashScreen,
      onGenerateRoute: RouterHelper.router.generator,
    );
  }
}