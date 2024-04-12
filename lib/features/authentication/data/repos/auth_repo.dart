import 'package:dartz/dartz.dart';
import 'package:maids/core/errors/failures.dart';
import 'package:maids/features/authentication/data/models/user_login_request_model.dart';
import 'package:maids/features/authentication/data/models/user_login_response_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, User>> loginUser(
      {required UserLoginRequest userLoginRequest});

// Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks();
//
// Future<Either<Failure, List<BookModel>>> fetchSimilarBooks(
//     {required String category});
}
