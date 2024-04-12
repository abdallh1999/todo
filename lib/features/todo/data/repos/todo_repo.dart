import 'package:dartz/dartz.dart';
import 'package:maids/core/errors/failures.dart';
import 'package:maids/features/authentication/data/models/user_login_response_model.dart';
import 'package:maids/features/todo/data/models/add_todo_request_model.dart';
import 'package:maids/features/todo/data/models/add_todo_response.dart';
import 'package:maids/features/todo/data/models/delete_todo_response_model.dart';
import 'package:maids/features/todo/data/models/get_todos_model.dart';
import 'package:maids/features/todo/data/models/update_todo_request.dart';
import 'package:maids/features/todo/data/models/update_todo_response.dart';

abstract class TodoRepo {
  Future<Either<Failure, Todos>> getTodos({required String endPoint});

  Future<Either<Failure, AddToDoResponse>> addTodos({
    required AddToDoRequest toDoData,
    required String endpoint,
  });

  Future<Either<Failure, DeleteToDoResponse>> deleteTodos({
    required String endPoint,
    required String toDoId,
  });

  Future<Either<Failure, UpdateToDoResponse>> updateTodos(
      {required String endPoint,

      required UpdateToDoRequest todoData,required String id});

// Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks();
//
// Future<Either<Failure, List<BookModel>>> fetchSimilarBooks(
//     {required String category});
}
