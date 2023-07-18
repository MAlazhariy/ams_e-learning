import 'dart:io';

import 'package:ams_garaihy/utils/resources/color_manger.dart';
import 'package:flutter/material.dart';

class MainCircularProgress extends StatelessWidget {
  const MainCircularProgress({
    Key? key,
    this.color = kMainColor,
    this.strokeWidth = 4,
    this.size,
  }) : super(key: key);

  final Color color;
  final double strokeWidth;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        backgroundColor: Platform.isIOS ? color : null,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
