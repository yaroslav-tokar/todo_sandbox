
class Result<T> {
  bool isSuccess;
  T? data;
  Object? error;

  Result({this.isSuccess = true, this.data, this.error});
}
