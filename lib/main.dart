import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo.dart';

void main() {
  runApp(TodoApp());
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
  final List<Todo> todos = <Todo>[
    Todo(name: "Shopping", description: "Pick up groceries"),
    Todo(name: "Paint", description: "Recreate the Mona Lisa"),
    Todo(name: "Dance", description: "I wanna dance with somebody"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TODO APPBAR')),
      body: Center(
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int i) {
            return Container(
              padding: const EdgeInsets.all(5),
              child: Text(todos[i].toString()),
            );
          },
        ),
      ),
    );
  }
}
