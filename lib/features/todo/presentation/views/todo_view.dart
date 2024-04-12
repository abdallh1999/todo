import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maids/core/router/app_route_constant.dart';
import 'package:maids/core/widgets/todo_tile.dart';
import 'package:maids/features/todo/data/models/get_todos_model.dart';
import 'package:maids/features/todo/presentation/manger/add_todo_cubit/add_todo_cubit.dart';
import 'package:maids/features/todo/presentation/manger/all_todo_cubit/todo_cubit.dart';
import 'package:maids/features/todo/presentation/manger/delete_todo_cubit/delete_todo_cubit.dart';
import 'package:maids/features/todo/presentation/manger/put_todo_cubit/put_todo_cubit.dart';

class ToDoView extends StatelessWidget {
  const ToDoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ToDoViewBody(),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
                onPressed: () {
                  context.push(MyAppRouteConstraint.addToDoRouteName,
                      extra: BlocProvider.of<AddTodoCubit>(context));
                },
                child: Icon(Icons.add)),
            // FloatingActionButton(
            //   onPressed: () {
            //     context.push(MyAppRouteConstraint.editTodoRouteName);
            //   },
            //   child: Icon(Icons.edit),
            // ),
          ],
        ),
      ),
    );
  }
}

class ToDoViewAppBar extends StatelessWidget {
  const ToDoViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ToDoViewBody extends StatelessWidget {
  const ToDoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DeleteTodoCubit, DeleteTodoState>(
          listener: (context, state) {
            if (state is DeleteTodoSuccess) {
              print("delete works");
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("deleted successfully")));
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("deleted faild")));
            }
            // TODO: implement listener
          },
        ),
      ],
      child: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TodoFailure) {
            return Center(
              child: Text(state.errMessage),
            );
          } else if (state is TodoSuccess) {
            final todos = state.todos.todos;

            return SingleChildScrollView(
              child: Column(
                children: todos!
                    .map((e) => TodoListTile(
                          todo: e,
                        ))
                    .toList(),
              ),
            );
          }

          return Center(
            child: Text("something went wrong"),
          );
        },
      ),
    );
  }
}

class ToDoWidget extends StatelessWidget {
  const ToDoWidget({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          context.push(MyAppRouteConstraint.editTodoRouteName, extra: todo),
      child: Dismissible(
        key: Key(todo.id.toString()),
        child: ToDoTile(
          todo: todo,
        ),
        confirmDismiss: (_) async {
          // BlocProvider.of<TodoCubit>(context).changeCompletionStatus(todo);
          return false;
        },
        background: Container(
          color: Colors.indigo,
        ),
      ),
    );
  }
}

class ToDoTile extends StatelessWidget {
  const ToDoTile({super.key, this.todo});

  final todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(todo.todo ?? ''), CompletionIndicator(todo: todo)],
      ),
    );
  }
}

class CompletionIndicator extends StatelessWidget {
  const CompletionIndicator({super.key, this.todo});

  final todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(
              width: 4.0,
              color: (todo.completed ?? false) ? Colors.green : Colors.red)),
    );
  }
}
