import 'package:dartz/dartz.dart';
import 'package:maids/core/errors/failures.dart';
import 'package:maids/core/network_info.dart';
import 'package:maids/features/pagination/data/data_source/remote_data_source.dart';
import 'package:maids/features/pagination/domain/base_repo/base_repo.dart';
import 'package:maids/features/todo/data/models/get_todos_model.dart';

class Repo extends BaseRepo {
  final RemoteData remoteData;
  final NetworkInfo networkInfo;

  Repo({required this.remoteData,required this.networkInfo});

  @override
  Future<Either<Failure, Todos>> getData(
      {required int pageNumber, required int numberOfPostsPerRequest}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteData.getData(
            numberOfPostsPerRequest: numberOfPostsPerRequest,
            pageNumber: pageNumber);
        return Right(result);
      } on ServerException catch (failure) {
        return left(ServerFailure(failure.message.toString()));
      }
    } else {
      return left(ServerFailure('No Internet Connection'));
    }
  }
}
