// To parse this JSON data, do
//
//     final addToDo = addToDoFromJson(jsonString);

import 'dart:convert';

AddToDoRequest addToDoFromJson(String str) => AddToDoRequest.fromJson(json.decode(str));

String addToDoToJson(AddToDoRequest data) => json.encode(data.toJson());

class AddToDoRequest {
  String? todo;
  bool? completed;
  int? userId;

  AddToDoRequest({
    this.todo,
    this.completed,
    this.userId,
  });

  factory AddToDoRequest.fromJson(Map<String, dynamic> json) => AddToDoRequest(
    todo: json["todo"],
    completed: json["completed"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "todo": todo,
    "completed": completed,
    "userId": userId,
  };
}
