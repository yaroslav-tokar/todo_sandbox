import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioError? error;

  const DataState({this.data, this.error});
}

class DataStateSuccess<T> extends DataState<T> {
  DataStateSuccess(T data) : super(data: data);
}

class DataStateFailed<T> extends DataState<T> {
  DataStateFailed(DioError error) : super(error: error);
}
