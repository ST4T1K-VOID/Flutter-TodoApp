class Todo {
  final String name;
  final String description;
  final bool complete;

  Todo({required this.name, required this.description, this.complete = false});

  @override
  String toString() {
    // cocncatenates `name` and `description` properties together
    return "+ $name - ($description)";
  }
}
