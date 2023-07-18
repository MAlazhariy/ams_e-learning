import 'package:ams_garaihy/providers/branch_provider.dart';
import 'package:ams_garaihy/providers/class_room_provider.dart';
import 'package:ams_garaihy/providers/grades_provider.dart';
import 'package:ams_garaihy/providers/group_provider.dart';
import 'package:ams_garaihy/providers/internet_provider_provider.dart';
import 'package:ams_garaihy/providers/lesson_provider.dart';
import 'package:ams_garaihy/providers/profile_provider.dart';
import 'package:ams_garaihy/providers/quiz_provider.dart';
import 'package:ams_garaihy/providers/section_provider.dart';
import 'package:ams_garaihy/providers/splash_provider.dart';
import 'package:ams_garaihy/providers/subject_provider.dart';
import 'package:ams_garaihy/providers/timer_provider.dart';
import 'package:ams_garaihy/utils/languages.dart';
import 'package:ams_garaihy/utils/resources/color_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ams_garaihy/helper/router_helper.dart';
import 'package:ams_garaihy/my_app.dart';
import 'package:ams_garaihy/providers/auth_provider.dart';
import 'package:ams_garaihy/utils/di_container.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // localization
  await EasyLocalization.ensureInitialized();
  // todo: firebase method
  // await Firebase.initializeApp();

  // init routes
  RouterHelper.init();

  // Setting SystemUIOverlay
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      // statusBarIconBrightness: Brightness.dark,
      statusBarColor: kPrimaryLightColor,
    ),
  );
  //Setting SystemUIMode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top]);


  // init singleton
  await Di.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Di.sl<ProfileProvider>()),
        ChangeNotifierProxyProvider<ProfileProvider, AuthProvider>(
          create: (context) => Di.sl<AuthProvider>(param1: Di.sl<ProfileProvider>()),
          update: (context, profileProvider, authProvider) => Di.sl<AuthProvider>(param1: profileProvider),
        ),
        ChangeNotifierProvider(create: (context) => Di.sl<SplashProvider>()),
        ChangeNotifierProvider(create: (context) => Di.sl<InternetProvider>()),
        ChangeNotifierProvider(create: (context) => Di.sl<BranchProvider>()),
        ChangeNotifierProvider(create: (context) => Di.sl<ClassRoomProvider>()),
        ChangeNotifierProvider(create: (context) => Di.sl<GroupProvider>()),
        ChangeNotifierProvider(create: (context) => Di.sl<LessonProvider>()),
        ChangeNotifierProvider(create: (context) => Di.sl<TimerProvider>()),
        ChangeNotifierProvider(create: (context) => Di.sl<QuizProvider>()),
        ChangeNotifierProvider(create: (context) => Di.sl<SubjectProvider>()),
        ChangeNotifierProvider(create: (context) => Di.sl<GradesProvider>()),
        ChangeNotifierProvider(create: (context) => Di.sl<SectionProvider>()),
      ],
      child: EasyLocalization(
        supportedLocales: Language.locales,
        path: 'assets/translations',
        fallbackLocale: const Locale('ar'),
        child: const MyApp(),
      ),
    ),
  );
}
