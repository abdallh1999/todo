import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maids/features/todo/data/models/add_todo_request_model.dart';
import 'package:maids/features/todo/data/models/add_todo_response.dart';
import 'package:maids/features/todo/data/repos/todo_repo.dart';

part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  AddTodoCubit(this.todoRepo) : super(AddTodoInitial());

  final TodoRepo todoRepo;
  bool isComplete=false;
  Future<void> addToDos(AddToDoRequest toDoData) async {
    emit(AddTodoLoading());
    var result = await todoRepo.addTodos(
         toDoData:toDoData, endpoint: '/add' );
    print("this the result value: $result");
    result.fold((failure) {

      emit(AddTodoFailure(failure.errMessage));
    }, (todos) {
      // print(todos.todo);
      emit(AddTodoSuccess(todos));
    });
  }

}
