import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids/core/errors/failures.dart';
import 'package:maids/features/todo/data/models/get_todos_model.dart';
import '../../../pagination/domain/usecase/use_case.dart';

import '../../data/model/post.dart';

part 'pagination_event.dart';
part 'pagination_state.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  final GetDataUseCase getDataUseCase;

  bool isLastPage = false;
  int pageNumber = 0;
  final int numberOfPostsPerRequest = 5;
  Todos todo=Todos(todos: [])  ;
  final int nextPageTrigger = 3;

  PaginationBloc(this.getDataUseCase) : super(PaginationInitialState()) {
    on<LoadPageEvent>((event, emit) async {
      emit(PaginationLoadingState());
      try {
        final Either<Failure, Todos> result = await getDataUseCase(
          numberOfPostsPerRequest: numberOfPostsPerRequest,
          pageNumber: pageNumber,
        );
        result.fold((l) {
          print("error --> $l");
          emit(PaginationErrorState());
        }, (TodoList) {
          isLastPage = TodoList.todos!.length< numberOfPostsPerRequest;
          pageNumber = pageNumber + 1;

          todo.todos?.addAll(TodoList.todos as Iterable<Todo>);
          print('DDDDDDDDDDDDDD');
          emit(PaginationLoadedState());
        });
      } catch (e) {
        print("error --> $e");
        emit(PaginationErrorState());
      }
    });
    on<CheckIfNeedMoreDataEvent>((event, emit) async {
      emit(PaginationLoadingState());
      if (event.index == todo.todos!.length - nextPageTrigger) {
        add(const LoadPageEvent());
      }
    });
  }
}
