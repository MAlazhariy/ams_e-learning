import 'package:ams_garaihy/helper/call_back/user_response_callback.dart';
import 'package:ams_garaihy/providers/lesson_provider.dart';
import 'package:ams_garaihy/providers/profile_provider.dart';
import 'package:ams_garaihy/providers/quiz_provider.dart';
import 'package:ams_garaihy/providers/section_provider.dart';
import 'package:ams_garaihy/providers/subject_provider.dart';
import 'package:ams_garaihy/utils/resources/color_manger.dart';
import 'package:ams_garaihy/utils/resources/dimensions_manager.dart';
import 'package:ams_garaihy/utils/resources/text_styles_manager.dart';
import 'package:ams_garaihy/utils/routes.dart';
import 'package:ams_garaihy/utils/snk_bar.dart';
import 'package:ams_garaihy/view/base/internet_consumer_builder.dart';
import 'package:ams_garaihy/view/base/no_available_data_widget.dart';
import 'package:ams_garaihy/view/base/subject_card.dart';
import 'package:ams_garaihy/view/screens/home/base/lesson_card_widget.dart';
import 'package:ams_garaihy/view/screens/home/base/lesson_loading_shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _selectedSubjectId;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _initData();
    });
  }

  Future<void> _initData() async {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    // get user data
    await profileProvider.getUserInfoIfNotExists().then((responseModel) async {
      await UserResponseCallback.execute(state: this, responseModel: responseModel);
    });

    if (!mounted || profileProvider.user == null) return;
    final int classId = Provider.of<ProfileProvider>(context, listen: false).user!.classRoom!.id;
    // get subjects
    await Provider.of<SubjectProvider>(context, listen: false).getSubjectsIfNotExists(classId: classId);
    // get lessons
    await _getLessonsData();
    if(!mounted) return;
    // check saved exams
    await _checkSavedExams();
  }

  Future<void> _checkSavedExams() async {
    final success = await Provider.of<QuizProvider>(context, listen: false).checkStoredExamLocalAndUpdate();
    if(success && mounted){
      SnkBar.showSuccess(context, 'تم تحديث بيانات الاختبار على السيرفر');
    }
  }

  Future<void> _getLessonsData() async {
    // get lessons
    if (!mounted) return;
    final int classId = Provider.of<ProfileProvider>(context, listen: false).user!.classRoom!.id;
    await Provider.of<LessonProvider>(context, listen: false).getLessons(
      classId: classId,
      sectionId: Provider.of<SectionProvider>(context, listen: false).currentSection?.id,
      subjectId: _selectedSubjectId,
    );
  }

  Future<void> _onPressSubject(int? subjectId) async {
    debugPrint('_onPressSubject');
    setState(() {
      _selectedSubjectId = subjectId;
    });
    await _getLessonsData();
  }

  @override
  Widget build(BuildContext context) {

    return InternetConsumerBuilder(
      builder: (context, internetProvider){
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  /// app bar
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.vertical(
                        bottom: Radius.circular(20.0),
                      ),
                    ),
                    child: Consumer<ProfileProvider>(
                      builder: (context, profileProvider, _) {
                        if(profileProvider.user == null){
                          return const SizedBox.shrink();
                        }

                        final blocked = profileProvider.user!.isBlocked;

                        return SettingItemWidget(
                          title: profileProvider.user!.name,
                          titleTextColor: blocked ? kErrorColor : null,
                          subTitle: '${profileProvider.user!.group!.name}\n${Provider.of<SectionProvider>(context, listen: false).currentSection?.title??''}',
                          // trailing: GestureDetector(
                          //   onTap: () {
                          //     const NotificationScreen().launch(context);
                          //   },
                          //   child: const Image(image: AssetImage(ImageRes.notificationIcon)),
                          // ),
                          trailing: Tooltip(
                            message: 'record_the_attendance'.tr(),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, Routes.getAttendScreen());
                                  },
                                  child: const Icon(
                                    Icons.assignment_ind,
                                    color: kTitleColor,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  /// Subjects
                  Consumer<SubjectProvider>(
                    builder: (context, subjectProvider, _) {
                      if (subjectProvider.subjects.length <= 1) {
                        return const SizedBox.shrink();
                      }

                      return Container(
                        height: AppSize.s40,
                        margin: const EdgeInsetsDirectional.only(
                          top: AppSize.s8,
                          bottom: AppSize.s14,
                        ),
                        child: ListView.builder(
                          itemCount: Provider.of<SubjectProvider>(context, listen: false).subjects.length + 1,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            // all subjects
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: AppSize.s5,
                                ),
                                child: SubjectCard(
                                  title: 'all_subjects'.tr(),
                                  isSelected: _selectedSubjectId == null,
                                  onTap: () async {
                                    await _onPressSubject(null);
                                  },
                                ),
                              );
                            }

                            final subject = Provider.of<SubjectProvider>(context, listen: false).subjects[index - 1];
                            return Padding(
                              padding: EdgeInsetsDirectional.only(
                                end: index == Provider.of<SubjectProvider>(context, listen: false).subjects.length ? AppSize.s5 : 0,
                              ),
                              child: SubjectCard(
                                title: subject.title,
                                isSelected: _selectedSubjectId == subject.id,
                                onTap: () async {
                                  debugPrint('${subject.title} (${subject.id}) pressed.');
                                  await _onPressSubject(subject.id);
                                },
                              ),
                            );
                          },
                          // separatorBuilder: (context, index) {
                          //   return const SizedBox(width: AppSize.s8);
                          // },
                        ),
                      );
                    },
                  ),

                  // lessons
                  Container(
                    alignment: AlignmentDirectional.centerStart,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.s20,
                    ),
                    child: Text(
                      'lessons'.tr(),
                      style: kBoldFontStyle.copyWith(color: kTitleColor),
                    ),
                  ),
                  Consumer<LessonProvider>(
                    builder: (context, lessonProvider, _) {
                      if (lessonProvider.isLoading) {
                        return const LessonLoadingShimmer();
                      } else if (lessonProvider.lessons.isEmpty) {
                        return NoAvailableDataWidget(
                          title: 'no_lessons_available'.tr(),
                        );
                      }

                      final bool isTablet = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.shortestSide >= 600;

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: isTablet ? 0.9 : 1.1,
                          crossAxisCount: isTablet ? 4 : 2,
                          children: List.generate(
                            lessonProvider.lessons.length,
                                (index) {
                              return LessonCardWidget(
                                lesson: lessonProvider.lessons[index],
                                errorImageColor: getListItemColor(index),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      onRestoreInternetConnection: () async {
        await _initData();
      },
    );
  }
}
