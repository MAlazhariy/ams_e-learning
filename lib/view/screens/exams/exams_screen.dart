import 'package:ams_garaihy/helper/call_back/user_response_callback.dart';
import 'package:ams_garaihy/providers/profile_provider.dart';
import 'package:ams_garaihy/providers/quiz_provider.dart';
import 'package:ams_garaihy/providers/subject_provider.dart';
import 'package:ams_garaihy/utils/resources/color_manger.dart';
import 'package:ams_garaihy/utils/resources/dimensions_manager.dart';
import 'package:ams_garaihy/utils/routes.dart';
import 'package:ams_garaihy/utils/snk_bar.dart';
import 'package:ams_garaihy/view/base/internet_consumer_builder.dart';
import 'package:ams_garaihy/view/base/exam_item_widget.dart';
import 'package:ams_garaihy/view/base/main_circular_progress_adaptive.dart';
import 'package:ams_garaihy/view/base/no_available_data_widget.dart';
import 'package:ams_garaihy/view/base/subject_card.dart';
import 'package:ams_garaihy/view/screens/blocked_user/blocked_user_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamsScreen extends StatefulWidget {
  const ExamsScreen({Key? key}) : super(key: key);

  @override
  State<ExamsScreen> createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  int? _selectedSubjectId;
  bool _isBlocked = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _initData();
    });
  }

  Future<void> _initData() async {
    // get user data
    await Provider.of<ProfileProvider>(context, listen: false).getUserInfoIfNotExists().then((responseModel) async {
      await UserResponseCallback.execute(state: this, responseModel: responseModel);
      if (mounted && Provider.of<ProfileProvider>(context, listen: false).user!.isBlocked) {
        return setState(() => _isBlocked = true);
      }
    });

    if (!mounted) return;
    final int classId = Provider.of<ProfileProvider>(context, listen: false).user!.classRoom!.id;
    // get subjects
    await Provider.of<SubjectProvider>(context, listen: false).getSubjectsIfNotExists(classId: classId);
    // check saved exams
    await _checkSavedExams();
    // get exams
    await _getExamsData();
  }

  Future<void> _getExamsData() async {
    final user = Provider.of<ProfileProvider>(context, listen: false).user!;
    await Provider.of<QuizProvider>(context, listen: false).getExams(
      classId: user.classRoom!.id,
      userId: user.id,
      subjectId: _selectedSubjectId,
      groupId: user.group!.id,
      isSolved: false,
    );
  }

  Future<void> _checkSavedExams() async {
    final success = await Provider.of<QuizProvider>(context, listen: false).checkStoredExamLocalAndUpdate();
    if (success && mounted) {
      SnkBar.showSuccess(context, 'تم تحديث بيانات الاختبار على السيرفر');
    }
  }

  Future<void> _onPressSubject(int? subjectId) async {
    setState(() {
      _selectedSubjectId = subjectId;
    });
    await _getExamsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'exams'.tr(),
        ),
      ),
      body: _isBlocked
          ? const BlockedScreen()
          : InternetConsumerBuilder(
              builder: (context, internetProvider) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await _getExamsData();
                  },
                  child: Column(
                    children: [
                      // Subjects
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

                      Expanded(
                        child: Consumer<QuizProvider>(
                          builder: (context, quiz, _) {
                            if (quiz.isLoading) {
                              return const Center(
                                child: MainCircularProgress(),
                              );
                            } else if (quiz.exams.isEmpty) {
                              return NoAvailableDataWidget(
                                title: 'no_exams_available'.tr(),
                              );
                            }

                            return Padding(
                              padding: const EdgeInsetsDirectional.symmetric(
                                vertical: AppPadding.p18,
                              ),
                              child: ListView.separated(
                                itemCount: quiz.exams.length,
                                itemBuilder: (context, index) {
                                  final exam = quiz.exams[index];

                                  return ExamItemWidget(
                                    backgroundColor: getListItemColor(index),
                                    exam: exam,
                                    onTap: exam.isTimeAvailable
                                        ? () {
                                            Provider.of<QuizProvider>(context, listen: false).getExamDetails(
                                              exam.id,
                                            );
                                            Navigator.pushNamed(context, Routes.getInstructionsQuizScreen());
                                          }
                                        : null,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: AppPadding.p14);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
              onRestoreInternetConnection: () async {
                await _initData();
              },
            ),
    );
  }
}
