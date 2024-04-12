
import 'dart:convert';

DeleteToDoResponse deleteToDoResponseFromJson(String str) => DeleteToDoResponse.fromJson(json.decode(str));

String deleteToDoResponseToJson(DeleteToDoResponse data) => json.encode(data.toJson());

class DeleteToDoResponse {
  int? id;
  String? todo;
  bool? completed;
  int? userId;
  bool? isDeleted;
  String? deletedOn;

  DeleteToDoResponse({
    this.id,
    this.todo,
    this.completed,
    this.userId,
    this.isDeleted,
    this.deletedOn,
  });

  factory DeleteToDoResponse.fromJson(Map<String, dynamic> json) => DeleteToDoResponse(
    id: json["id"],
    todo: json["todo"],
    completed: json["completed"],
    userId: json["userId"],
    isDeleted: json["isDeleted"],
    deletedOn: json["deletedOn"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "todo": todo,
    "completed": completed,
    "userId": userId,
    "isDeleted": isDeleted,
    "deletedOn": deletedOn,
  };
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (other is DeleteToDoResponse) {
      return other.id== id;
    }

    return false;
  }

}
