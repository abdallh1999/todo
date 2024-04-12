import 'dart:convert';

import 'package:maids/core/api_service/api_service.dart';
import 'package:maids/core/errors/failures.dart';
import 'package:maids/features/todo/data/models/get_todos_model.dart';

import '../model/post.dart';

abstract class RemoteData {
  Future<Todos> getData(
      {required int pageNumber, required int numberOfPostsPerRequest});
}

class RemoteDataImpl extends RemoteData {
  final ApiService apiService;

  RemoteDataImpl(this.apiService);

  @override
  Future<Todos> getData(
      {required int pageNumber, required int numberOfPostsPerRequest}) async {
    final response = await apiService.get(
        endPoint: Uri.parse("todos?limit=$numberOfPostsPerRequest&skip=10").toString());

    try {
      // List responseList = json.decode(response);
      Todos TodosList = Todos.fromJson(response);

      return TodosList;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
