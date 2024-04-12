part of 'put_todo_cubit.dart';

sealed class PutTodoState extends Equatable {
  const PutTodoState();
}

final class PutTodoInitial extends PutTodoState {
  @override
  List<Object> get props => [];
}

class PutTodoLoading extends PutTodoState {
  @override
  List<Object?> get props => [];
}

class PutTodoSuccess extends PutTodoState {
  final UpdateToDoResponse todos;

  PutTodoSuccess(this.todos);

  @override
  List<Object?> get props => [todos];
}

class PutTodoFailure extends PutTodoState {
  final String errMessage;

  PutTodoFailure(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}

class PutTodoEditing extends PutTodoState {


  @override
  List<Object?> get props => [];
}
