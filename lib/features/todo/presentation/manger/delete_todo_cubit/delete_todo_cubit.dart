import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maids/features/todo/data/models/delete_todo_response_model.dart';
import 'package:maids/features/todo/data/repos/todo_repo.dart';

part 'delete_todo_state.dart';

class DeleteTodoCubit extends Cubit<DeleteTodoState> {
  DeleteTodoCubit(this.todoRepo) : super(DeleteTodoInitial());
  final TodoRepo todoRepo;

  Future<void> deleteToDos(String id) async {
    emit(DeleteTodoLoading());
    var result = await todoRepo.deleteTodos(endPoint: 'todos', toDoId: id);
    print("this the result value: $result");
    result.fold((failure) {
      emit(DeleteTodoFailure(failure.errMessage));
    }, (todos) {
      emit(DeleteTodoSuccess(todos));
    });
  }
}
