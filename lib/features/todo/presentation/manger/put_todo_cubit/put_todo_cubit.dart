import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maids/features/todo/data/models/add_todo_request_model.dart';
import 'package:maids/features/todo/data/models/add_todo_response.dart';
import 'package:maids/features/todo/data/models/update_todo_request.dart';
import 'package:maids/features/todo/data/models/update_todo_response.dart';
import 'package:maids/features/todo/data/repos/todo_repo.dart';

part 'put_todo_state.dart';

class PutTodoCubit extends Cubit<PutTodoState> {
  PutTodoCubit(this.todoRepo) : super(PutTodoInitial());
  final TodoRepo todoRepo;

  Future<void> putToDos(UpdateToDoRequest toDoData) async {
    emit(PutTodoLoading());
    var result = await todoRepo.updateTodos(
        endPoint: 'todos', todoData: toDoData,id: '1');
    print("this the result value: $result");
    result.fold((failure) {

      emit(PutTodoFailure(failure.errMessage));
    }, (todos) {
      emit(PutTodoSuccess(todos));
    });
  }
}
