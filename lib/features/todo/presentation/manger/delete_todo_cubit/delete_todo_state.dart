part of 'delete_todo_cubit.dart';

sealed class DeleteTodoState extends Equatable {
  const DeleteTodoState();
}

final class DeleteTodoInitial extends DeleteTodoState {
  @override
  List<Object> get props => [];
}
class DeleteTodoLoading extends DeleteTodoState {
  @override
  List<Object?> get props => [];
}

class DeleteTodoSuccess extends DeleteTodoState {
  final  DeleteToDoResponse deleteToDoResponse;

  DeleteTodoSuccess(this.deleteToDoResponse);
  @override
  List<Object?> get props => [deleteToDoResponse];
}

class DeleteTodoFailure extends DeleteTodoState {
  final String errMessage;

  DeleteTodoFailure(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}

