import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:maids/features/authentication/data/models/user_login_request_model.dart';
import 'package:maids/features/authentication/data/repos/auth_repo.dart';

import '../../../data/models/user_login_response_model.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this.authRepo) : super(AuthenticationInitial());
  final AuthRepo authRepo;

  Future<void> loginUser(UserLoginRequest userLoginRequest) async {
    emit(AuthenticationLoading());
    var result = await authRepo.loginUser(userLoginRequest: userLoginRequest);
    print("this the result value: $result");
    result.fold((failure) {
      emit(AuthenticationFailure(failure.errMessage));
    }, (userInfo) {
      emit(AuthenticationSuccess(userInfo));
    });
  }
}
