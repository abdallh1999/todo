import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maids/core/api_service/api_endpoints.dart';
import 'package:maids/core/api_service/api_service.dart';
import 'package:maids/core/errors/failures.dart';
import 'package:maids/features/authentication/data/models/user_login_request_model.dart';
import 'package:maids/features/authentication/data/models/user_login_response_model.dart';
import 'package:maids/features/authentication/data/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;

  AuthRepoImpl(this.apiService);

  @override
  Future<Either<Failure, User>> loginUser(
      {required UserLoginRequest userLoginRequest}) async {
    try {
      var data = await apiService.post(
          endPoint: ApiEndPoints.login, data: userLoginRequest.toJson());
      print("this data: $data");
      User user = User.fromJson(data);

      print("this user: $user");
      return right(user);
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
