part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
}

final class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class AuthenticationFailure  extends AuthenticationState {
  final String errMessage;

  AuthenticationFailure(this.errMessage);

  @override
  List<Object?> get props =>[errMessage];
}

class AuthenticationSuccess extends AuthenticationState {
  final User user ;

  AuthenticationSuccess(this.user);
  @override
  List<Object?> get props => [user];
}
