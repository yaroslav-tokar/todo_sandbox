import 'package:get_it/get_it.dart';
import 'package:todo_sandbox/core/constants/common.dart';
import 'package:todo_sandbox/data/datasource/local/db/app_db.dart';
import 'package:todo_sandbox/data/models/note_details_model.dart';
import 'package:todo_sandbox/data/repositories/note_repository_impl.dart';
import 'package:todo_sandbox/domain/provider/note_local_data_provider.dart';
import 'package:todo_sandbox/domain/repositories/note_repository.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/create_note_use_case.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/delete_note_use_case.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/get_all_notes_use_case.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/update_note_use_case.dart';
import 'package:todo_sandbox/presentation/block/home_block.dart';
import 'package:todo_sandbox/presentation/screens/note/note_details_screen.dart';

final GetIt locator = GetIt.instance;

// repositories
Future<void> setupDi() async {
  //Register db instance
  final AppDatabase database = await $FloorAppDatabase.databaseBuilder(applicationDatabaseName).build();
  locator.registerSingleton<AppDatabase>(database);

  final NoteLocalDataProvider localDataProvider = NoteLocalDataProvider(locator());
  locator.registerSingleton<NoteLocalDataProvider>(localDataProvider);

  //Register remote api service
  final NoteRemoteDataProvider remoteDataProvider = NoteRemoteDataProvider();
  locator.registerSingleton<NoteRemoteDataProvider>(remoteDataProvider);

  //Register repository
  locator.registerSingleton<NoteRepository>(
    NoteRepositoryImpl(locator(), locator()),
  );

  //Register usecases
  locator.registerSingleton<GetAllNotesUseCase>(GetAllNotesUseCase(locator()));
  locator.registerSingleton<UpdateNoteUseCase>(UpdateNoteUseCase(locator()));
  locator.registerSingleton<DeleteNoteUseCase>(DeleteNoteUseCase(locator()));
  locator.registerSingleton<CreateNoteUseCase>(CreateNoteUseCase(locator()));

  //Register BloCs
  locator.registerFactory<HomeBlock>(() => HomeBlock(locator()));
  locator.registerFactory<NoteDetailsBloc>(()=>NoteDetailsBloc(locator()));
}
