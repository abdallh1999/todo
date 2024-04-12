import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maids/core/local_storage/local_storage.dart';
import 'package:maids/core/network_info.dart';
import 'package:maids/core/service_locator/service_locator.dart';
import 'package:maids/features/todo/data/models/get_todos_model.dart';
import 'package:maids/features/todo/data/repos/todo_repo.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit(this.todoRepo) : super(TodoInitial());
  final TodoRepo todoRepo;
  final storage = getIt.get<LocalStorage>();
  final networkInfo = getIt.get<NetworkInfo>();

  Future<void> getToDos() async {
    emit(TodoLoading());

    if (await networkInfo.isConnected) {
      // emit(TodoLoading());
      var result = await todoRepo.getTodos(endPoint: 'todos');
      print("this the result value: $result");
      result.fold((failure) {
        emit(TodoFailure(failure.errMessage));
      }, (todos) {
        emit(TodoSuccess(todos));
        storage.saveTodo(
            todos.todos!.map((item) => jsonEncode(item.toJson())).toList());
        print(todos.todos!.map((item) => jsonEncode(item.toJson())).toList());
      });
    } else {
      // emit(TodoLoading());

      List<String>? listString = storage.getTodos();
      print(listString);
      List<Todo>? list =
          listString?.map((item) => Todo.fromJson(json.decode(item))).toList();
      if (list != null) {

        emit(TodoSuccess(Todos(todos: list)));
      }else{
        TodoFailure("something went wrong from local Database");
      }
    }
  }
}
