import 'package:flutter_test/flutter_test.dart';
import 'package:maids/core/api_service/api_service.dart';
import 'package:maids/features/todo/data/models/add_todo_request_model.dart';
import 'package:maids/features/todo/data/models/add_todo_response.dart';
import 'package:maids/features/todo/data/models/delete_todo_response_model.dart';
import 'package:maids/features/todo/data/models/update_todo_request.dart';
import 'package:maids/features/todo/data/models/update_todo_response.dart';
import 'package:maids/features/todo/data/repos/todo_repo_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'actual_data.dart';
import 'expected_data.dart';
import 'todo_repo_impl_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  // Mocked ArticlesImplApi class
  late MockApiService mockApiService;

  // Our Repository class that we need to test it.
  // The dependency for this class will get from the mocked ArticlesImplApi class not from
  // real ArticlesImplApi class
  late ToDoRepoImpl toDoRepoImpl;
  setUp(() {
    mockApiService = MockApiService();
    toDoRepoImpl = ToDoRepoImpl(mockApiService);
  });

  group("Test rep_impl", () {
    test("Get All todos- Failed Case, Empty Or Null Api response", () async {
      when(mockApiService.get(endPoint: 'todos'))
          .thenAnswer((realInvocation) async {
        return actualEmptyJson;
      });
      var result;
      try {
        result = await toDoRepoImpl.getTodos(endPoint: 'todos');
      } catch (e) {
        print(e.toString());
        result = e;
      }
      expect(result.value, expectedEmptyListData.value);
    });

    test("Get All todos- Success Case", () async {
      when(mockApiService.get(endPoint: 'todos'))
          .thenAnswer((realInvocation) async {
        return actualListJson;
      });
      var result;
      try {
        result = await toDoRepoImpl.getTodos(endPoint: 'todos');
      } catch (e) {
        print(e.toString());
        result = e;
      }
      expect(result.value, expectedListData.value);
    });
    test("post todo- Success Case", () async {
      when(mockApiService.post(
              endPoint: 'todos/add',
              data: AddToDoRequest(todo: 'test', completed: true, userId: 1)
                  .toJson()))
          .thenAnswer((realInvocation) async {
        return AddToDoResponse(id: 1, userId: 1, completed: true, todo: 'test')
            .toJson();
      });
      var result;
      try {
        result = await toDoRepoImpl.addTodos(
            endpoint: '/add',
            toDoData: AddToDoRequest(todo: 'test', completed: true, userId: 1));
      } catch (e) {
        print(e.toString());
        result = e;
      }
      expect(result.value,
          AddToDoResponse(id: 1, userId: 1, completed: true, todo: 'test'));
    });
    test("edit todo- Success Case", () async {
      when(
        mockApiService.put(
          data: UpdateToDoRequest(todo: 'test', completed: true).toJson(),
          endPoint: 'todos',
          id: '1',
        ),
      ).thenAnswer((realInvocation) async {
        return UpdateToDoResponse(
                id: 1, userId: 1, completed: true, todo: 'test')
            .toJson();
      });
      var result;
      try {
        result = await toDoRepoImpl.updateTodos(
            id: '1',
            endPoint: '',
            todoData: UpdateToDoRequest(todo: 'test', completed: true));
      } catch (e) {
        print(e.toString());
        result = e;
      }
      expect(result.value,
          UpdateToDoResponse(id: 1, userId: 1, completed: true, todo: 'test'));
    });
    test("delete todo- Success Case", () async {
      when(
        mockApiService.delete(
          endPoint: 'todos',
          id: '1',
        ),
      ).thenAnswer((realInvocation) async {
        return DeleteToDoResponse(id: 1, userId: 1, completed: true, todo: 'test',deletedOn: 'test')  .toJson();
      });
      var result;
      try {
        result = await toDoRepoImpl.deleteTodos(endPoint: '', toDoId: '1');
      } catch (e) {
        print(e.toString());
        result = e;
      }
      expect(result.value,
          DeleteToDoResponse(id: 1, userId: 1, completed: true, todo: 'test',deletedOn: 'test'));
    });
  });
}
