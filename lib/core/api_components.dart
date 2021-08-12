class Result<T> {
  bool isSuccess;
  T? data;
  ResponseError? error;

  Result({this.isSuccess = true, this.data, this.error});
}

class ResponseError {
  Object errorBody;
  String errorCause;

  ResponseError(this.errorBody, this.errorCause);
}
