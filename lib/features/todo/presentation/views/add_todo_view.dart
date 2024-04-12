import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maids/features/authentication/presentation/views/widgets/auth_text_field.dart';
import 'package:maids/features/todo/data/models/add_todo_request_model.dart';
import 'package:maids/features/todo/presentation/manger/add_todo_cubit/add_todo_cubit.dart';
import 'package:maids/features/todo/presentation/manger/delete_todo_cubit/delete_todo_cubit.dart';
import 'package:maids/features/todo/presentation/manger/put_todo_cubit/put_todo_cubit.dart';
import 'package:maids/features/todo/presentation/views/widgets/check_widget.dart';

class AddToDoView extends StatelessWidget {
  const AddToDoView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AddToDoViewBody(blo: context.read<AddTodoCubit>(),),
      ),
    );
  }
}

class AddToDoViewBody extends StatelessWidget {
  AddToDoViewBody({ super.key, required this.blo});

  final AddTodoCubit blo;
  final _formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController toDoContentController = TextEditingController();
  TextEditingController completedController = TextEditingController();

  // TextEditingController toDoContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: BlocConsumer<AddTodoCubit, AddTodoState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is AddTodoLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AddTodoFailure) {
              return Center(
                child: Text(state.errMessage),
              );
            } else if (state is AddTodoSuccess) {
              return GestureDetector(
                onTap: () {
                  context.pop(true);
                },
                child: Center(
                  child: Text(state.todos.id.toString() +
                      '\n' +
                      state.todos.todo.toString() +
                      '\n' +
                      state.todos.userId.toString()),
                ),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.1,
                ),
                AuthTextField(
                  labeltext: "id",
                  textController: idController,
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextField(
                  labeltext: "ToDo Content",
                  textController: toDoContentController,
                ),
                SizedBox(
                  height: 10,
                ),

                MYCheckbox(),
                // AuthTextField(
                //   labeltext: "User Name",
                //   textController: completedController,
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // AuthTextField(
                //   labeltext: "password",
                //   textController: passwordController,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // print(userNameController.text);
                       blo.addToDos(AddToDoRequest(
                           todo: toDoContentController.text,
                           completed:
                           context
                               .read<AddTodoCubit>()
                               .isComplete,
                           userId: int.parse(idController.text)));
                        // context.read<AddTodoCubit>().addToDos(AddToDoRequest(
                        //     todo: toDoContentController.text,
                        //     completed:
                        //     context
                        //         .read<AddTodoCubit>()
                        //         .isComplete,
                        //     userId: int.parse(idController.text)));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
    ;
  }
}
