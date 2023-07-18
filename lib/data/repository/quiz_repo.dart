import 'dart:convert';

import 'package:ams_garaihy/data/datasource/remote/dio/dio_client.dart';
import 'package:ams_garaihy/data/datasource/remote/exception/api_error_handler.dart';
import 'package:ams_garaihy/data/model/base/api_response.dart';
import 'package:ams_garaihy/data/model/body/exam_body.dart';
import 'package:ams_garaihy/data/model/exam_details.dart';
import 'package:ams_garaihy/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  QuizRepo({
    required this.dioClient,
    required this.sharedPreferences,
  });

  Future<ApiResponse> getExams(ExamBody examBody) async {
    try {
      final response = await dioClient.get(
        AppUri.ALL_EXAMS,
        queryParameters: {
          "is_exercise": 0,
          ...examBody.toJson(),
        },
      );

      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResponse> getExercises(ExamBody examBody) async {
    try {
      final response = await dioClient.get(
        AppUri.ALL_EXAMS,
        queryParameters: {
          "is_exercise": 1,
          ...examBody.toJson(),
        },
      );

      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResponse> getExamDetails(int id) async {
    try {
      final response = await dioClient.get(
        AppUri.EXAM_DETAILS,
        queryParameters: {
          "exam_id": id,
        },
      );

      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResponse> updateExamStatus({
    required int degree,
    required ExamDetails exam,
  }) async {
    try {
      final response = await dioClient.post(
        AppUri.UPDATE_EXAM_STATUS,
        queryParameters: {
          "exam_id": exam.id,
          "exam_degree": degree,
        },
        data: exam.toJsonApi(),
      );
      if (response.statusCode == 200) {
        return ApiResponse.withSuccess(response);
      }

      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }

  /// This function stores an exam status locally when user is not online,
  /// and when be online it'll be updated in the server.
  ///
  /// Use this function when [updateExamStatus] throws error.
  Future<bool> storeExamStatusLocally({
    required int degree,
    required ExamDetails exam,
  }) async {
    try {
      final examParameters = {
        "exam_id": exam.id,
        "exam_degree": degree,
      };

      final examParamsString = jsonEncode(examParameters);
      final examDataString = jsonEncode(exam.toJsonApi());

      // save exam id
      /// We use this to easy get exam from local by id
      await sharedPreferences.setInt(AppStrings.TEMP_EXAM_ID, exam.id);
      // save exam status
      await sharedPreferences.setString(AppStrings.TEMP_EXAM_STATUS_PARAMS, examParamsString);
      return await sharedPreferences.setString(AppStrings.TEMP_EXAM_STATUS_DATA, examDataString);
    } catch (e) {
      rethrow;
    }
  }

  /// This function checks if there sored exam in local storage or not.
  ///
  /// If there is a stored exam it returns [id] of that exam, otherwise it returns [NULL].
  int? checkStoredExamLocal() {
    try {
      // check if there a stored exam
      return sharedPreferences.getInt(AppStrings.TEMP_EXAM_ID);
    } catch (e) {
      return null;
    }
  }

  Future<bool> clearSavedExam() async {
    await sharedPreferences.remove(AppStrings.TEMP_EXAM_ID);
    await sharedPreferences.remove(AppStrings.TEMP_EXAM_STATUS_PARAMS);
    return await sharedPreferences.remove(AppStrings.TEMP_EXAM_STATUS_DATA);
  }

  Future<ApiResponse> updateExamFromLocal() async {
    try {
      final examParamsString = sharedPreferences.getString(AppStrings.TEMP_EXAM_STATUS_PARAMS);
      final examDataString = sharedPreferences.getString(AppStrings.TEMP_EXAM_STATUS_DATA);

      final examParams = jsonDecode(examParamsString!);
      final examData = jsonDecode(examDataString!);

      // update exam status to server
      return _updateExamStatus(
        params: examParams,
        data: examData,
      );
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }

  Future<ApiResponse> _updateExamStatus({
    required Map<String, dynamic> params,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await dioClient.post(
        AppUri.UPDATE_EXAM_STATUS,
        queryParameters: params,
        data: data,
      );
      return ApiResponse.fromResponse(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.handle(e));
    }
  }

  bool isQuizAnimationEnabled() {
      return sharedPreferences.getBool(AppStrings.QUIZ_ANIMATION)??false;
  }

  Future<bool> setQuizAnimationEnabled(bool isEnabled) async {
    return await sharedPreferences.setBool(AppStrings.QUIZ_ANIMATION, isEnabled);
  }
}
