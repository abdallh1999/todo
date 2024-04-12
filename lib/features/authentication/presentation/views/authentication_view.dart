import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maids/features/authentication/data/models/user_login_request_model.dart';
import 'package:maids/features/authentication/presentation/manger/auth_cubit/authentication_cubit.dart';
import 'package:maids/features/authentication/presentation/views/widgets/auth_text_field.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: AuthenticationViewBody(),
    ));
  }
}

class AuthenticationViewBody extends StatelessWidget {
  AuthenticationViewBody({super.key});

  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is AuthenticationLoading) {
              return CircularProgressIndicator();
            } else if (state is AuthenticationFailure) {
              return Center(
                child: Text(state.errMessage),
              );
            } else if (state is AuthenticationSuccess) {
              return GestureDetector(
                onTap: (){
                  context.pop(true);
                },
                child: Center(
                    child: Text(state.user.firstName.toString() +
                        '\n' +
                        state.user.email.toString())),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                AuthTextField(
                  labeltext: "User Name",
                  textController: userNameController,
                ),
                SizedBox(
                  height: 10,
                ),
                AuthTextField(
                  labeltext: "password",
                  textController: passwordController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // print(userNameController.text);
                        context.read<AuthenticationCubit>().loginUser(
                            UserLoginRequest(
                                username: userNameController.text,
                                password: passwordController.text));
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
  }
}
