import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
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

class TodoAdaptor extends TypeAdapter<Todo> {
  @override
  Todo read(BinaryReader reader) {
    return Todo(
      //reader reads in the order of the write func?
      id: reader.read(),
      name: reader.read(),
      description: reader.read(),
      complete: reader.read(),
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.description);
    writer.write(obj.complete);
  }
}
