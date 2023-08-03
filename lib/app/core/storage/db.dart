import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DbProvider {
  DbProvider({
    required this.dbPass,
    this.dbPath,
  });

  final String? dbPath;
  final String dbPass;

  Future<Database> get database async =>
      await getDataBase(dbPass: dbPass, dbPath: dbPath);

  Future<Database> getDataBase({required String dbPass, String? dbPath}) async {
    String _dbPath = dbPath ?? join(await getDatabasesPath(), 'penhas.db');

    return openDatabase(
      _dbPath,
      password: dbPass,
      version: _migrationsUp.length,
      onCreate: (db, version) => _migrateUp(db, 0, version),
      onUpgrade: _migrateUp,
      onDowngrade: _migrateDown,
    );
  }

  Future<void> _migrateUp(Database db, int oldVersion, int newVersion) async {
    final migrations = _migrationsUp.sublist(oldVersion, newVersion);

    await _migrate(db, migrations);
  }

  Future<void> _migrateDown(Database db, int oldVersion, int newVersion) async {
    final migrations = _migrationsDown.sublist(newVersion, oldVersion).reversed;

    await _migrate(db, migrations);
  }

  Future<void> _migrate(Database db, Iterable<String> migrations) async {
    final batch = db.batch();

    migrations
        .expand((e) => e.split(';'))
        .map((e) => e.trim())
        .where((sql) => sql.isNotEmpty)
        .forEach((sql) => batch.execute(sql));

    await batch.commit(noResult: true);
  }

  List<String> get _migrationsUp => [
        '''
      CREATE TABLE escape_manual_tasks(
        'id' INTEGER PRIMARY KEY,
        'title' TEXT NOT NULL,
        'description' TEXT NOT NULL,
        'group' TEXT NOT NULL,
        'type' TEXT NOT NULL,
        'user_input_value' TEXT,
        'is_editable' INTEGER NOT NULL,
        'is_done' INTEGER DEFAULT 0 NOT NULL,
        'is_removed' INTEGER DEFAULT 0 NOT NULL,
        'updated_at' TIMESTAMP
      )
      ''',
      ];

  List<String> get _migrationsDown => [
        '''
      DROP TABLE IF EXISTS escape_manual_tasks
      ''',
      ];
}
