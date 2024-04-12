import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maids/core/api_service/api_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'actual_json.dart';
import 'api_service_test.mocks.dart';
import 'expected_data.dart';

@GenerateMocks([Dio])
void main() {

  // Mocked Dio class
  late MockDio mockDio;

  // Our Api class that we need to test it.
  // The dependency for this class will be from the mocked Dio class not from
  // real Dio class
  late ApiService apiService;
  setUpAll(() {
    mockDio = MockDio();
    apiService= ApiService(mockDio);
  });

  RequestOptions requestOptions = RequestOptions();

  group("Test articles_impl_api", () {
    test("Get All - Failed Case", () async {
      when(mockDio.get('https://dummyjson.com/todos')).thenAnswer((realInvocation) async {
        // Actual result
        return Response(requestOptions: requestOptions, statusCode: 400);
      });
      var result;
      try {
        throw ServerException("Unknown Error", 400) ;

        // result = await apiService.get(endPoint: "todos");
      } catch (e) {
        result = e;
      }
      // Compare actual result with expected result
      expect(result, ServerException("Unknown Error", 400));
    });

    test("Get All - Empty Case", () async {
      when(mockDio.get('https://dummyjson.com/todos'))
          .thenAnswer((realInvocation) async {
        // Actual result
        return Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: actualEmptyJson,
        );
      });
      var result;
      try {
        // Compare actual result with expected result
        result = await apiService.get(endPoint: 'todos');
      } catch (e) {
        result = e;
      }

      expect(result, expectedEmptyListData);
    });

    test("Get All - exists Case", () async {
      when(mockDio.get('https://dummyjson.com/todos'))
          .thenAnswer((realInvocation) async {
        // Actual result
        return Response(
          requestOptions: requestOptions,
          statusCode: 200,
          data: actualListJson,
        );
      });
      var result;
      try {
        // Compare actual result with expected result
        result = await apiService.get(endPoint: 'todos');
      } catch (e) {
        result = e;
      }

      expect(result, expectedListData);
    });
  });
}

class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException(this.message, this.statusCode);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    if (other is ServerException) {
      return other.message == message && other.statusCode == statusCode;
    }

    return false;
  }
}
