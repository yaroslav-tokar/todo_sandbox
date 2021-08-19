import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final AppError? error;

  const DataState({this.data, this.error});
}

class DataStateSuccess<T> extends DataState<T> {
  DataStateSuccess(T data) : super(data: data);
}

class DataStateFailed<T> extends DataState<T> {
  DataStateFailed(AppError error) : super(error: error);
}

class AppError {
  final ErrorType? errorType;
  final Exception? error;

  AppError({this.errorType, this.error});
}

enum ErrorType { local, api }
