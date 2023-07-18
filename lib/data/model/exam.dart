import 'package:ams_garaihy/helper/api_data_helper.dart';

class Exam {
  late final int id;
  late final String title;
  late final int duration;
  late int? totalMark;
  late final int? userDegree;
  late final DateTime? startDateTime;
  late final DateTime? endDateTime;
  late final bool isExercise;

  /// The exam starting time is not come yet.
  bool? get isTimeInFuture => startDateTime?.isAfter(DateTime.now());

  /// The exam ending time is passed!
  bool? get isEndingTimePassed => endDateTime?.isBefore(DateTime.now());

  /// The exam time is available now.
  ///
  /// If [startDateTime] is passed and [endDateTime] is not over yet, it will returns [TRUE].
  bool get isTimeAvailable => isTimeInFuture == false && isEndingTimePassed == false;

  Exam.fromJson(Map<String, dynamic> json) {
    id = ApiDataHelper.getInt(json['id'])!;
    title = json['name'] ?? json['title'];
    duration = ApiDataHelper.getInt(json['duration']) ?? 15;
    totalMark = ApiDataHelper.getInt(json['total_marks']);
    userDegree = ApiDataHelper.getInt(json['user_degree']);
    startDateTime = ApiDataHelper.getDateTimeFromStamp(json['starting_time']);
    endDateTime = ApiDataHelper.getDateTimeFromStamp(json['ending_time']);
    isExercise = ApiDataHelper.getBool(json['is_exercise'])??false;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'total_marks': totalMark,
      'user_degree': userDegree,
      'starting_time': startDateTime?.toUtc().millisecondsSinceEpoch,
      'ending_time': endDateTime?.toUtc().millisecondsSinceEpoch,
      'is_exercise': isExercise,
    };
  }
}
