part of 'todo_cubit.dart';

sealed class TodoState extends Equatable {
  const TodoState();
}

final class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {
  @override
  List<Object?> get props => [];
}

class TodoSuccess extends TodoState {
  final Todos todos;

  TodoSuccess(this.todos);
  @override
  List<Object?> get props => [todos];
}

class TodoFailure extends TodoState {
  final String errMessage;

  TodoFailure(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}

