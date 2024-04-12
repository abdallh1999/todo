part of 'add_todo_cubit.dart';

sealed class AddTodoState extends Equatable {
  const AddTodoState();
}

// final class AddTodoInitial extends AddTodoState {
//   @override
//   List<Object> get props => [];
// }
final class AddTodoInitial extends AddTodoState {
  @override
  List<Object> get props => [];
}

class AddTodoLoading extends AddTodoState {
  @override
  List<Object?> get props => [];
}

class AddTodoSuccess extends AddTodoState {
  final AddToDoResponse todos;

  AddTodoSuccess(this.todos);
  @override
  List<Object?> get props => [todos];
}

class AddTodoFailure extends AddTodoState {
  final String errMessage;

  AddTodoFailure(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}

