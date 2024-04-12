import 'package:dartz/dartz.dart';
import 'package:maids/core/errors/failures.dart';
import 'package:maids/features/todo/data/models/get_todos_model.dart';

Right<Failure, Todos> expectedEmptyListData = Right(Todos(todos: [],skip: 0,total: 0,limit: 0));

Right<Failure, Todos> expectedListData =
    Right(Todos(skip: 2, limit: 2, total: 2, todos: [
  Todo(id: 2, completed: false, userId: 2, todo: 'test'),
  Todo(id: 3, completed: false, userId: 3, todo: 'test1')
]));
