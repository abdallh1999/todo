import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maids/core/service_locator/service_locator.dart';
import 'package:maids/features/authentication/data/repos/auth_repo.dart';
import 'package:maids/features/authentication/presentation/manger/auth_cubit/authentication_cubit.dart';

import 'core/router/router.dart';

Future<void> main() async {
  await setupServiceLocator();
  await AppServiceLocator.initAppServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(getIt.get<AuthRepo>()),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
