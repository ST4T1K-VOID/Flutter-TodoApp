class Todo {
  final String name;
  final String description;
  final bool complete;

  Todo({required this.name, required this.description, this.complete = false});

  @override
  String toString() {
    // cocncatenates `name` and `description` properties together
    return "$name - ($description)";
  }

  Todo copyWith({String? name, String? description, bool? complete}) {
    return Todo(
      name: name ?? this.name,
      description: description ?? this.description,
      complete: complete ?? this.complete,
    );
  }
}
