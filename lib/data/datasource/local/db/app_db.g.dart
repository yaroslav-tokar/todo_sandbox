// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao? _noteDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `notes` (`category` TEXT NOT NULL, `id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `content` TEXT NOT NULL, `created_at` INTEGER NOT NULL, `updated_at` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _noteDboInsertionAdapter = InsertionAdapter(
            database,
            'notes',
            (NoteDbo item) => <String, Object?>{
                  'category': item.category,
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'created_at': item.createAt,
                  'updated_at': item.updateAt
                }),
        _noteDboUpdateAdapter = UpdateAdapter(
            database,
            'notes',
            ['id'],
            (NoteDbo item) => <String, Object?>{
                  'category': item.category,
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'created_at': item.createAt,
                  'updated_at': item.updateAt
                }),
        _noteDboDeletionAdapter = DeletionAdapter(
            database,
            'notes',
            ['id'],
            (NoteDbo item) => <String, Object?>{
                  'category': item.category,
                  'id': item.id,
                  'title': item.title,
                  'content': item.content,
                  'created_at': item.createAt,
                  'updated_at': item.updateAt
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NoteDbo> _noteDboInsertionAdapter;

  final UpdateAdapter<NoteDbo> _noteDboUpdateAdapter;

  final DeletionAdapter<NoteDbo> _noteDboDeletionAdapter;

  @override
  Future<List<NoteDbo>> findAllNotes() async {
    return _queryAdapter.queryList('SELECT * FROM notes',
        mapper: (Map<String, Object?> row) => NoteDbo(
            category: row['category'] as String,
            id: row['id'] as int?,
            title: row['title'] as String,
            content: row['content'] as String,
            createAt: row['created_at'] as int,
            updateAt: row['updated_at'] as int));
  }

  @override
  Future<NoteDbo?> findNoteById(int noteId) async {
    return _queryAdapter.query('SELECT * FROM notes WHERE id = ?1',
        mapper: (Map<String, Object?> row) => NoteDbo(
            category: row['category'] as String,
            id: row['id'] as int?,
            title: row['title'] as String,
            content: row['content'] as String,
            createAt: row['created_at'] as int,
            updateAt: row['updated_at'] as int),
        arguments: [noteId]);
  }

  @override
  Future<int?> deleteNoteById(int noteId) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM notes WHERE id = ?1', arguments: [noteId]);
  }

  @override
  Future<int> insertItem(NoteDbo item) {
    return _noteDboInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateItem(NoteDbo item) {
    return _noteDboUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.replace);
  }

  @override
  Future<int> deleteItem(NoteDbo item) {
    return _noteDboDeletionAdapter.deleteAndReturnChangedRows(item);
  }
}
