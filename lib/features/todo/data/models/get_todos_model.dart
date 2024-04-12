import 'dart:convert';

Todos todosFromJson(String str) => Todos.fromJson(json.decode(str));

String todosToJson(Todos data) => json.encode(data.toJson());

class Todos {
  List<Todo>? todos;
  int? total;
  int? skip;
  int? limit;

  Todos({
    this.todos,
    this.total,
    this.skip,
    this.limit,
  });

  factory Todos.fromJson(Map<String, dynamic> json) => Todos(
        todos: json["todos"] == null
            ? []
            : List<Todo>.from(json["todos"]!.map((x) => Todo.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "todos": todos == null
            ? []
            : List<dynamic>.from(todos!.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (other is Todos) {
      return other.todos?.length== todos?.length;
    }

    return false;
  }
}

class Todo {
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  Todo({
    this.id,
    this.todo,
    this.completed,
    this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        todo: json["todo"],
        completed: json["completed"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "todo": todo,
        "completed": completed,
        "userId": userId,
      };

  Todo copyWith({
    int? id,
    int? userId,
    String? description,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      userId: userId?? this.userId,
      todo: description ?? this.todo,
      completed: isCompleted ?? this.completed,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          todo == other.todo &&
          completed == other.completed &&
          userId == other.userId;

  @override
  int get hashCode =>
      id.hashCode ^ todo.hashCode ^ completed.hashCode ^ userId.hashCode;
}
