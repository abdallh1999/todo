import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids/core/constants/constants.dart' as colors;
import 'package:maids/features/todo/data/models/add_todo_request_model.dart';
// import 'package:flutter_todo_app/values/colors.dart' as colors;
import 'package:maids/features/todo/data/models/get_todos_model.dart';
import 'package:maids/features/todo/data/models/update_todo_request.dart';
import 'package:maids/features/todo/data/models/update_todo_response.dart';
import 'package:maids/features/todo/presentation/manger/put_todo_cubit/put_todo_cubit.dart';

import 'widgets/button_widget.dart';

class EditTodoView extends StatelessWidget {
  final Todo todo;
  final _textEditingController = TextEditingController();

  EditTodoView({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _textEditingController.text = todo.todo ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
        actions: [
          InkWell(
            // onTap: () =>
            //     BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo),
            onTap: () {
              print(_textEditingController.text);
              context.read<PutTodoCubit>().putToDos(UpdateToDoRequest(todo: _textEditingController.text,completed: true));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.delete),
            ),
          )
        ],
      ),
      body: AddToBody(
        textEditingController: _textEditingController,
      ),
      // floatingActionButton:
    );
  }
}

class AddToBody extends StatelessWidget {
  const AddToBody({super.key, this.textEditingController});

  final textEditingController;

  void _showSnackBar(String content, context, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      backgroundColor: isError ? Colors.redAccent : colors.accentColor,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PutTodoCubit, PutTodoState>(
      builder: (context, state) {
        if (state is PutTodoLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PutTodoSuccess) {
          return Center(child: Text("Edited successfully"));
        } else if (state is PutTodoFailure) {
          return Center(child: Text("this error msg from the server ${state.errMessage}"));
        }
        return BlocListener<PutTodoCubit, PutTodoState>(
          listener: (context, state) {
            if (state is PutTodoSuccess) {
              _showSnackBar('Edited successfully.', context);
              Navigator.pop(context);
            }
            // else if (state is ) {
            //   _showSnackBar('Deleted successfully.', context);
            //   Navigator.pop(context);
            // }
            else if (state is PutTodoFailure) {
              _showSnackBar(state.errMessage, context, isError: true);
            }
          },
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  controller: textEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Title'),
                ),
                ButtonWidget(
                    label: 'Update Todo',
                    onPress: () => context
                        .read<PutTodoCubit>()
                        .putToDos(UpdateToDoRequest() )),
              ],
            ),
          ),
        );
      },
    );
  }
}
