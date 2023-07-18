class ErrorResponse {
  late String _message;
  int? _code;
  List<String>? _messages;

  int? get code => _code;

  List<String>? get messages => _messages;

  String get message => _message;

  bool get isResponse => _code != null;

  ErrorResponse(
    String message, {
    int? code,
    List<String>? messages,
  })  : _code = code,
        _messages = messages,
        _message = message;

  ErrorResponse.fromJson(
    Map<String, dynamic> json, {
    int? code,
    String? message,
  }) {
    _code = code ?? json["code"];
    _message = message ?? '';


    _message = message ?? (json['message'] ?? '');
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_messages != null) {
      map["code"] = _code;
      map["errors"] = _messages!.map((v) => v).toList();
    } else {
      map["code"] = _code;
      map["message"] = _message;
    }
    return map;
  }
}
