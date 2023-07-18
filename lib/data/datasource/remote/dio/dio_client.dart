import 'dart:io';

import 'package:ams_garaihy/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:ams_garaihy/data/datasource/remote/dio/logging_interceptor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  late final SharedPreferences sharedPreferences;
  late final String baseUrl;
  late final LoggingInterceptor loggingInterceptor;

  late Dio dio;
  late String token;
  final _schoolId = <String, dynamic>{'school_id': AppConstants.schoolId};

  DioClient(
    this.baseUrl,
    Dio dioC, {
    required this.sharedPreferences,
    required this.loggingInterceptor,
  }) {
    token = sharedPreferences.getString(AppStrings.TOKEN)??'';

    dio = dioC;
    dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = 30000
      ..options.receiveTimeout = 30000
      ..httpClientAdapter
      ..options.headers = {
        'X-localization': 'locale'.tr(),
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };
    dio.interceptors.add(loggingInterceptor);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await dio.get(
        path,
        queryParameters: {..._schoolId, ...?queryParameters},
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await dio.post(
        path,
        data: data,
        queryParameters: {..._schoolId, ...?queryParameters},
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await dio.put(
        path,
        data: data,
        queryParameters: {..._schoolId, ...?queryParameters},
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await dio.delete(
        path,
        data: data,
        queryParameters: {..._schoolId, ...?queryParameters},
        options: options,
        cancelToken: cancelToken,
      );
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}
