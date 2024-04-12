import 'dart:convert';

UpdateToDoRequest  addToDoResponseFromJson(String str) =>
    UpdateToDoRequest.fromJson(json.decode(str));

String addToDoResponseToJson(UpdateToDoRequest data) =>
    json.encode(data.toJson());

class UpdateToDoRequest {
  String? todo;
  bool? completed;

  UpdateToDoRequest({
    this.todo,
    this.completed,
  });

  factory UpdateToDoRequest.fromJson(Map<String, dynamic> json) =>
      UpdateToDoRequest(
        todo: json["todo"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
    "todo": todo,
    "completed": completed,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (other is UpdateToDoRequest) {
      return other.todo== todo;
    }

    return false;
  }
}
