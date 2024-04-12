import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids/core/service_locator/service_locator.dart';
import 'package:maids/features/todo/data/models/get_todos_model.dart';
import 'package:maids/features/todo/presentation/views/todo_view.dart';
// import 'package:ready_pagination/core/services/services_locator.dart';

import '../../data/model/post.dart';
import '../bloc/pagination_bloc.dart';
import '../widgets/error_dialog.dart';
import '../widgets/post_item.dart';

class PaginationView extends StatelessWidget {
  const PaginationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<PaginationBloc>()..add(const LoadPageEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Blog App"),
          centerTitle: true,
        ),
        body: BlocBuilder<PaginationBloc, PaginationState>(
          builder: (context, state) {
            if (context.read<PaginationBloc>().todo.todos!.isEmpty) {
              if (state == PaginationLoadingState()) {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ));
              } else if (state == PaginationErrorState()) {
                return Center(
                    child: errorDialog(
                        size: 20,
                        onPressed: () {
                          context
                              .read<PaginationBloc>()
                              .add(const LoadPageEvent());
                        }));
              }
            }
            return ListView.builder(
                itemCount: context.read<PaginationBloc>().todo.todos!.length +
                    (context.read<PaginationBloc>().isLastPage ? 0 : 1),
                itemBuilder: (context, index) {
                  // request more data when the user has reached the trigger point.
                  context
                      .read<PaginationBloc>()
                      .add(CheckIfNeedMoreDataEvent(index: index));
                  // when the user gets to the last item in the list, check whether
                  // there is an error, otherwise, render a progress indicator.
                  if (index == context.read<PaginationBloc>().todo.todos!.length) {
                    if (state == PaginationErrorState()) {
                      return Center(
                          child: errorDialog(
                              size: 15,
                              onPressed: () {
                                context
                                    .read<PaginationBloc>()
                                    .add(const LoadPageEvent());
                              }));
                    } else {
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      ));
                    }
                  }

                  final Todo todo = context.read<PaginationBloc>().todo.todos![index];
                  return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ToDoWidget(todo:todo));
                });
          },
        ),
      ),
    );
  }
}
