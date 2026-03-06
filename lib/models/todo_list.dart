import 'dart:collection';

import 'package:flutter/material.dart';
import './todo.dart';

class TodoList extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo(name: "Shopping", description: "Pick up groceries"),
    Todo(name: "Paint", description: "Recreate the Mona Lisa", complete: true),
    Todo(name: "Dance", description: "I wanna dance with somebody"),
  ];

  //getters

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);
  int get todoCount => _todos.length;

  //functions

  void add(Todo todo) {
    //might need to return this?
    _todos.add(todo);
    notifyListeners();
  }

  void updateTodo(Todo todo) {
    Todo listTodo = _todos.firstWhere((t) => t.name == todo.name);

    int todoindex = _todos.indexOf(listTodo);

    _todos[todoindex] = todo;
    // _todos.replaceRange(todoindex, todoindex, [todo]);
    notifyListeners();
  }

  void removeOne(Todo todo) {
    //_todos.removeWhere((item) => item == todo)

    _todos.remove(todo);
    notifyListeners();
  }

  void removeAll() {
    // while (_todos.isNotEmpty){
    //   _todos.removeLast();
    // }

    _todos.clear();
    notifyListeners();
  }
}
