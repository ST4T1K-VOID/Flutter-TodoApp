import 'dart:collection';

import 'package:flutter/material.dart';
import './Todo.dart';

class TodoList extends ChangeNotifier {
  final List<Todo> _todos = [];

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
    int todoindex = _todos.indexOf(todo);
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
