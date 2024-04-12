import 'dart:convert';

UpdateToDoResponse  addToDoResponseFromJson(String str) =>
    UpdateToDoResponse.fromJson(json.decode(str));

String addToDoResponseToJson(UpdateToDoResponse data) =>
    json.encode(data.toJson());

class UpdateToDoResponse {
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  UpdateToDoResponse({
    this.id,
    this.todo,
    this.completed,
    this.userId,
  });

  factory UpdateToDoResponse.fromJson(Map<String, dynamic> json) =>
      UpdateToDoResponse(
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (other is UpdateToDoResponse) {
      return other.id== id;
    }

    return false;
  }
}
