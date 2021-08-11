import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:todo_sandbox/data/provider/note_local_data_provider.dart';
import 'package:todo_sandbox/data/provider/repository/note_repository_impl.dart';
import 'package:todo_sandbox/data/provider/use_case/note_use_case_impl.dart';
import 'package:todo_sandbox/stateful_model/home_stateful_model.dart';
import 'package:todo_sandbox/stateful_model/note_stateful_model.dart';
import 'package:todo_sandbox/core/model/dbo/note_dbo.dart';
import 'package:todo_sandbox/view_model.dart';

final GetIt locator = GetIt.instance;

Future<void> setupDi() async {
  await _initCore();
  await _initRepositories();
  await _initUseCases();
  await _initModel();
  await _initStatefulModels();
}

Future<void> _initModel() async {
  locator.registerFactory<HomeModel>(() => HomeModel());
}

Future<void> _initStatefulModels() async {
  locator.registerFactory<HomeStatefulModel>(() => HomeStatefulModel());
  locator.registerFactory<NoteStatefulModel>(
      () => NoteStatefulModel(locator<NoteRepositoryImpl>()));
}

Future<void> _initUseCases() async {
  locator.registerLazySingleton<NoteUseCaseImpl>(
      () => NoteUseCaseImpl(locator<NoteRepositoryImpl>()));
}

Future<void> _initCore() async {
  final noteBox = await Hive.openBox<NoteDbo>(HiveBoxName.note);
  locator.registerLazySingleton<NoteLocalDataProvider>(
      () => NoteLocalDataProvider(noteBox));
}

Future<void> _initRepositories() async {
  locator.registerLazySingleton<NoteRepositoryImpl>(
      () => NoteRepositoryImpl(locator<NoteLocalDataProvider>()));
}
