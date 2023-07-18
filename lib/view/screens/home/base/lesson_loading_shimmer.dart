import 'package:ams_garaihy/utils/resources/dimensions_manager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LessonLoadingShimmer extends StatelessWidget {
  const LessonLoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 0.83,
        crossAxisCount: 2,
        children: List.generate(
          6,
              (index) {
            return Stack(
              children: [
                // Background shimmer
                Shimmer.fromColors(
                  baseColor: Colors.grey.withAlpha(15),
                  highlightColor: Colors.grey.withAlpha(35),
                  child: Container(
                    margin:  const EdgeInsets.symmetric(
                      horizontal: AppSize.s5,
                      vertical: AppSize.s5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s10),
                      color: Colors.white,
                    ),
                    child: const SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                ),

                // items shimmer
                Container(
                  padding:  const EdgeInsets.symmetric(
                    horizontal: AppSize.s12,
                    vertical: AppSize.s10,
                  ),
                  margin:  const EdgeInsets.symmetric(
                    horizontal: AppSize.s5,
                    vertical: AppSize.s5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s10),
                    color: Colors.transparent,
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.withAlpha(30),
                    highlightColor: Colors.grey.withAlpha(55),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.s5),
                          child: Container(
                            width: 180,
                            height: 120,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: AppSize.s10),
                        // lesson name
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Container(
                              width: double.infinity,
                              height: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: 2,
                            end: 2,
                            top: AppSize.s8-1,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Container(
                              width: double.infinity,
                              height: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ),

                        // teacher
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            start: 2,
                            end: 2,
                            top: AppSize.s8+1,
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: Container(
                                width: double.infinity,
                                height: 8,
                                color: Colors.red,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
