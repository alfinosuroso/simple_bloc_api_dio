part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoaded extends UserState {
  final List<UserModel> userModel;
  const UserLoaded(this.userModel);

  @override
  List<Object> get props => [userModel];
}

class UserDetailLoaded extends UserState {
  final UserModel userModel;
  const UserDetailLoaded(this.userModel);

  @override
  List<Object> get props => [userModel];
}

class UserError extends UserState {
  final String message;
  const UserError(this.message);

  @override
  List<Object> get props => [message];
}
