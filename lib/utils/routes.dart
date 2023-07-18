
import 'package:ams_garaihy/data/model/subject.dart';
import 'package:ams_garaihy/helper/router_helper.dart';

class Routes {
  static const String splashScreen = '/';
  static const String onBoardScreen = '/on_board';
  static const String loginScreen = '/sign_in';
  static const String signUpScreen = '/sign_up';
  static const String dashboardScreen = '/dashboard';
  static const String homeScreen = '/home';
  static const String settingsScreen = '/settings';
  static const String profileScreen = '/profile';
  static const String editProfileScreen = '/edit_profile';
  static const String changePasswordScreen = '/change_password';
  static const String chatScreen = '/chat';
  static const String updateScreen = '/update_screen';
  static const String quizScreen = '/quiz_screen';
  static const String quizInstructionsScreen = '/quiz_instructions_screen';
  static const String questionScreen = '/question_screen';
  static const String lessonScreen = '/lesson_screen';
  static const String studentLevelScreen = '/student_level_screen';
  static const String subjectExamsScreen = '/subject_exams_screen';
  static const String selectSectionScreen = '/select_section_screen';
  static const String attendScreen = '/record_the_attendance_screen';
  static const String blockedScreen = '/blocked_screen';
  static const String noInternetScreen = '/no_internet_screen';
  static const String imageViewerScreen = '/image_viewer_screen';

  // Routes Getters
  static String getSplashScreen() {
    return splashScreen;
  }

  static String getOnBoardScreen() {
    return onBoardScreen;
  }

  static String getLoginScreen() {
    return loginScreen;
  }

  static String getSignUpScreen() {
    return signUpScreen;
  }

  static String getDashboardScreen() {
    return dashboardScreen;
  }

  static String getHomeScreen() {
    return homeScreen;
  }

  static String getSettingsScreen() {
    return settingsScreen;
  }

  static String getProfileScreen() {
    return profileScreen;
  }

  static String getChangePasswordScreen() {
    return changePasswordScreen;
  }

  static String getEditProfileScreen({bool isForced = false}) {
    return '$editProfileScreen?data=$isForced';
  }

  static String getChatScreen() {
    return chatScreen;
  }

  static String getUpdateAppScreen({required bool isUpdate}) {
    return "$updateScreen?data=$isUpdate";
  }

  static String getQuizScreen() {
    return quizScreen;
  }

  static String getInstructionsQuizScreen() {
    return quizInstructionsScreen;
  }

  static String getQuestionScreen() {
    return questionScreen;
  }

  static String getLessonVideosScreen() {
    return lessonScreen;
  }

  static String getSubjectsScreen() {
    return studentLevelScreen;
  }

  static String getSubjectExamsScreen(Subject subject) {
    final String data = RouterHelper.getBase64From(subject.toJson());
    return "$subjectExamsScreen?data=$data";
  }

  static String getSelectSectionScreen() {
    return selectSectionScreen;
  }

  static String getAttendScreen() {
    return attendScreen;
  }

  static String getBlockedScreen() {
    return blockedScreen;
  }

  static String getNoInternetScreen() {
    return noInternetScreen;
  }

  // static String getImageViewerScreen({required String heroTag, required String imagePath}) {
  //   return "$imageViewerScreen?tag=$heroTag&path=$imagePath";
  // }
}
