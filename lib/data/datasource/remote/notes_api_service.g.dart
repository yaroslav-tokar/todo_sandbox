// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _NoteApiService implements NoteApiService {
  _NoteApiService(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
