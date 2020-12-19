import 'package:sqflite/sqflite.dart';
import 'package:ass2/Task.dart';

class DBManger {
  Database database;
  static final String databaseName = 'taskDb.db';
  static final String tableName = 'tasks';
  static final String taskIdColumnName = 'id';
  static final String taskNameColumnName = 'name';
  static final String taskIsCompleteColumnName = 'iscomplete';

  Future<Database> initDataBase() async {
    if (database == null) {
      return await createDataBase();
    } else {
      return database;
    }
  }

  createDataBase() async {
    try {
      String databasePath = await getDatabasesPath();
      String path = databasePath + databaseName;
      Database database = await openDatabase(path, version: 1,
          onCreate: (db, version) async {
            await db.execute(
                'CREATE TABLE $tableName ($taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT , $taskNameColumnName TEXT NOT NULL, $taskIsCompleteColumnName INTEGER)');
          });
      return database;
    } on Exception catch (e) {
      print(e);
    }
  }

  insertNewTask(Task task) async {
    try {
      database = await initDataBase();
      await database.insert(tableName, task.toJson());
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Map>> selectAllTasks() async {
    database = await initDataBase();
    List<Map> result = await database.query(tableName);
    return result;
  }

  Future<List<Map>> selectTaskType(int isComplete) async {
    try {
      database = await initDataBase();
      List<Map> result = await database.query(tableName,
          where: '$taskIsCompleteColumnName=?', whereArgs: [isComplete]);
      return result;
    } on Exception catch (e) {
      print(e);
    }
  }

  updateTask(Task task) async {
    try {
      database = await initDataBase();
      await database.update(tableName, task.toJson(),
          where: '$taskIdColumnName=?', whereArgs: [task.id]);
    } on Exception catch (e) {
      print(e);
    }
  }

  deleteTask(int id) async {
    try {
      database = await initDataBase();
      await database.delete(
          tableName, where: '$taskIdColumnName=?', whereArgs: [id]);
    } on Exception catch (e) {
      print(e);
    }
  }
}