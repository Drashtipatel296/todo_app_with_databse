import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/database_model.dart';

class DBHelper {
  static Database? _db;
  static const String bdName = 'tasks.db';
  static const String tableName = 'tasks';

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), bdName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            taskName TEXT NOT NULL,
            isDone INTEGER NOT NULL,
            note TEXT,
            priority INTEGER NOT NULL,
            likes INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insert(Todo task) async {
    var dbClient = await db;
    return await dbClient.insert(tableName, task.toMap());
  }

  Future<int> update(Todo task) async {
    var dbClient = await db;
    return await dbClient.update(tableName, task.toMap(),
        where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableName,
        where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Todo>> fetch() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query(tableName);
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }
}