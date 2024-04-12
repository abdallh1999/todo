import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maids/core/router/app_route_constant.dart';
import 'package:maids/features/todo/data/models/get_todos_model.dart';
import 'package:maids/features/todo/presentation/manger/delete_todo_cubit/delete_todo_cubit.dart';
import 'package:maids/features/todo/presentation/views/edit_todo_view.dart';

class TodoListTile extends StatelessWidget {
  const TodoListTile({
    required this.todo,
    super.key,
    this.onToggleCompleted,
    this.onDismissed,
    this.onTap,
  });

  final Todo todo;
  final ValueChanged<bool>? onToggleCompleted;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;

    return Dismissible(
     key: UniqueKey(),
      onDismissed: (d){
       print("objectjl");
       BlocProvider.of<DeleteTodoCubit>(context).deleteToDos(todo.id.toString());
        // context.read<DeleteTodoCubit>().deleteToDos(todo.id.toString());
      },
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: theme.colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(
          Icons.delete,
          color: Color(0xAAFFFFFF),
        ),
      ),
      child: ListTile(
        onTap: (){
          context.push(MyAppRouteConstraint.editTodoRouteName,extra: todo as Todo);
        },
        title: Text(
          todo.todo!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: !todo.completed!
              ? null
              : TextStyle(
            color: captionColor,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        // subtitle: Text(
        //   todo.description,
        //   maxLines: 1,
        //   overflow: TextOverflow.ellipsis,
        // ),
        leading: Checkbox(
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          value: todo.completed,
          onChanged: onToggleCompleted == null
              ? null
              : (value) => onToggleCompleted!(value!),
        ),
        trailing: onTap == null ? null : const Icon(Icons.chevron_right),
      ),
    );
  }
}
