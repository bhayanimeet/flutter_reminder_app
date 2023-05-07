import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/sqlite_db_model.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();

  Database? db;

  static const tableName = "Task";
  static const id = "id";
  static const title = "title";
  static const task = "task";
  static const date = "date";
  static const startTime = "startTime";
  static const endTime = "endTime";
  static const reminder = "reminder";
  static const isSelected = "isSelected";

  Future<void> dataTable() async {
    String directory = await getDatabasesPath();
    String path = join(directory, "demo.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        String query = "CREATE TABLE IF NOT EXISTS $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT,$title TEXT,$task TEXT,$date TEXT,$startTime TEXT,$endTime TEXT,$reminder TEXT,$isSelected INTEGER)";
        await db.execute(query);
      },
    );
  }

  Future<int> insertData({required Task data}) async {
    await dataTable();

    String query = "INSERT INTO $tableName($title,$task,$date,$startTime,$endTime,$reminder,$isSelected) VALUES(?,?,?,?,?,?,?)";
    List args = [data.title,data.task,data.date,data.startTime,data.endTime,data.reminder,data.isSelected];

    int res = await db!.rawInsert(query, args);

    return res;
  }

  Future<int> update({required Task data,required int index}) async {
    await dataTable();

    String query = "UPDATE $tableName SET $title =?,$task =?,$date =?,$startTime=?,$endTime=?,$reminder=?,$isSelected =? WHERE $id=?;";

    List args = [data.title,data.task,data.date,data.startTime,data.endTime,data.reminder,data.isSelected,index];

    int res = await db!.rawUpdate(query,args);

    return res;
  }

  Future<List<Task>> selectData() async {
    await dataTable();

    String query = "SELECT * FROM $tableName;";

    List<Map<String, dynamic>> allTasks = await db!.rawQuery(query);

    List<Task> allTask = allTasks.map((e) => Task.fromMap(data: e)).toList();

    return allTask;
  }

  Future<int> deleteData({required int index}) async {
    await dataTable();

    String query = "DELETE FROM $tableName WHERE $id=?;";

    int res = await db!.rawDelete(query, [index]);

    return res;
  }
}