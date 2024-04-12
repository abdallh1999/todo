import 'package:dartz/dartz.dart';
import 'package:maids/core/errors/failures.dart';
import 'package:maids/features/todo/data/models/get_todos_model.dart';

import '../../data/model/post.dart';
import '../base_repo/base_repo.dart';

class GetDataUseCase {
  final BaseRepo baseRepo;

  GetDataUseCase({required this.baseRepo});

  Future<Either<Failure, Todos>> call(
      {required int pageNumber, required int numberOfPostsPerRequest}) async {
    return await baseRepo.getData(
        numberOfPostsPerRequest: numberOfPostsPerRequest,
        pageNumber: pageNumber);
  }
}
