import 'package:sqflite/sqflite.dart';
import 'package:todo/models/taks.dart';

class databaseHelper {
  static Database? _database;
  static final int _version = 1;
  static final String _tableName = 'todoTasksTable';
  static final String _dbName = "todoApp.db";

  static Future<void> initDB() async {
    // if (_database != null) {
    //   return;
    // }
    try {
      String _path = await getDatabasesPath() + _dbName;
      _database =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print("Creating a new database");
        return db.execute(
            "CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, description TEXT, isDone INTEGER, date STRING, time STRING, reminder INTEGER, color INTEGER)");
      });
    } catch (e) {
      print(e);
    }
  }

  //Type int to prevent error
  static Future<int> insert(Task? task) async {
    print("Inserting a new task");
    return await _database?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> querry() async {
    print("Qerry Function called");
    return await _database!.query(_tableName);
  }

  static delete(Task task) async {
    print("Delete Function called");
    return await _database!
        .delete(_tableName, where: "id = ?", whereArgs: [task.id]);
  }

  static search(String search_keywords) async {
    print("Search Function called");
    return await _database!.rawQuery(
        "SELECT * FROM $_tableName WHERE title LIKE '%$search_keywords%' UNION SELECT * FROM $_tableName WHERE description LIKE '%$search_keywords%' UNION SELECT * FROM $_tableName WHERE date LIKE '%$search_keywords%' UNION SELECT * FROM $_tableName WHERE time LIKE '%$search_keywords%'");
  }
}
