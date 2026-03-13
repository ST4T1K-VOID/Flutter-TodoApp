import 'package:flutter/material.dart';
import 'package:flutter_todo/services/sqlite_datasource.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import './models/todo_list.dart';
import './models/todo.dart';
import './services/datasource.dart';
import './views/todo_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.putAsync<IDataSource>(() => SqliteDatasource.createAsync()).whenComplete(
    () => runApp(
      ChangeNotifierProvider(
        create: (context) => TodoList(),
        child: const TodoApp(),
      ),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo App",
      home: TodoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final TextEditingController _controlName = TextEditingController();
  final TextEditingController _controlDescription = TextEditingController();

  //add todo pop-up form
  _openAddTodo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Title"),
              TextFormField(controller: _controlName),
              Text("Description"),
              TextFormField(controller: _controlDescription),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      //???????
                      TodoList().add(
                        Todo(
                          name: _controlName.text,
                          description: _controlDescription.text,
                        ),
                      );
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTodo,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("TODOist"),
            Consumer<TodoList>(
              builder: (context, model, child) => (Text(
                "Remaining todos: ${model.todos.where((todo) => todo.complete == false).length}",
              )),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey[400],
      ),
      body: Center(
        child: Consumer<TodoList>(
          builder: (context, model, child) {
            return FutureBuilder(
              future: model.refresh(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data != null) {
                  return ListView.builder(
                    itemCount: model.todoCount,
                    itemBuilder: (BuildContext context, int i) {
                      return TodoWidget(todo: model.todos[i]);
                    },
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Icon(Icons.error));
                }
                return Center(
                  child: CircularProgressIndicator(color: Colors.amber),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
