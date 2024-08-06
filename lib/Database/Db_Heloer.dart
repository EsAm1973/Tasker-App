import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_2_week13/models/Task.dart';

class Db_Helper {
  static final Db_Helper _instance = Db_Helper.internal();
  factory Db_Helper() => _instance;
  Db_Helper.internal();

  static Database? _db;
  Future<Database> createDatabase() async {
    if (_db != null) {
      print('Database already exists');
      return _db!;
    }
    String path = join(await getDatabasesPath(), 'ToDoOne.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        print('Creating Database and Tables');
        return db.execute(
            'CREATE TABLE Tasks1(id INTEGER PRIMARY KEY AUTOINCREMENT, done INTEGER, name TEXT, numberDays TEXT)');
      },
    );
    print('Database Created Successfully');
    return _db!;
  }

  Future<int> insertTask(Task task) async {
    Database db = await createDatabase();
    print('Inserting Task: $task');
    int result = await db.insert('Tasks1', task.toMap());
    print('Task inserted with id: $result');
    return result;
  }

  Future<List<Map<String, dynamic>>> getTasks() async {
    Database db = await createDatabase();
    print('Fetching Tasks from the database.');
    List<Map<String, dynamic>> tasks = await db.query('Tasks1');
    print('Fetched ${tasks.length} tasks from the database.');
    return tasks;
  }

  Future<int> updateTaskDone(int id, int done) async {
    Database db = await createDatabase();
    print('Updating Task done with id: $id to $done');
    int result = await db.update(
      'Tasks1',
      {'done': done},
      where: 'id = ?',
      whereArgs: [id],
    );
    print('Task done updated successfully. Updated $result record(s).');
    return result;
  }
}
