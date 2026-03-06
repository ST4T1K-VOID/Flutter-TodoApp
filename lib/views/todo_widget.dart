import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo_list.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';

class TodoWidget extends StatefulWidget {
  final Todo todo;
  const TodoWidget({super.key, required this.todo});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.todo.name, style: TextStyle(fontSize: 30)),
                Checkbox(
                  value: widget.todo.complete,
                  onChanged: (value) {
                    Provider.of<TodoList>(
                      context,
                      listen: false,
                    ).updateTodo(widget.todo.copyWith(complete: value));
                  },
                ),
              ],
            ),
            Text(style: TextStyle(fontSize: 20), widget.todo.description),
          ],
        ),
      ),
    );
  }
}

// Container(
//       margin: EdgeInsets.all(5),
//       padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, 5),
//             blurRadius: 2.0,
//             blurStyle: BlurStyle.solid,
//             color: const Color.fromARGB(128, 94, 94, 94),
//           ),
//         ],
//       ),
//       child: Text(style: TextStyle(fontSize: 24), widget.todo.toString()),
//     );
