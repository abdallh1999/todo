import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maids/core/service_locator/service_locator.dart';
import 'package:maids/features/authentication/presentation/views/authentication_view.dart';
import 'package:maids/features/pagination/ui/view/page_screen.dart';
import 'package:maids/features/todo/data/models/get_todos_model.dart';
import 'package:maids/features/todo/data/repos/todo_repo.dart';
import 'package:maids/features/todo/presentation/manger/add_todo_cubit/add_todo_cubit.dart';
import 'package:maids/features/todo/presentation/manger/all_todo_cubit/todo_cubit.dart';
import 'package:maids/features/todo/presentation/manger/delete_todo_cubit/delete_todo_cubit.dart';
import 'package:maids/features/todo/presentation/manger/put_todo_cubit/put_todo_cubit.dart';
import 'package:maids/features/todo/presentation/views/add_todo_view.dart';
import 'package:maids/features/todo/presentation/views/edit_todo_view.dart';
import 'package:maids/features/todo/presentation/views/todo_view.dart';

import 'app_route_constant.dart';

final router = GoRouter(
  initialLocation: MyAppRouteConstraint.todoRouteName,
  routes: <RouteBase>[
    GoRoute(
      path: MyAppRouteConstraint.authenticationRouteName,
      builder: (context, state) => AuthenticationView(),
    ),
    GoRoute(
      path: MyAppRouteConstraint.todoRouteName,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TodoCubit(getIt.get<TodoRepo>())..getToDos(),
          ),
          BlocProvider(
            create: (context) => AddTodoCubit(getIt.get<TodoRepo>()),
          ),
          BlocProvider(
            lazy: false,
            create: (context) => DeleteTodoCubit(
              getIt.get<TodoRepo>(),
            ),
            // child: ToDoView(),
          ),
          BlocProvider(
            create: (context) => PutTodoCubit(getIt.get<TodoRepo>()),
          ),
        ],
        child: ToDoView(),
      ),
    ),
    GoRoute(
      path: MyAppRouteConstraint.addToDoRouteName,
      builder: (context, state) => BlocProvider.value(
        value: state.extra! as AddTodoCubit,
        child: AddToDoView(),
      ),
    ),
    GoRoute(
      path: MyAppRouteConstraint.editTodoRouteName,
      builder: (context, state) => BlocProvider(
        create: (context) => PutTodoCubit(getIt.get<TodoRepo>()),
        child: EditTodoView(todo: state.extra as Todo),
      ),
    ),
    // GoRoute(
    //   path: MyAppRouteConstraint.todoRouteName,
    //   builder: (context, state) => MultiBlocProvider(
    //     providers: [
    //       BlocProvider(
    //         create: (context) => AddTodoCubit(getIt.get<TodoRepo>()),
    //       ),
    //       BlocProvider(
    //         lazy: false,
    //         create: (context) => DeleteTodoCubit(
    //           getIt.get<TodoRepo>(),
    //         ),
    //         child:  ToDoView(),
    //       ),
    //       BlocProvider(
    //         create: (context) => PutTodoCubit(getIt.get<TodoRepo>()),
    //       ),
    //     ],
    //     child: ToDoView(),
    //   ),
    // ),
    GoRoute(
      path: MyAppRouteConstraint.paginationRouteName,
      builder: (context, state) => PaginationView(),
    ),
  ],
);
