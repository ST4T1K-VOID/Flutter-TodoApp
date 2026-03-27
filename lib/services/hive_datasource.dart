import 'package:flutter_todo/models/todo.dart';
import 'package:hive_flutter/adapters.dart';

import 'datasource.dart';

class HiveDatasource implements IDataSource {
  Future initalise() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoAdaptor());
    await Hive.openBox<Todo>('todos');
  }

  static Future<IDataSource> createAsync() async {
    // same as done in SQLDatasource but a different type!
    HiveDatasource datasource = HiveDatasource();
    await datasource.initalise();
    return datasource;
  }

  @override
  Future<bool> add(Todo model) async {
    Box<Todo> box = Hive.box('todos');
    try {
      int id = await box.add(model);
      await edit(model.copyWith(id: id.toString()));
    } catch (error) {
      // print(error);
      return false;
    }
    return true;
  }

  @override
  Future<List<Todo>> browse() async {
    Box<Todo> box = Hive.box('todos');
    return box.values.toList();
  }

  @override
  Future<bool> delete(Todo model) async {
    Box<Todo> box = Hive.box('todos');
    try {
      box.delete(int.parse(model.id));
    } catch (error) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> edit(Todo model) async {
    Box<Todo> box = Hive.box('todos');
    try {
      box.put(int.parse(model.id), model);
    } catch (error) {
      return false;
    }
    return true;
  }

  @override
  Future<Todo?> read(String id) async {
    Box<Todo> box = Hive.box('todos');
    return box.get(int.parse(id));
  }
}
