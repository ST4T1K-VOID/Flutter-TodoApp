class Todo {
  final String id;
  final String name;
  final String description;
  final bool complete;

  Todo({
    required this.name,
    required this.description,
    this.complete = false,
    this.id = '0',
  });

  @override
  String toString() {
    // cocncatenates `name` and `description` properties together
    return "$name - ($description)";
  }

  Todo copyWith({
    String? id,
    String? name,
    String? description,
    bool? complete,
  }) {
    return Todo(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      complete: complete ?? this.complete,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'complete': complete,
      // 'complete': complete == true ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    bool? complete = map['complete'] is bool ? map['complete'] : null;

    complete ??= map['complete'] == 1;

    return Todo(
      id: map['id'].toString(),
      name: map['name'],
      description: map['description'],
      complete: complete,
    );
  }
}
