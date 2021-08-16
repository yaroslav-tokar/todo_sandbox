import 'package:get_it/get_it.dart';
import 'package:todo_sandbox/data/datasource/local/db/app_db.dart';
import 'package:todo_sandbox/data/repositories/note_repository_impl.dart';
import 'package:todo_sandbox/domain/provider/note_local_data_provider.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/create_note_use_case.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/delete_note_use_case.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/get_all_notes_use_case.dart';
import 'package:todo_sandbox/domain/use_case/note_use_case/update_note_use_case.dart';
import 'package:todo_sandbox/presentation/block/home_block.dart';

final GetIt locator = GetIt.instance;

//TODO fix di issue: currently ioc container does not create dependencies for
// repositories
Future<void> setupDi() async {
  await _initDb();
  await _initDataProviders();
  await _initRepositories();
  await _initBlocks();
  await _initUseCases();
}

Future<void> _initBlocks() async {
  locator.registerFactory<HomeBlock>(() => HomeBlock(locator()));
}

Future<void> _initUseCases() async {
  locator.registerSingleton<GetAllNotesUseCase>(GetAllNotesUseCase(locator()));
  locator.registerSingleton<UpdateNoteUseCase>(UpdateNoteUseCase(locator()));
  locator.registerSingleton<DeleteNoteUseCase>(DeleteNoteUseCase(locator()));
  locator.registerSingleton<CreateNoteUseCase>(CreateNoteUseCase(locator()));
}

Future<void> _initDataProviders() async {
  locator.registerSingleton<NoteLocalDataProvider>(
      NoteLocalDataProvider(locator()));
}

Future<void> _initRepositories() async {
  locator.registerSingleton<NoteRepositoryImpl>(
      NoteRepositoryImpl(locator(), locator()));
}

Future<void> _initDb() async {
  final appDb = await $FloorAppDatabase.databaseBuilder('app_db').build();
  locator.registerSingleton<AppDatabase>(appDb);
}
