import 'dart:convert';

AddToDoResponse addToDoResponseFromJson(String str) =>
    AddToDoResponse.fromJson(json.decode(str));

String addToDoResponseToJson(AddToDoResponse data) =>
    json.encode(data.toJson());

class AddToDoResponse {
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  AddToDoResponse({
    this.id,
    this.todo,
    this.completed,
    this.userId,
  });

  factory AddToDoResponse.fromJson(Map<String, dynamic> json) =>
      AddToDoResponse(
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
    if (other is AddToDoResponse) {
      return other.id== id;
    }

    return false;
  }
}
