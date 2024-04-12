import 'package:dartz/dartz.dart';
import 'package:maids/core/errors/failures.dart';
import 'package:maids/features/todo/data/models/get_todos_model.dart';

import '../../data/model/post.dart';

abstract class BaseRepo{
  Future<Either<Failure, Todos>> getData({required int pageNumber, required int numberOfPostsPerRequest});
}