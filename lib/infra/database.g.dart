// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

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

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

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
        ? join(await sqflite.getDatabasesPath(), name)
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
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao _noteDaoInstance;

  CardDao _cardDaoInstance;

  TemplateDao _templateDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
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
            'CREATE TABLE IF NOT EXISTS `Note` (`id` INTEGER, `date` TEXT, `text` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `card` (`id` INTEGER, `date` TEXT, `template_id` INTEGER, `text` TEXT, FOREIGN KEY (`template_id`) REFERENCES `Template` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Template` (`id` INTEGER, `titulo` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }

  @override
  CardDao get cardDao {
    return _cardDaoInstance ??= _$CardDao(database, changeListener);
  }

  @override
  TemplateDao get templateDao {
    return _templateDaoInstance ??= _$TemplateDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _noteInsertionAdapter = InsertionAdapter(
            database,
            'Note',
            (Note item) => <String, dynamic>{
                  'id': item.id,
                  'date': item.date,
                  'text': item.text
                }),
        _noteUpdateAdapter = UpdateAdapter(
            database,
            'Note',
            ['id'],
            (Note item) => <String, dynamic>{
                  'id': item.id,
                  'date': item.date,
                  'text': item.text
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _noteMapper = (Map<String, dynamic> row) =>
      Note(row['id'] as int, row['date'] as String, row['text'] as String);

  final InsertionAdapter<Note> _noteInsertionAdapter;

  final UpdateAdapter<Note> _noteUpdateAdapter;

  @override
  Future<Note> findNoteByDate(String date) async {
    return _queryAdapter.query('SELECT * FROM Note WHERE date = ?',
        arguments: <dynamic>[date], mapper: _noteMapper);
  }

  @override
  Future<List<Note>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Note', mapper: _noteMapper);
  }

  @override
  Future<int> insertNote(Note note) {
    return _noteInsertionAdapter.insertAndReturnId(
        note, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateNote(Note note) {
    return _noteUpdateAdapter.updateAndReturnChangedRows(
        note, sqflite.ConflictAlgorithm.abort);
  }
}

class _$CardDao extends CardDao {
  _$CardDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _cardInsertionAdapter = InsertionAdapter(
            database,
            'card',
            (Card item) => <String, dynamic>{
                  'id': item.id,
                  'date': item.date,
                  'template_id': item.template_id,
                  'text': item.text
                }),
        _cardUpdateAdapter = UpdateAdapter(
            database,
            'card',
            ['id'],
            (Card item) => <String, dynamic>{
                  'id': item.id,
                  'date': item.date,
                  'template_id': item.template_id,
                  'text': item.text
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _cardMapper = (Map<String, dynamic> row) => Card(
      row['id'] as int,
      row['date'] as String,
      row['template_id'] as int,
      row['text'] as String);

  final InsertionAdapter<Card> _cardInsertionAdapter;

  final UpdateAdapter<Card> _cardUpdateAdapter;

  @override
  Future<Card> findCardByDateAndTemplateId(String date, int templateId) async {
    return _queryAdapter.query(
        'SELECT * FROM Card WHERE date = ? AND template_id = ?',
        arguments: <dynamic>[date, templateId],
        mapper: _cardMapper);
  }

  @override
  Future<List<Card>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Card', mapper: _cardMapper);
  }

  @override
  Future<int> insertCard(Card card) {
    return _cardInsertionAdapter.insertAndReturnId(
        card, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateCard(Card card) {
    return _cardUpdateAdapter.updateAndReturnChangedRows(
        card, sqflite.ConflictAlgorithm.abort);
  }
}

class _$TemplateDao extends TemplateDao {
  _$TemplateDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _templateInsertionAdapter = InsertionAdapter(
            database,
            'Template',
            (Template item) =>
                <String, dynamic>{'id': item.id, 'titulo': item.titulo}),
        _templateUpdateAdapter = UpdateAdapter(
            database,
            'Template',
            ['id'],
            (Template item) =>
                <String, dynamic>{'id': item.id, 'titulo': item.titulo});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _templateMapper = (Map<String, dynamic> row) =>
      Template(row['id'] as int, row['titulo'] as String);

  final InsertionAdapter<Template> _templateInsertionAdapter;

  final UpdateAdapter<Template> _templateUpdateAdapter;

  @override
  Future<List<Template>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Template',
        mapper: _templateMapper);
  }

  @override
  Future<int> insertTemplate(Template template) {
    return _templateInsertionAdapter.insertAndReturnId(
        template, sqflite.ConflictAlgorithm.abort);
  }

  @override
  Future<int> updateTemplate(Template template) {
    return _templateUpdateAdapter.updateAndReturnChangedRows(
        template, sqflite.ConflictAlgorithm.abort);
  }
}
