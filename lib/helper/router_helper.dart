import 'dart:convert';

import 'package:ams_garaihy/data/model/subject.dart';
import 'package:ams_garaihy/view/base/image_viewer_screen.dart';
import 'package:ams_garaihy/view/screens/no_internet/no_internet_screen.dart';
import 'package:ams_garaihy/view/screens/attend/attend_screen.dart';
import 'package:ams_garaihy/view/screens/auth/login_screen.dart';
import 'package:ams_garaihy/view/screens/auth/sign_up_screen.dart';
import 'package:ams_garaihy/view/screens/blocked_user/blocked_user_screen.dart';
import 'package:ams_garaihy/view/screens/dashboard/dashboard_screen.dart';
import 'package:ams_garaihy/view/screens/profile/change_password_screen.dart';
import 'package:ams_garaihy/view/screens/profile/edit_profile_screen.dart';
import 'package:ams_garaihy/view/screens/home/home_screen.dart';
import 'package:ams_garaihy/view/screens/lesson/videos_screen.dart';
import 'package:ams_garaihy/view/screens/on_boarding/on_board_screen.dart';
import 'package:ams_garaihy/view/screens/profile/profile_screen.dart';
import 'package:ams_garaihy/view/screens/settings/settings_screen.dart';
import 'package:ams_garaihy/view/screens/quiz/base/question_screen.dart';
import 'package:ams_garaihy/view/screens/quiz/quiz_instructions_screen.dart';
import 'package:ams_garaihy/view/screens/quiz/quiz_screen.dart';
import 'package:ams_garaihy/view/screens/sections/select_section_screen.dart';
import 'package:ams_garaihy/view/screens/student_grade/student_level_subject_exams.dart';
import 'package:ams_garaihy/view/screens/student_grade/student_level_subjects.dart';
import 'package:ams_garaihy/view/screens/update_app/update_app_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:ams_garaihy/view/screens/splash/splash_screen.dart';
import 'package:ams_garaihy/view/base/screen_not_found.dart';
import 'package:ams_garaihy/utils/routes.dart';

class RouterHelper {
  /// params handlers
  static Map<String, dynamic> getDataFrom(String data) {
    // base64url -> utf8 -> encoded json -> map
    final utf = base64Url.decode(data);
    final json = utf8.decode(utf);
    return jsonDecode(json);
  }

  static String getBase64From(Map<String, dynamic> map) {
    final json = jsonEncode(map);
    final utf = utf8.encode(json);
    return base64Url.encode(utf);
  }

  // Router
  static final FluroRouter router = FluroRouter();

  /// HANDLERS
  static final Handler _notFoundHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const ScreenNotFound();
  });

  static final Handler _splashHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const SplashScreen();
  });

  static final Handler _onBoardHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    // return const old_on_board.OnBoardScreen();
    return const OnBoardScreen();
  });

  static final Handler _loginHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const LoginScreen();
  });

  static final Handler _signUpHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const SignUpScreen();
  });

  static final Handler _dashboardHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const DashboardScreen();
  });

  static final Handler _homeHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const HomeScreen();
  });

  static final Handler _settingsHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const SettingsScreen();
  });

  static final Handler _profileHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const ProfileScreen();
  });

  static final Handler _changePasswordHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const ChangePasswordScreen();
  });

  static final Handler _editProfileHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    final bool isForced = params['data']!.first == "true";
    return EditProfileScreen(isForced: isForced);
  });

  // static final Handler _chatHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
  //   return const ChatScreen();
  // });

  static final Handler _updateScreenHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    final bool isUpdate = params['data']!.first == "true";
    return UpdateAppScreen(isUpdate: isUpdate);
  });

  static final Handler _quizScreenHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    // final ExamDetails model = ExamDetails.fromJson(getDataFrom(params['data']!.first));
    return const QuizScreen();
  });

  static final Handler _quizInstructionsScreenHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const QuizInstructionsScreen();
  });

  static final Handler _questionScreenHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const QuestionScreen();
  });

  static final Handler _lessonScreenHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const VideosScreen();
  });
  static final Handler _studentLevelScreenHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const StudentLevelSelectSubjectScreen();
  });

  static final Handler _subjectExamsScreenHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    final Subject model = Subject.fromJson(getDataFrom(params['data']!.first));
    return SubjectExamsScreen(subject: model);
  });

  static final Handler _selectSectionScreenHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const SelectSectionScreen();
  });

  static final Handler _attendScreenHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const AttendScreen();
  });

  static final Handler _blockedScreenHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const BlockedScreen();
  });

  static final Handler _noInternetScreenHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    return const NoInternetScreen();
  });

  static final Handler _imageViewerScreenHandler = Handler(handlerFunc: (context, Map<String, List<String>> params) {
    final tag = params['tag']!.first;
    final path = params['path']!.first;
    return ImageViewerScreen(heroTag: tag,imagePath: path);
  });

  /// INIT DEFINE ROUTES
  static void init() {
    router.notFoundHandler = _notFoundHandler;
    router.define(Routes.splashScreen, handler: _splashHandler, transitionType: TransitionType.fadeIn);
    router.define(Routes.onBoardScreen, handler: _onBoardHandler);
    router.define(Routes.loginScreen, handler: _loginHandler, transitionType: TransitionType.inFromLeft);
    router.define(Routes.signUpScreen, handler: _signUpHandler, transitionType: TransitionType.inFromLeft);
    router.define(Routes.dashboardScreen, handler: _dashboardHandler);
    router.define(Routes.homeScreen, handler: _homeHandler);
    router.define(Routes.settingsScreen, handler: _settingsHandler);
    router.define(Routes.profileScreen, handler: _profileHandler);
    router.define(Routes.changePasswordScreen, handler: _changePasswordHandler);
    router.define(Routes.editProfileScreen, handler: _editProfileHandler, transitionType: TransitionType.inFromBottom);
    // router.define(Routes.chatScreen, handler: _chatHandler);
    router.define(Routes.updateScreen, handler: _updateScreenHandler, transitionType: TransitionType.inFromBottom);
    router.define(Routes.quizScreen, handler: _quizScreenHandler, transitionType: TransitionType.inFromBottom);
    router.define(Routes.quizInstructionsScreen, handler: _quizInstructionsScreenHandler);
    router.define(Routes.questionScreen, handler: _questionScreenHandler);
    router.define(Routes.lessonScreen, handler: _lessonScreenHandler, transitionType: TransitionType.inFromBottom);
    router.define(Routes.studentLevelScreen, handler: _studentLevelScreenHandler, transitionType: TransitionType.inFromLeft);
    router.define(Routes.subjectExamsScreen, handler: _subjectExamsScreenHandler, transitionType: TransitionType.inFromLeft);
    router.define(Routes.selectSectionScreen, handler: _selectSectionScreenHandler);
    router.define(Routes.attendScreen, handler: _attendScreenHandler);
    router.define(Routes.blockedScreen, handler: _blockedScreenHandler);
    router.define(Routes.noInternetScreen, handler: _noInternetScreenHandler);
    router.define(Routes.imageViewerScreen, handler: _imageViewerScreenHandler);
  }
}
