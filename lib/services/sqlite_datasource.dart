import '../models/todo.dart';
import 'datasource.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDatasource implements IDataSource {
  late Database _database;

  Future initalise() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), "todo_database.db"),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE if NOT EXISTS todos (id INTEGER PRIMARY KEY, name TEXT, description TEXT, complete INTEGER)",
        );
      },
    );
  }

  static Future<IDataSource> createAsync() async {
    // await deleteDatabase(join(await getDatabasesPath(), 'todo_database.db'));
    SqliteDatasource datasource = SqliteDatasource();
    await datasource.initalise();
    return datasource;
  }

  @override
  Future<bool> add(Todo model) async {
    Map<String, dynamic> editedMap = model.toMap();
    editedMap.remove('id');

    int rowid = await _database.insert('todos', editedMap);
    if (rowid == 0) {
      // indicates an issue
      return false;
    } else {
      // else the int is the last entered row
      return true;
    }
  }

  @override
  Future<List<Todo>> browse() async {
    List<Map<String, dynamic>> maps = await _database.query('todos');

    return List.generate(maps.length, (index) {
      return Todo.fromMap(maps[index]);
    });
  }

  @override
  Future<bool> delete(Todo model) async {
    int rowsaffected = await _database.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [model.id],
    );
    if (rowsaffected == 1) {
      return true;
    } else {
      // either couldn't find id or deleted more than one row (unintended)
      return false;
    }
  }

  @override
  Future<bool> edit(Todo model) async {
    Map<String, dynamic> editedMap = model.toMap();
    editedMap.remove('id');

    int rowsaffected = await _database.update(
      'todos',
      editedMap,
      where: 'id = ?',
      whereArgs: [model.id],
    );
    if (rowsaffected == 1) {
      return true;
    } else {
      // either couldn't find id or deleted more than one row (unintended)
      return false;
    }
  }

  @override
  Future<Todo?> read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }
}
