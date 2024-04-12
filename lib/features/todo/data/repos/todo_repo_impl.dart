import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maids/core/api_service/api_endpoints.dart';
import 'package:maids/core/api_service/api_service.dart';
import 'package:maids/core/errors/failures.dart';
import 'package:maids/features/todo/data/models/add_todo_request_model.dart';
import 'package:maids/features/todo/data/models/add_todo_response.dart';
import 'package:maids/features/todo/data/models/delete_todo_response_model.dart';
import 'package:maids/features/todo/data/models/get_todos_model.dart';
import 'package:maids/features/todo/data/models/update_todo_request.dart';
import 'package:maids/features/todo/data/models/update_todo_response.dart';
import 'package:maids/features/todo/data/repos/todo_repo.dart';

class ToDoRepoImpl implements TodoRepo {
  final ApiService apiService;

  ToDoRepoImpl(this.apiService);

  @override
  Future<Either<Failure, AddToDoResponse>> addTodos(
      {required AddToDoRequest toDoData, required String endpoint}) async {
    try {
      var data = await apiService.post(
          endPoint: ApiEndPoints.todos + endpoint, data: toDoData.toJson());
      print("this data: $data");
      AddToDoResponse todos = AddToDoResponse.fromJson(data);

      print("this user: $todos");
      return right(todos);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, DeleteToDoResponse>> deleteTodos(
      {required String endPoint, required String toDoId}) async {
    try {
      var data = await apiService.delete(
        endPoint: ApiEndPoints.todos,
        id: toDoId,
      );
      print("this data: $data");
      DeleteToDoResponse todos = DeleteToDoResponse.fromJson(data);

      print("this user: $todos");
      return right(todos);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Todos>> getTodos({required String endPoint}) async {
    try {
      var data = await apiService.get(endPoint: ApiEndPoints.todos);
      print("this data: $data");
      Todos todos = Todos.fromJson(data);

      print("this user: $todos");
      return right(todos);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UpdateToDoResponse>> updateTodos(
      {required String endPoint,
      required UpdateToDoRequest todoData,required String id
      }) async {
    try {
      var data = await apiService.put(
          endPoint: ApiEndPoints.todos, data: todoData.toJson(), id: id);
      print("this data: $data");
      UpdateToDoResponse todos = UpdateToDoResponse.fromJson(data);

      print("this user: $todos");
      return right(todos);
    } catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}
