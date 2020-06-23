
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:prototype2/task.dart';

class DatabaseProvider {
  static const String TABLE_TASK = "task";
  static const String COLUMN_ID = "id";
  static const String TASK_NAME = "task_name";
  static const String DATE = "date";


  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'taskDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating food table");

        await database.execute(
          "CREATE TABLE $TABLE_TASK ("
          "$COLUMN_ID INTEGER PRIMARY KEY,"
          "$TASK_NAME TEXT,"
          "$DATE TEXT"
          ")",
        );
      },
    );
  }

  Future<List<Task>> getTask() async {
    final db = await database;
    
    var tasks = await db
        .query(TABLE_TASK, columns: [COLUMN_ID, TASK_NAME, DATE]);

    List<Task> taskList = List<Task>();

    tasks.forEach((currentTask) {
      Task task = Task.fromMap(currentTask);

      taskList.add(task);
    });
   
    return taskList;
  }

  Future<Task> insert(Task task) async {

    final db = await database;
    task.id = await db.insert(TABLE_TASK, task.toMap());
        print('Data Inserted');
    return task;
  }

  Future<int> delete(int id) async {
    final db = await database;
     print('deletion in database');
    return await db.delete(
      TABLE_TASK,
      where: "id = ?",
      whereArgs: [id],
    );
  }

 
}
