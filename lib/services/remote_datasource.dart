import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import './datasource.dart';
import './../firebase_options.dart';
import './../models/todo.dart';

class RemoteDatasource implements IDataSource {
  late FirebaseDatabase database;

  Future initalise() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    database = FirebaseDatabase.instance;
  }

  static Future<IDataSource> createAsync() async {
    RemoteDatasource datasource = RemoteDatasource();
    await datasource.initalise();
    return datasource;
  }

  @override
  Future<bool> add(Todo model) async {
    DatabaseReference ref = database.ref('todos').push();

    await ref.set({
      'id': ref.key,
      'name': model.name,
      'description': model.description,
      'complete': model.complete,
    });

    return true;
  }

  @override
  Future<List<Todo>> browse() async {
    //attempt to get todos
    final DataSnapshot snapshot = await database.ref('todos').get();
    if (!snapshot.exists) {
      //if snapshot doesn't exist
      throw Exception("Error: could not find snapshot: ${snapshot.ref.path}");
    }

    List<Todo> todos = <Todo>[];
    (snapshot.value as Map).values
        .map((list) => Map<String, dynamic>.from(list))
        .forEach((item) {
          todos.add(Todo.fromMap(item));
        });
    return todos;
  }

  @override
  Future<bool> delete(Todo model) async {
    await database.ref('todos/${model.id}').remove();
    return true;
  }

  @override
  Future<bool> edit(Todo model) async {
    DatabaseReference ref = database.ref('todos/${model.id}');

    await ref.update({
      'id': ref.key,
      'name': model.name,
      'description': model.description,
      'complete': model.complete,
    });

    return true;
  }

  @override
  Future<Todo?> read(String id) async {
    //attempt to get todos
    final DataSnapshot snapshot = await database.ref('todos/$id').get();
    if (!snapshot.exists) {
      //if snapshot doesn't exist
      throw Exception("Error: could not find snapshot: ${snapshot.ref.path}");
    }

    Todo todo = Todo.fromMap(snapshot.value as Map<String, dynamic>);

    return todo;
  }
}
