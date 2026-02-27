import 'package:flutter/material.dart';
import './models/todo.dart';

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
  final TextEditingController _controlName = TextEditingController();
  final TextEditingController _controlDescription = TextEditingController();

  //todo data
  final List<Todo> todos = <Todo>[
    Todo(name: "Shopping", description: "Pick up groceries"),
    Todo(name: "Paint", description: "Recreate the Mona Lisa"),
    Todo(name: "Dance", description: "I wanna dance with somebody"),
  ];

  //add todo pop-up form
  _openAddTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                      todos.add(
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
        backgroundColor: Colors.blueGrey[100],
      ),
      appBar: AppBar(
        title: Text('TODO APPBAR'),
        backgroundColor: Colors.blueGrey[400],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int i) {
            return Container(
              margin: EdgeInsets.all(5),
              padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
              decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3),
                    blurRadius: 2.0,
                    blurStyle: BlurStyle.solid,
                    color: const Color.fromARGB(128, 63, 84, 95),
                  ),
                ],
              ),
              child: Text(style: TextStyle(fontSize: 24), todos[i].toString()),
            );
          },
        ),
      ),
    );
  }
}
