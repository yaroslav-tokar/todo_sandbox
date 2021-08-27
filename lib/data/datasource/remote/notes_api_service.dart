import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'notes_api_service.g.dart';

@RestApi()
abstract class NoteApiService {
  factory NoteApiService(Dio dio) => _NoteApiService(dio);
}
