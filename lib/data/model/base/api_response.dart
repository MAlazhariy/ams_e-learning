import 'package:dio/dio.dart';
import 'package:ams_garaihy/data/datasource/remote/exception/api_error_handler.dart';
import 'package:ams_garaihy/data/model/base/error_response_model.dart';

class ApiResponse {
  final Response? _response;
  final ErrorResponse? _error;

  Response? get response => _response;
  ErrorResponse? get error => _error;
  bool get isSuccess => _response != null;

  ApiResponse.withSuccess(Response response)
      : _response = response,
        _error = null;

  ApiResponse.withError(ErrorResponse errorValue)
      : _response = null,
        _error = errorValue;

  ApiResponse.fromResponse(Response response)
      : _response = response.statusCode == 200 && response.data['status'] == true ? response : null,
        _error = response.statusCode == 200 && response.data['status'] == true ? null : ApiErrorHandler.handle(response.data['message']??response.statusMessage);
}
