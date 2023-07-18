import 'package:ams_garaihy/data/model/lesson.dart';
import 'package:ams_garaihy/providers/lesson_provider.dart';
import 'package:ams_garaihy/providers/profile_provider.dart';
import 'package:ams_garaihy/providers/splash_provider.dart';
import 'package:ams_garaihy/utils/resources/color_manger.dart';
import 'package:ams_garaihy/utils/resources/dimensions_manager.dart';
import 'package:ams_garaihy/utils/resources/font_manager.dart';
import 'package:ams_garaihy/utils/resources/text_styles_manager.dart';
import 'package:ams_garaihy/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LessonCardWidget extends StatelessWidget {
  const LessonCardWidget({
    Key? key,
    required this.lesson,
    this.errorImageColor,
  }) : super(key: key);

  final Lesson lesson;
  final Color? errorImageColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(Provider.of<ProfileProvider>(context, listen: false).user!.isBlocked == false){
          Provider.of<LessonProvider>(context, listen: false).getLessonDetails(lesson.id);
          Navigator.pushNamed(context, Routes.getLessonVideosScreen());
        } else {
          Navigator.pushNamed(context, Routes.getBlockedScreen());
        }
      },

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s12,
          vertical: AppSize.s10,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppSize.s5,
          vertical: AppSize.s5,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s10),
          color: Colors.white,
        ),
        child: SizedBox(
          // width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // thumbnail
              Expanded(
                flex: 7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.s5),
                  child: Image.network(
                    '${Provider.of<SplashProvider>(context, listen: false).configModel!.baseUrls.studentImagePath}/${lesson.thumbnail}',
                    width: double.maxFinite,
                    cacheHeight: 120,
                    errorBuilder: (context, _, __){
                      return Container(
                        height: 120,
                        width: double.maxFinite,
                        color: errorImageColor,
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s14),
              // lesson name
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    lesson.title,
                    style: kSemiBoldFontStyle.copyWith(
                      color: kTitleColor,
                      fontSize: FontSize.s15,
                      overflow: TextOverflow.ellipsis,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
